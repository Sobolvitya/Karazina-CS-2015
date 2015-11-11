%let datapath = /courses/d2598a15ba27fe300/Fall/textdata;

options notes;
data payment_scedule (drop= N INP) 
	payment_scedule_err(keep= N INP)
;
	length N 8 INP $ 200;
	format valid_stat_dttm datetime20.;
	format valid_end_dttm datetime20.;
	infile "&datapath/Payment_scedule.csv" missover dlm='*' firstobs=140 
		obs=200;

	input @;
/*	_infile_ = tranwrd(_infile_, "сен", "09");*/
	_infile_=tranwrd(_infile_,"f1e5ed"x,"09");

	input 	deal_id:8.  valid_stat_dttm :datetime20. valid_end_dttm :datetime20.
			payment_type :$8. payment_amt:8. 
			int_amt:8. ln_pmnt:8. payment_dt:8. pmnt_nr:8.;
	if (_error_) then do;
		N = _N_;
		INP = _INFILE_;
/*		INP = put(substr(_INFILE_, 66, 3),$hex.);*/
		output payment_scedule_err;
	end; else output payment_scedule;  
run;


proc print data = payment_scedule_err; title "WITH ERROR";
run;

proc print data = payment_scedule; title "CORRECT";
run;



