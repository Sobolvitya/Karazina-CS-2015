proc print data=bs.blood(obs=20);

title "Average"; 
proc means data=bs.blood; 
  var WBC RBC Chol; 
run;

title "Average - custom values"; 
proc means data=bs.blood mean median q1 q3 maxdec=1; 
  var WBC RBC Chol; 
run;

title "Average by by"; 
proc sql;
	create view blood_sorted as
	select * from bs.blood
	order by Gender, BloodType, agegroup;
run;

proc means data=blood_sorted; 
  by Gender BloodType agegroup;
  var WBC RBC Chol; 
run;

title "Average by class"; 
proc means data=bs.blood; 
  class Gender BloodType agegroup;
  var WBC RBC Chol; 
run;

title "Average by formatted value";
proc format; 
     value chol_group
      low -< 200 = 'Low' 
      200 - high = 'High'; 
  run; 
 
proc means data=bs.blood n nmiss mean median  
         maxdec=1; 
  class Chol; 
  format Chol chol_group.; 
  var RBC WBC; 
run;

title "Custom output"; 

proc means data=bs.blood noprint; 
  class Gender BloodType agegroup;
  var WBC RBC; 
  output out=bloodM;
run;

proc print data=bloodM;

proc means data=bs.blood noprint; 
  class Gender BloodType agegroup;
  var WBC RBC; 
  output out=bloodM
		mean= 
  			n= /autoname;
run;

proc print data=bloodM;

/*Custom types*/
proc means data=bs.blood noprint chartype; 
  class Gender BloodType agegroup;
  var WBC RBC; 
  output out=bloodM
		mean=M_WBC M_RBC
  		n=N_WBC N_RBC;
	types (Gender BloodType)*agegroup Gender*BloodType*ageGroup;
run;

proc print data=bloodM;

proc means data=bs.blood noprint chartype;
    class Gender BloodType agegroup;
	output out=bloodM
        idgroup(max(wbc) out[3] (Subject wbc rbc)=) 
		max(wbc)=max_wbc /autoname ways;
/*	types (Gender BloodType)*agegroup;*/
run;	  

proc print data=bloodM;




