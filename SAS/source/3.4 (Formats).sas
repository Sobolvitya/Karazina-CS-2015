/*http://www.ats.ucla.edu/stat/sas/library/formats.htm*/
/*http://support.sas.com/publishing/pubcat/chaps/59498.pdf*/
/*http://www2.sas.com/proceedings/sugi27/p101-27.pdf*/

data temp;
input employee_id jobcat $ birthdate wage rating ;
cards;
1254 one 14120 11000 2
9936 two 14169 5000 0
7529 two 14187 9000 1
9154 one 14208 10000 2
7741 two 14201 9500 3
8896 two 14163 9600 4
6658 one 14365 12000 4
7854 two 14179 9600 3
9458 two 14196 8999 1
7887 two 14171 9050 0
;
run;

proc print data = temp; title "Unformatted data";
run;

/*================================================================================================*/
/*==========================   SIMPLE FORMAT   ===================================================*/
/*================================================================================================*/
proc print data = temp; title "Formatted data";
format birthdate date9. wage dollar9.2;
run;


/*================================================================================================*/
/*==========================   INFORMAT         ===================================================*/
/*================================================================================================*/

data transact;
 input @1 id $6.
 @10 tran_date mmddyy10.
 @25 amount comma10.2 
 ;
datalines;
124325   08/10/2003      $1,250.03
     7   08/11/2003     $12,500.02
114565   08/11/2003           5.11 
;
run;
proc print data=transact; title "Import data with informat";
run;

data transact;
 input @1 id $CHAR6.
 @10 tran_date mmddyy10.
 @25 amount comma10.2 
 ;
datalines;
124325   08/10/2003      $1,250.03
777777   08/11/2003     $12,500.02
114565   08/11/2003           5.11 
;
run;
proc print data=transact; title "Slightly different informat";
run;


/*================================================================================================*/
/*==========================   INPUT FUNCTION  ===================================================*/
/*================================================================================================*/
data transact2;
  set transact;
  id_num = input(id,6.); 
  if amount > 2000 
  then 
    id_char2 = input(id,$4.); 
  else
    id_char2 = input(id,$6.);

  id_char = cat("'", id_num, "'");
  idid = cat(id, id);
run;
proc print data=transact2; title "Explicit use of informat";
run;

proc contents data=work.transact2 varnum;

/*================================================================================================*/
/*==========================   INPUTC, INPUTN  ===================================================*/
/*================================================================================================*/
options yearcutoff=1720;
data fixdates (drop=start readdate);
    length jobdesc $12 readdate $9 start $10;
    input source id lname $ jobdesc $ start $;
    if source=1 
        then readdate= 'date7. ';
        else readdate= 'mmddyy10.';
    newdate = inputn(start, readdate);
    newdate_s = put(newdate, mmddyy10.);
datalines;
1 1604 Ziminski writer 09aug15
1 2010 Clavell editor 26jan20
2 1833 Rivera writer 10/25/1992
2 2222 Barnes proofreader 3/26/1698
;

proc print data=fixdates; title "Using INPUTC, INPUTN";
run;

/*================================================================================================*/
/*==========================   NUMERIC FORMATS      ==============================================*/
/*================================================================================================*/
data test;
 input @1 x $5. @7 y $5. @13 z;
datalines;
117.7 1.746 1
06.61 97239 2
97123 0.126 3
;
run;
data test2;
 set test;
 num_x = input(x,5.3);
 num_y = input(y,5.3);
proc print data=test2; title "Numeric formats";
  var x num_x y num_y;
run;

proc print data=test2; title "Numeric formats with BEST";
  var x num_x y num_y;
  format _numeric_ best10.;
run; 



/*================================================================================================*/
/*==========================   NEW FORMAT      ===================================================*/
/*================================================================================================*/
proc format;
value $jc 'one' = 'management'
          'two' = 'non-management';
value rate 
           0 = 'terrible'
           1 = 'poor'
           2 = 'fair'
       3 = 'good'
       4 = 'excellent';
run;

proc print data = temp; title "User-defined formats data";
format birthdate date9. wage dollar9.2 jobcat $jc. rating rate.;
run;




/*================================================================================================*/
/*==========================   MULTILABEL FORMAT      ==============================================*/
/*================================================================================================*/
proc format;
value $jc 'one' = 'management'
          'two' = 'non-management';
value ratenew (multilabel)
           0 = 'terrible'
           1 = 'poor'
           2 = 'fair'
           3 = 'good'
           4 = 'excellent'
           low - 1 = 'unacceptable performance'
           2 - high = 'acceptable performance';
run;


proc means data = temp;
title "Mean with multilabel formats";
var wage;
class rating / mlf order = freq;
format rating ratenew.;
run;




/*================================================================================================*/
/*==========================   FUZZY FORMAT      ==============================================*/
/*================================================================================================*/
proc format;
value close (fuzz = .25) 1 = "one"
                         2 = "two"
                     other = "other";
run;

data temp1;
input number;
put number = close.;
cards;
1
1.5
1.24
1.31
1.13
2.27
2.33
2
2.12
2.01
;
run;

proc print data =  temp1;   title "Fuzzy format";
format number close.;
run;



/*================================================================================================*/
/*==========================   NESTING FORMATS      ==============================================*/
/*================================================================================================*/

proc format;
value dog 1 = 'Collie'
          2 = 'Bassett'
      3 = 'Shepard';
value cat 4 = 'Tabby'
          5 = 'Persian'
      6 = 'Lynx';
value pet 1 - 3 = [dog10.]
          4 - 6 = [cat10.]
          other = [best10.];
run;

data pets;
input animal;
cards;
1
4
3
2
5
6
4
9886943983532932893
3
2
;
run;

proc print data = pets;
format animal pet.; title "Nested formats";
run;

/*================================================================================================*/
/*==========================   PICTURE FORMAT          ==============================================*/
/*================================================================================================*/

proc format;
    picture measfmt (default=15)
        low-<1.5 = '<1.5          ' (NOEDIT)
        1.5-10   = '1.5-10        ' (NOEDIT)
        10<-<20  = '99.9 (good)   '
        20-<50   = '99.9 (caution)' (prefix='*')
        50-high  = '99.9 (alert!) ';
run;

data measures;
    output; *empty observation;
    do measure=0.7 to 2 by 0.35, ., 9.5 to 65 by 7.623;
        measure_fmt = put(measure, measfmt.);
        output;
    end;
run;

proc print data=measures; title "Using picture format";
run;