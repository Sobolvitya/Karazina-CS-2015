%let datapath = ~/my_content/example_data;
libname bs "&datapath";


%macro chart(title);
title "Distribution of Blood Types - &title"; 
proc gchart data=bs.blood; 
  vbar BloodType; 
  hbar BloodType; 
  pie BloodType; 
  donut BloodType; 
run
%mend;

%macro patclear; %do i=1 %TO 255; pattern&i; %end; %mend;

pattern value=solid color=red; 
pattern2 value=solid color=CX00888; 
pattern3 value=empty color=green;
pattern4 value=L2 color=medium_blue; 


%chart(Using patterns);
%patclear;


goptions COLORS=("very light purplish blue" 
"light vivid green" "medium strong yellow" 
"dark grayish green");

%chart(Using colors);

pattern value=L2; 
title "Distribution of WBC's"; 
proc gchart data=bs.blood; 
/*  vbar WBC; */
  vbar WBC / midpoints=4000 to 11000 by 1000; 
  format WBC comma6.; 
run; 

data day_of_week; 
  set bs.hosp; 
  Day = weekday(AdmitDate); 
  if Day ~=4;
run; 

title "Visits by Day of Week"; 
pattern value=R1; 
proc gchart data=day_of_week; 
/*  vbar Day; */
  vbar Day / midpoints=1 to 7 by 1; 
  vbar Day / discrete; 
run;

title "Total Sales by Region"; 
pattern1 value=L1; 
axis1 order=('North' 'South' 'East' 'West'); 
proc gchart data=bs.sales; 
  vbar Region / sumvar=TotalSales  
               type=sum 
               maxis=axis1; 
  vbar Region / sumvar=TotalSales  
               type=mean; 
  format TotalSales dollar8.; 
run; 

title "Average Cholesterol by Gender"; 
proc gchart data=bs.blood; 
  vbar Gender / sumvar=Chol  
               type=mean 
               group=BloodType; 
  vbar Gender / sumvar=Chol  
               type=mean 
               subgroup=BloodType; 
run; 
