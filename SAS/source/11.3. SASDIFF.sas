%macro SASDIFF( FILEIN1              /* name of original file to compare for differences                           */
              , FILEIN2              /* name of new      file to compare for differences                           */
              , FLOW=N               /* [optional] wrap long lines of text to show complete text                   */
              , IGNORE_WHITE_SPACE=Y /* [optional] ignore white space when comparing lines                         */
              , IGNORE_BLANK_LINES=Y /* [optional] ignore changes that just insert or delete blank lines           */
              , IGNORE_CASE=Y        /* [optional] ignore changes in case. consider UPPER and lower to be the same */
              , IGNORE_MATCHES=N     /* [optional] ignore matching lines                                           */
              , LINESIZE=            /* [optional] linesize for display of text (default=system linesize)          */
              , WINDOW=10            /* search +/- &WINDOW lines above/below current line for match                */
              ) ;

   /* PURPOSE: perform differential file comparison using a subset of UNIX sdiff commands
    *
    * NOTE:    &FILEIN1 and &FILEIN2 must be text strings containing path/filename
    *
    * NOTE:    &WINDOW represents the maximum number of lines to look before or after the current line
    *          in the original file being matched in the new file, or vice-versa.
    *          &WINDOW ought to be adjusted to the value displayed in the log.
    *          it may be necessary to run %SASDIFF multiple times until &WINDOW remains constant between runs.
    *
    * NOTE:    the labelling convention for indicating source of text from &FILEIN1 or &FILEIN2 is:
    *          '<' indicates that line of text comes from &FILEIN1 and not &FILEIN2
    *          '>'                                        &FILEIN2 and not &FILEIN1
    *          '|'                                        &FILEIN1 and     &FILEIN2 but is changed
    *          ' '                                        &FILEIN1 and     &FILEIN2 and is identical 
    *
    * EXAMPLE OF USE:
    *    %let FILE1 = C:\Documents and Settings\rosbet\My Documents\My SAS Files\9.1\Macros\sasdiff_v0.sas ;
    *    %let FILE2 = C:\Documents and Settings\rosbet\My Documents\My SAS Files\9.1\Macros\sasdiff_v1.sas ;
    *
    *    %SASDIFF( &FILE1, &FILE2, ignore_blank_lines=n, ignore_matches=y )
    */

   /* process macro parameter flags */

   %let FLG_FLOW               = %index( %upcase( &FLOW              , Y )) ;
   %let FLG_IGNORE_MATCHES     = %index( %upcase( &IGNORE_MATCHES    , Y )) ;
   %let FLG_IGNORE_BLANK_LINES = %index( %upcase( &IGNORE_BLANK_LINES, Y )) ;
   %let FLG_IGNORE_CASE        = %index( %upcase( &IGNORE_CASE       , Y )) ;
   %let FLG_IGNORE_WHITE_SPACE = %index( %upcase( &IGNORE_WHITE_SPACE, Y )) ;

   /*############################################################################*/
   /* begin executable statements
   /*############################################################################*/

   /* clear pre-existing file references, assign new ones */

   filename file1 clear ;
   filename file2 clear ;

   filename file1 "&FILEIN1" ;
   filename file2 "&FILEIN2" ;

   data _null_ ;
      length fname1 fname2 $ 80 ;

      fname1 = reverse( scan( reverse( "&FILEIN1" ), 1, '/\' )) ;
      fname2 = reverse( scan( reverse( "&FILEIN2" ), 1, '/\' )) ;

      call symput( 'FNAME1', fname1 ) ;
      call symput( 'FNAME2', fname2 ) ;
   run ;

   /* verify validity of physical filename. err-out if non-zero return code */

   %if %sysfunc( fileref( FILE1 )) %then %goto ERROR_PATH1 ;
   %if %sysfunc( fileref( FILE2 )) %then %goto ERROR_PATH2 ;

   /*==================================================================*/
   /* read lines of text into SAS dataset format
   /* apply parameter settings to text
   /*==================================================================*/

   data dsn1 ;
      length line1 text1 $ 32767 ;
      retain maxreclen -1 ;

      infile FILE1 eof=lastobs length=reclen lrecl=32767 truncover ;

      input text1 $varying32767. reclen ;

      %if &FLG_IGNORE_BLANK_LINES %then %str( if lengthn( compress( text1,, 's' )) ; ) ;

      linenum1 + 1 ;

      line1 = %if &FLG_IGNORE_CASE %then %str( upcase( text1 ) ; ) ; %else %str( text1 ; ) ;

      %if &FLG_IGNORE_WHITE_SPACE %then %str( line1 = compress( line1,, 's' ) ; ) ;

      maxreclen = max( maxreclen, reclen ) ;

      return ;

LASTOBS: 
      call symput( 'N_OBS1' , put( linenum1 , best12. )) ;

      call symput( 'MAXLEN1', put( maxreclen, 5. )) ;

      drop maxreclen ;
   run ;

   data dsn2 ;
      length line2 text2 $ 32767 ;
      retain maxreclen -1 ;

      infile FILE2 eof=lastobs length=reclen lrecl=32767 truncover ;

      input text2 $varying32767. reclen ;

      %if &FLG_IGNORE_BLANK_LINES %then %str( if lengthn( compress( text2,, 's' )) ; ) ;

      linenum2 + 1 ;

      line2 = %if &FLG_IGNORE_CASE %then %str( upcase( text2 ) ; ) ; %else %str( text2 ; ) ;

      %if &FLG_IGNORE_WHITE_SPACE %then %str( line2 = compress( line2,, 's' ) ; ) ;

      maxreclen = max( maxreclen, reclen ) ;

      return ;

LASTOBS:
      call symput( 'N_OBS2' , put( linenum2 , best12. )) ;

      call symput( 'MAXLEN2', put( maxreclen, 5. )) ;

      drop maxreclen ;
   run ;

   /*==================================================================*/
   /* perform differential file comparison
   /*
   /* note: PROC REPORT linesize must be between 64 and 256
   /*==================================================================*/

   %let MAXLEN = %sysfunc( max( &MAXLEN1, &MAXLEN2 )) ;
   %let MAXOBS = %eval( &N_OBS1 + &N_OBS2 ) ; /* if both dsn1 and dsn2 are completely disjoint */

   data diff1( keep= linenum1 line_dsn1 line_dsn2 line1 text1 ) diff2( keep= linenum2 line_dsn1 line_dsn2 line2 text2 ) ;
      array match1[ &MAXOBS ] _temporary_ ( &MAXOBS * 0 ) ;
      array match2[ &MAXOBS ] _temporary_ ( &MAXOBS * 0 ) ;

      /* find subset of dsn2 in dsn1 */

      do i = 1 to &N_OBS1 ;
         line_dsn1 = i ;

         set dsn1 point=i ; /* read line1, text1 from dsn1 into Program Data Vector */

         /* if no match on previous search, set line_dsn2 = missing */

         match = 0 ;

         do j = 1 to &N_OBS2 ;
            line_dsn2 = . ; /* assume no match */

            if ^match2[ j ] /* check only dsn2 lines that have not been previously matched */
            then do ;
               set dsn2 point=j ; /* add line2, text2 from dsn2 to PDV */

               /* test for equality. if match, save respective line positns, leave loop */

               match = ( line1 = line2 ) & ( abs( i - j ) <= &WINDOW ) ;

               if match then do ; line_dsn2 = j ; match2[ j ] = 1 ; leave ; end ;
            end ;
         end ;

         output diff1 ;
      end ;

      /* find subset of dsn1 in dsn2 */

      do j = 1 to &N_OBS2 ;
         line_dsn2 = j ;

         set dsn2 point=j ;

         match = 0 ;

         do i = 1 to &N_OBS1 ;
            line_dsn1 = . ;

            if ^match1[ i ]
            then do ;
               set dsn1 point=i ;

               match = ( line1 = line2 ) & ( abs( j - i ) <= &WINDOW ) ;

               if match then do ; line_dsn1 = i ; match1[ i ] = 1 ; leave ; end ;
            end ;
         end ;

         output diff2 ;
      end ;

      stop ; /* to prevent infinite loop since data step iterates */
   run ;

   /* if blank line, set pointer to missing to force inclusion in output dataset */

   data diff1 ; set diff1 ; if ^lengthn( text1 ) then line_dsn2 = . ; run ;
   data diff2 ; set diff2 ; if ^lengthn( text2 ) then line_dsn1 = . ; run ;

   data diff12 ;
      retain rec_ptr1 rec_ptr2 1 ;

      do until( lastobs1 & lastobs2 ) ;
         /* read a record from diff1, diff2
          * determine match or non-matching subset
          * output
          */

         if ^lastobs1 then set diff1( rename=( line_dsn2=diff1_line_dsn2 )) point = rec_ptr1 ;

         if ^lastobs2 then set diff2( rename=( line_dsn1=diff2_line_dsn1 )) point = rec_ptr2 ;

		 state = 10 * missing( diff1_line_dsn2 ) + missing( diff2_line_dsn1 ) ;

		 select( state ) ;
		 when( 00 ) do ; rec_ptr1 + ^lastobs1 ; rec_ptr2 + ^lastobs2      ; output ; end ; /*  text1 &  text2 */
		 when( 01 ) do ; linenum1 = . ; text1 = '' ; rec_ptr2 + ^lastobs2 ; output ; end ; /* ^text1 &  text2 */
		 when( 10 ) do ; linenum2 = . ; text2 = '' ; rec_ptr1 + ^lastobs1 ; output ; end ; /*  text1 & ^text2 */
		 when( 11 ) do ;
						rec_ptr1 + ^lastobs1 ; rec_ptr2 + ^lastobs2 ;

						text1 = ifc( text1 = lag( text1 ), '', text1 ) ;
		 				text2 = ifc( text2 = lag( text2 ), '', text2 ) ;

						output ;
					end ; /* ^text1 & ^text2 */
		 otherwise putlog '>>> ERROR: ought not to occur' ;
		 end ;

		 lastobs1 = rec_ptr1 > &N_OBS1 ; lastobs2 = rec_ptr2 > &N_OBS2 ;

         /* compute max size of comparison window */

         if ^missing( diff1_line_dsn2 ) & ^missing( diff2_line_dsn1 )
         then max_diff = max(  abs( diff1_line_dsn2 - diff2_line_dsn1 ), max_diff ) ;
      end ;

      putlog 'NOTE: Maximum difference for comparison window = ' max_diff ;

      stop ;
   run ;

   /*==================================================================*/
   /* report results of comparing original to new file
   /*==================================================================*/

   %let COLWIDTH = %sysfunc( ceil( %sysfunc( log10( &MAXOBS )))) ;

   data diff ;
      length lineno1 lineno2 $ &COLWIDTH source $ 1 text1 text2 $ &MAXLEN ;

      do i = 1 to n_obs ;
         set diff12( keep= linenum: line: text: ) nobs=n_obs point = i ;


         if  lengthn( text1 ) & ^lengthn( text2 )                      then source = '<' ; else
         if ^lengthn( text1 ) &  lengthn( text2 )                      then source = '>' ; else
         if  lengthn( text1 ) &  lengthn( text2 ) & ( text1  = text2 ) then source = ' ' ; else
         if  lengthn( text1 ) &  lengthn( text2 ) & ( text1 ^= text2 ) then source = '|' ;

         %if &FLG_IGNORE_MATCHES %then %str( if missing( source ) then continue ; ) ;

         lineno1 = ifc( source = '>', ' ', put( linenum1, &COLWIDTH.. )) ;
         lineno2 = ifc( source = '<', ' ', put( linenum2, &COLWIDTH.. )) ;

         output ;
      end ;

      stop ;

      drop linenum: ;
   run ;

   %if &FLG_FLOW %then %let FLOW = flow ; %else %let FLOW = ;

   %if ^%length( &LINESIZE ) %then %let LINESIZE = %sysfunc( getoption( LS )) ;

   /* "- 5" because spacing=1 btwn 4 columns and source char requires 1 column */

   %let WIDTH = %sysfunc( min( &MAXLEN, %sysevalf( .5 *( &LINESIZE - 2 * &COLWIDTH - 5 ), integer ))) ;

   title '%SASDIFF Differential File Comparison' ;
   proc report data=diff headline headskip ls=&LINESIZE nowindows spacing=1 split='`' ;
      column lineno1 text1 source text2 lineno2 ;

      define lineno1  / display width=&COLWIDTH    " "              ;
      define text1    / display &FLOW width=&WIDTH "%trim(&FNAME1)" ;
      define source   / display       width=1      " "              ;
      define text2    / display &FLOW width=&WIDTH "%trim(&FNAME2)" ;
      define lineno2  / display width=&COLWIDTH    " "              ;
   run ;
   title ;

   %goto L9999 ;

%ERROR_PATH1:
   %put %sysfunc( sysmsg()) ;
   %goto L9999 ;

%ERROR_PATH2:
   %put %sysfunc( sysmsg()) ;
   %goto L9999 ;

%L9999: /* exit the macro */

   proc datasets library=work nolist ; delete diff diff1 diff2 diff12 dsn1 dsn2 ; quit ;

%mend SASDIFF ;
