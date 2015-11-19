/*=========  title*/
%LET N=20;
%let datapath = ~/my_content/Fall/Rawdata;

proc sql noprint;
	select count(1) into :RECNO from rawdata_short;
run;

title "Data about deals";
title2 "Only &N rows";
title3 "out of &RECNO";

proc print data=rawdata_short (obs=&N);
run;


/*=========  footnote, label, id, var, format*/
title "Now only several variables";
title2;
title3;
footnote "Prepared by BC";
proc print data=rawdata_short (obs=&N.) label;
	id customer_id;
	var customer_nm product_type_cd product_cd currency_cd interest_amt;
	format interest_amt dollar10.;
run;

/*=========  footnote, label, id, var, format*/
title "Now only several variables";
title2;
title3;
footnote "Prepared by BC";
proc print data=rawdata_short (obs=&N.0) label;
	id customer_id;
	var customer_nm product_type_cd product_cd currency_cd interest_amt;
	format interest_amt dollar10.;
run;

/*=========  where*/
title "Where";
proc print data=rawdata_short (obs=20) label;
	id customer_id;
	var customer_nm product_type_cd product_cd currency_cd interest_amt;
	format interest_amt dollar10.;
	where interest_amt > 5000;
run;


/*=========  by*/
title "By";
proc sql;
	create view rawdata_sorted as
	select * from rawdata_short
	order by product_cd, customer_nm;
run;

proc print data=rawdata_sorted label;
	id customer_id;
	var customer_nm product_type_cd product_cd currency_cd interest_amt;

	by product_cd;

	format interest_amt dollar10.;
	where interest_amt > 5000;
run;

title "By with sum, by two fields";
proc print data=rawdata_sorted label;
	id customer_id;
	var customer_nm product_type_cd product_cd currency_cd interest_amt;

	by product_cd customer_nm;
	sum interest_amt;
	format interest_amt dollar10.;
	where interest_amt > 5000;
run;


/*==================== ODS*/
%let incpath= ~/my_content/include;
ods pdf file="&incpath/out.pdf";
ods listing close;

title "By with sum, by two fields";
proc print data=rawdata_sorted label;
	id customer_id;
	var customer_nm product_type_cd product_cd currency_cd interest_amt;

	by product_cd customer_nm;
	sum interest_amt;
	format interest_amt dollar10.;
	where interest_amt > 5000;
run;
ods pdf close;
