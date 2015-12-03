title "Data"; 
proc print data=bs.blood(obs=20); run;

title "Means"; 
proc means data=bs.blood; run;

title "Freq"; 
proc freq data=bs.blood; run;

title "Freq custom tables, nocum"; 
proc freq data=bs.blood; 
	tables AgeGroup BloodType Gender / nocum;
run;

proc format; 
 	value cholGroup 
		low-<100 = 'Low' 
		100-<200 = 'Medium' 
		200-high = 'High' ;

 	value cholGroupII 		
		30-<100 = 'Low' 
		100-<200 = 'Medium' 
		200-300 = 'High' 
		other = 'Anomalies';

	value cholGroupIII 		
		30-<100 = 'Low' 
		100-<200 = 'Medium' 
		200-300 = 'High' 
		. = 'Missing'		 
		other = 'Anomalies';
run;

title "Freq, by foratted value"; 
proc freq data=bs.blood; 
	tables AgeGroup BloodType Gender Chol;
	format Chol cholGroup.;
run;

title "Freq, missing"; 
proc freq data=bs.blood; 
	tables Chol;
	tables Chol / missing;
	format Chol cholGroup.;
run;

title "Freq, missing, other"; 
proc freq data=bs.blood ; 
	tables Chol;
	tables Chol / missing;
	format Chol cholGroupII.;
run;

title "Freq, missing, other"; 
proc freq data=bs.blood ; 
	tables Chol;
	tables Chol / missing;
	format Chol cholGroupIII.;
run;


title "Freq, ordered"; 
proc freq data=bs.blood order=formatted; 
	tables Chol / missing;
	format Chol cholGroupIII.;
run;

title "Freq, ordered"; 
proc freq data=bs.blood order=freq; 
	tables Chol / missing;
	format Chol cholGroupIII.;
run;

title "Freq, two way"; 
proc freq data=bs.blood; 
	tables AgeGroup*BloodType;
	tables AgeGroup*AgeGroup;
run;

title "Freq, two way - nested"; 
proc freq data=bs.blood; 
	tables (AgeGroup BloodType)*(Gender Chol);
	format Chol cholGroup.;
run;

title "Freq, three way"; 
proc freq data=bs.blood; 
	tables AgeGroup*BloodType*Gender;
	tables AgeGroup*BloodType*Gender /nocol norow nopercent;
run;

title "Freq, two way, deviation"; 
proc freq data=bs.blood; 
	tables AgeGroup*BloodType/
		nocol norow nopercent deviation expected out=AB_dev
		outexpect outpct;
run;

proc print data=AB_dev;

title "Freq, two way, chisquare"; 
proc freq data=bs.blood; 
	tables AgeGroup*BloodType*Gender/chisq;
	output out=AB_Chi chisq;
run;

proc print data=AB_chi;

title "Freq, weight, cumulative freq"; 
proc freq data=bs.blood noprint; 
	tables AgeGroup*BloodType*Gender /out=blood_ABG nocol norow nopercent;
	tables AgeGroup*BloodType/out=blood_AB nocol norow nopercent;
run;

proc print data=blood_ABG;
proc print data=blood_AB;

proc freq data=blood_ABG noprint; 
	tables AgeGroup*BloodType /out=blood_ABII nocol norow nopercent;
run;

proc print data=blood_ABII;


proc freq data=blood_ABG noprint; 
	tables AgeGroup*BloodType /out=blood_ABII_Count nocol norow nopercent;
	weight count;
run;

proc print data=blood_ABII_Count;

