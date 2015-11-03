data a;
	input c $ n @@;
datalines;
a 5 b 4 c 3 d 2 e 1
;
data b; set a;  d = cat("!!!", c);  output;
data a; set a; e = cat("***", c);  output;

/*proc sort data=b; by n;*/

proc print data=a; title "Data A"; run;
proc print data=b; title "Data B"; run;

/*http://support.sas.com/resources/papers/proceedings10/149-2010.pdf*/
PROC COMPARE BASE=a COMPARE=b;
TITLE1 'Example 1: PROC COMPARE with no options or extra statements';
RUN;

PROC COMPARE BASE=a COMPARE=b novalues listvar brief ;
TITLE1 'Example 2: PROC COMPARE with NOVALUES & LISTVAR options';
RUN;




PROC COMPARE BASE=a COMPARE=b brief;
TITLE1 'Example 3: PROC COMPARE ID Statement';
id n;
RUN;

PROC COMPARE BASE=a COMPARE=b brief listobs;
TITLE1 'Example 4: PROC COMPARE VAR Statement';
id n;
var c n e; 
with c n d;
RUN;

PROC COMPARE BASE=a(drop=e) COMPARE=b(drop=d) 
	outnoequal  outbase outcomp outdif 
	out=diff noprint;
TITLE1 'Example 5: PROC COMPARE with OUT= Option'; 
RUN;

proc sort data=diff; by n;

proc print data=diff;
