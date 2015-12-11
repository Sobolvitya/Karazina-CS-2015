data sampdate;
    file print;
	sampdate = '28jul2004'd;
	samptime = '11:32't;
	sampdtime= '28jul2004:11:32'dt;
	put / "===== Sample ===== ";
	put sampdate=;
	put samptime=;
	put sampdtime=;
run;

data dtvalues;
    file print;
	day=28;
	mon=7;
	yr=2004;
	hr=11;
	min=32;
	sec=0;
	sampdate = mdy(mon,day,yr);
	samptime = hms(hr,min,sec);
	sampdtime= dhms(sampdate,hr,min,sec);
	current = today();
	put // "===== Combined Dates ===== ";
	put sampdate=;
	put samptime=;
	put sampdtime=;
run;

data samppart;
    file print;
	sampdtime= '28jul2004:11:32'dt;
	sampdate = datepart(sampdtime);
	samptime = timepart(sampdtime);
	put // "===== Date Parts ===== ";
	put sampdate=;
	put samptime=;
	put sampdtime=;
run;

data format;
    file print;
	sampdate = '28jul2004'd;
	put // "===== More Formats ===== ";
	put 'Word: ' sampdate= worddate18.;
	put 'Date: ' sampdate= date9.;
	put 'Mdy : ' sampdate= mmddyy10.;
	put 'b ' sampdate= mmddyyb10.;
	put 'c ' sampdate= mmddyyc10.;
	put 'd ' sampdate= mmddyyd10.;
	put 'n ' sampdate= mmddyyn8.;
	put 'p ' sampdate= mmddyyp10.;
	put 's ' sampdate= mmddyys10.;
run;

options datestyle=ymd;
data new;
    file print;
	if _N_=1 then put // "===== Anydte ===== ";
	input date anydtdte10.;
	put date;
	format date date9.;
datalines;
01/12/2003
13/01/2003
13jan2003
13jan03
13/01/03
01/02/03
03/02/01
run;