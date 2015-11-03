%let datapath = /courses/d2598a15ba27fe300;

proc import 
	datafile="&datapath/Fall/textdata/Deal_depo_chng.csv"
	out=deal_depo_chng replace
	dmbs=dlm;
delimeter = ';';
run;

proc print data=deal_depo_chng;
proc contents data=deal_depo_chng; 
