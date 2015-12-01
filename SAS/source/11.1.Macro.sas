/*http://www.ats.ucla.edu/stat/sas/library/nesug99/bt066.pdf*/
options source nonotes errors=0;
options nomlogic mlogicnest nosymbolgen mprint mprintnest;
title;

/*====== SIMPLE MACRO, MACRO FUNCTIONS*/
%macro print(subj);
data _null_;
	file print;
	put "&subj";
run;
%mend;

%print (123);
%print ( &sysdate9 %str(,) %str(%() &sysday. %str(%)));

%let Name = Bogdan Chornomaz;
%let LName = %scan(&Name,2);
%let FName = %scan(&Name,1);
%let Initials = %substr(&FName,1,1).%substr(&LName,1,1);
%let Initials = %substr(&Name,1,1).%substr(%upcase(&Name),2,1);
%print (&lname);
%print (&fname);
%print (&initials);

/*====== WHILE*/
%macro SplitDS(dsname, dsfield, valfrom=0, valto=20);
	%let i=&valfrom;
	%do %while(&i <= &valto);
		data &dsname.&i.;
			set &dsname;
			where &dsfield.=&i.;
		run;
		%let i = %eval(&i + 1);
	%end;
%mend;


proc print data=bs.hosp (obs=20);
%splitds (bs.hosp, quarter); 
proc print data=bs.hosp3 (obs=20);

%let i=1;
%put &i+1;
%put %eval(&i+1);
 
%let i=%eval(&i+1);
%put &i;

/*%symdel ALL;*/

/*====== SYMBOLS OF FRUSTRATION*/
/*http://www2.sas.com/proceedings/sugi29/128-29.pdf*/

%let i=1;
%let reg1=2;
%let reg2=LaLaLa;
%put reg&i.;
%put &&reg&i..;
%put &&&&reg&&reg&i...;
/*&&&&reg&&reg&i...;*/
/*&&reg&reg1..;*/
/*&reg2.;*/
/*LaLaLa;*/

/*======= SCOPES */
/*http://www.sas.com/content/dam/SAS/en_ca/User%20Group%20Presentations/Saskatoon-User-Group/EricWang-MacroVariable-fall10.pdf*/
%let a=OUTER;
%macro printA;
	%print(&a);
%mend;

%printA;


%let a=OUTER;
%macro printA2;
	%let a=INNER;
	%print(&a);
%mend;

%printA2;
%print(AFTERWARDS: &a);

%let a=OUTER;
%macro printA3;
	%print(&a);
	%let a=INNER;
	%print(&a);
%mend;

%printA3;
%print(AFTERWARDS: &a);

%symdel b;
%macro printB;
	%print(&b);
    %let b=INNER B;
	%print(&b);
%mend;

%printB;
%print(&b);

%symdel c d;
%macro printC;
	%macro printCInner;
	    %let c=INNER2 C;
	    %let d=INNER2 D;
		%print(&c);
		%print(&d);
	%mend;
    %let c=INNER C;
	%print(BEFORE: &c);
	%print(BEFORE: &d);
	%printCInner;
	%print(AFTER: &c);
	%print(AFTER: &d);
%mend;

%printC;
%printCInner;
%print(AFTERWARDS: &c);
%print(AFTERWARDS: &d);

/*======= MACRO LISTING */
%put _ALL_;
%put _USER_;
%put _GLOBAL_;
%put _AUTOMATIC_;


proc sql;
	select * from dictionary.macros;
run;

/*======= SCOPES - LOCAL */
/*http://www.sas.com/content/dam/SAS/en_ca/User%20Group%20Presentations/Saskatoon-User-Group/EricWang-MacroVariable-fall10.pdf*/
%symdel a b c;
%let a=OUTER;
%macro printA;
    %let a = ANDREW;
	%local a;
	%print(&a);
	%let a=INNER;
	%print(&a);
%mend;

%printA;
%print(&a);

%macro printB;
	%global b;
	%let b=INNER;
	%print(&b);
%mend;

%printB;
%print(&b);

%macro printCInner;
	%let c=INNER 2;
	%print(&c);
%mend;

%macro printC;
	%let c=INNER;
	%print(BEFORE: &c);
	%printCInner;
	%print(AFTER: &c);
%mend;

%printC;
%print(&c);