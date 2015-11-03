/*============================== 1.*/
data a;
	input n c $ @@;
datalines;
1 a 5 b 2 c 4 d 1 h 3 c 5 b 1 a
; 

proc print data=a; title "Data A"; run;

proc sort data=a; by n;
proc print data=a; title "Data A SORTED"; run;


proc sort data=a nodup; by n;
proc print data=a; title "Data A SORTED NODUP"; run;


proc sort data=a nodupkey; by n;
proc print data=a; title "Data A SORTED NODUPKEY"; run;

/*============================= 2.*/
data a;
	input n c $ @@;
datalines;
5 g 2 c 4 d 1 h 3 c 5 b 1 a
; 

proc print data=a; title "Data A"; run;

data a_with_lag;
	set a;
	lagn = lag(n);
	lag2n = lag(n);
	lagc = lag3(c);

proc print data=a_with_lag; run;
 
proc sort data=a nodupkey; by n  c;
proc print data=a; title "Data A SORTED by two fields"; run;


data a_lag;
	set a;
	if (n ne lag(n));

proc print data=a_lag; title "Data A_Lag"; run;

