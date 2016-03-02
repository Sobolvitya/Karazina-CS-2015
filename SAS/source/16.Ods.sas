%let datapath = ~/my_content/example_data;
%let path = ~/my_content/temp_data;
libname bs "&datapath";

data abc;
  retain a 0 b 0 c 0;
  output;
  output;
run;

/*======================== ODS =========================*/
/*=======================================================*/
ods csv file="&path./test.csv"; 
ODS HTML FILE="&path./test.html"; 
ODS PDF FILE="&path./test.pdf"; 
ODS RTF FILE="&path./test.rtf";
ods tagsets.excelxp file="&path./test.xml"; 

proc print data=abc noobs; 
	title "Proc Print";
run;
ods _ALL_ close;


/*======================== HTML =========================*/
/*=======================================================*/
ODS HTML FILE="&path./test2.html"; 
proc print data=abc noobs; 
	title "Proc Print";
run;
ods html close;

ODS HTML FILE="&path./test2.html"; 
ODS HTML FILE="&path./test2-sasweb.html" STYLE=sasweb; 
proc print data=abc noobs; 
	title "Proc Print";
run;
ods html close;


/*======================== HTML-2 =======================*/
/*=======================================================*/
ods html body = "body_sample.html"  
          contents = "contents_sample.html" 
          frame = "frame_sample.html" 
          path = "&path." (url=none); 
proc print data=abc noobs; 
	title "Proc Print";
run;
proc print data=abc noobs; 
	title "Proc Print 2";
run;
proc print data=abc noobs; 
	title "Proc Print 3";
run;
ods html close;




/*======================== SELECT/EXCLUDE =======================*/
/*=======================================================*/
*Open several ODS destinations; 
ods output variables=vardata; 
* Select only the "variables" table; 
ods select variables; 
ods show;

* Run the Contents Procedure; 
ods trace on; 
proc contents data=abc; run; 
ods _all_ close; 
ods listing;

proc print data=vardata;


/*======================== TEMPLATE =======================*/
/*=======================================================*/
proc template; list styles; run;
