data regexp;
	length regexp $20 num 3 sent $20;
	infile datalines dsd dlm=' ' line=ln;

	input @1 regexp @;
	num = prxparse(regexp);
	do while(1);
		input sent @@;
		if (ln >1) then leave;
		if not missing(sent) then do 
			mpos=prxmatch(num, trim(sent));
			call prxsubstr(num, trim(sent), pos, len);
			if pos >0  then match = substr(sent, pos, len); else call missing(match);
			output;  
		end;
	end;

	format sent $quote.;
	drop ln pos;
datalines;
/cat/  "The cat is black"    "cots" 
/^cat/  "cat on the roof"     "The cat" 
/cat$/  "There is a cat"    "cat in the house" 
/cat/I  "The CaT" "The Cat"  "no dogs allowed" 
/cat/i  "The CaT" "The Cat"  "no dogs allowed" 
/r[aeiou]+t/  "rat" "rot" "rut"  "riot"  "rt"  "rxt" 
/r(ab)+t/  "rabt" "rabbt" "rabababt"
/r+t/  "rabt" "rabrtbt" "rabababt"
/r.+t.+s/  "rtsts" "ritsts" "rtsits" "rtstis" "rtststs" "rrrrtstststs" 
/\d\d\d/  "345" "999"    "1234"  "99" 
/(\d\d\d?)?/  "123"  "12"    "" "1AB" " 9" 
/\d\d\d+/  "123"  "12345"    "12" 
/\d\d\d*/  "123" "12" "12345"    ""  "xyz" 
/r.n/  "ron" "ronny" "r9n" "r n"    "rn"  
/[0-5]\d[6-9]/  "299" "106" "337"    "666" "919" "11" 
/(\d|x)\d/  "56"  "x9"    "9x"  "xx" 
/[^a-eA-E123]\D/  "fX" "9 " "AA"    "aa" "99" "b%" 
/^\/\//  "//sysin dd *"    "the // is here" 
/^\/(\/|\*)/  "//" "/*"    "/123 /*"
run;

proc print data=regexp;
  id RegExp;
  by RegExp notsorted;




DATA TOLL_FREE; 
   IF _N_ = 1 THEN DO 
      RE =  PRXPARSE ("/\(8(00|77|87)\) ?\d\d\d-\d{4}\b/"); 
      ***Regular expression looks for phone numbers of the form: 
         (nnn)nnn-nnnn or (nnn) nnn-nnnn.  In addition the first 
         digit of the area code must be an 8 and the next two 
         digits must be either a 00, 77, or 87.; 
      IF MISSING(RE) THEN DO; 
         PUT "ERROR IN COMPILING REGULAR EXPRESSION"; 
         STOP; 
      END; 
   END; 
   RETAIN RE; 
   INPUT STRING $CHAR80.; 
   POSITION = PRXMATCH (RE,STRING); 
   IF POSITION GT 0 THEN OUTPUT; 
DATALINES; 
One number on this line (877)234-8765 
No numbers here 
One toll free, one not:(908)782-6354 and (800)876-3333 xxx 
Two toll free:(800)282-3454 and (887) 858-1234 
No toll free here (609)848-9999 and (908) 345-2222 
; 
PROC PRINT DATA=TOLL_FREE NOOBS; 
   TITLE "Listing of Data Set TOLL_FREE"; 
RUN; 


DATA PIECES; 
   IF _N_ THEN RE = PRXPARSE ("/\((\d(\d\d))\) ?(\d\d\d)-\d{4}/"); 
   /* 
      \(       matches an open parenthesis 
      \d\d\d   matches three digits 
      \)       matches a closed parenthesis 
      b?       matches zero or more blanks (b = blank) 
      \d\d\d   matches three digits 
      -        matches a dash 
      \d{4}    matches four digits 
   */ 
   RETAIN RE; 
 
   INPUT NUMBER $CHAR80.; 
   MATCH =  PRXMATCH (RE,NUMBER); 
   IF MATCH GT 0 THEN DO; 
       CALL PRXPOSN(RE,1,AREA_START); 
       CALL PRXPOSN(RE,2,EX_START,EX_LENGTH); 
      AREA_CODE =  SUBSTR (NUMBER,AREA_START,3); 
      EXCHANGE = SUBSTR (NUMBER,EX_START,EX_LENGTH); 
   END; 
   DROP RE; 
DATALINES; 
THIS LINE DOES NOT HAVE ANY PHONE NUMBERS ON IT 
THIS LINE DOES: (123)345-4567 LA DI LA DI LA 
  10
  SUGI 29   Tutorials
ALSO VALID (609) 999-9999 
TWO NUMBERS HERE (333)444-5555 AND (800)123-4567 
; 
PROC PRINT DATA=PIECES NOOBS HEADING=H; 
   TITLE "Listing of Data Set PIECES"; 
RUN;

DATA FIND_NUM; 
   IF _N_ = 1 THEN RET = PRXPARSE ("/\d+/"); 
   *Look for one or more digits in a row; 
   RETAIN RET; 
 
   INPUT STRING $40.; 
   START = 1; 
   STOP = LENGTH (STRING); 
    CALL PRXNEXT(RET,START,STOP,STRING,POSITION,LENGTH); 
   ARRAY X[5]; 
   DO I = 1 TO 5 WHILE (POSITION GT 0); 
      X[I] =  INPUT(SUBSTR(STRING,POSITION,LENGTH),9.); 
       CALL PRXNEXT(RET,START,STOP,STRING,POSITION,LENGTH); 
   END; 
   KEEP X1-X5 STRING; 
DATALINES; 
THIS 45 LINE 98 HAS 3 NUMBERS 
NONE HERE 
12 34 78 90 
; 
DATA FIND_NUM; 
   IF _N_ = 1 THEN RET = PRXPARSE ("/\d+/"); 
   *Look for one or more digits in a row; 
   RETAIN RET; 
 
   INPUT STRING $40.; 
   START = 1; 
   STOP = LENGTH (STRING); 
    CALL PRXNEXT(RET,START,STOP,STRING,POSITION,LENGTH); 
   DO I = 1 TO 5 WHILE (POSITION GT 0); 
      X =  INPUT(SUBSTR(STRING,POSITION,LENGTH),9.); 
       CALL PRXNEXT(RET,START,STOP,STRING,POSITION,LENGTH); 
	  output;
   END; 
DATALINES; 
THIS 45 LINE 98 HAS 3 NUMBERS 
NONE HERE 
12 34 78 90 
; 

PROC PRINT DATA=FIND_NUM NOOBS; 
   TITLE "Listing of Data Set FIND_NUM"; 
RUN;

DATA PAREN; 
   IF _N_ = 1 THEN PATTERN = PRXPARSE ("/(\d )|(\d\d )|(\d\d\d )/"); 
   ***One or two or three digit number followed by a blank; 
   RETAIN PATTERN; 
 
   INPUT STRING $CHAR30.; 
   POSITION = PRXMATCH (PATTERN,STRING); 
   IF POSITION GT 0 THEN WHICH_PAREN = PRXPAREN (PATTERN); 
DATALINES; 
one single digit 8 here 
two 888 77 
12345 1234 123 12 1 
; 
PROC PRINT DATA=PAREN NOOBS; 
   TITLE "Listing of Data Set PAREN"; 
RUN;

 
DATA CAT_AND_MOUSE; 
   INPUT TEXT $CHAR40.; 
   LENGTH NEW_TEXT $ 80; 
 
   IF _N_ = 1 THEN MATCH = PRXPARSE ("s/[Cc]at/Mouse/"); 
   *Replace "Cat" or "cat" with Mouse; 
   RETAIN MATCH; 
 
   CALL  PRXCHANGE(MATCH,-1,TEXT,NEW_TEXT,R_LENGTH,TRUNC,N_OF_CHANGES); 
   IF TRUNC THEN PUT "Note: NEW_TEXT was truncated"; 
DATALINES; 
The Cat in the hat 
There are two cat cats in this line 
; 
PROC PRINT DATA=CAT_AND_MOUSE NOOBS; 
   TITLE "Listing of CAT_AND_MOUSE"; 
RUN;

DATA CAPTURE; 
   IF _N_ = 1 THEN RETURN = PRXPARSE("S/(\w+ +)(\w+)/$2 $1/"); 
   RETAIN RETURN; 
 
   LENGTH NEW_STRING $20;
   INPUT STRING $20.; 
    CALL PRXCHANGE(RETURN,-1,STRING, NEW_STRING); 
DATALINES; 
Ron Cody 
Russell Lynn 
; 
PROC PRINT DATA=CAPTURE NOOBS; 
   TITLE "Listing of Data Set CAPTURE"); 
RUN;