title;
footnote;

proc report data=bs.medical; 

title "Adding a COLUMN Statement"; 
proc report data=bs.medical nowd; 
  column Clinic HR Weight; 
run; 

proc report data=bs.medical nowd; 
  column HR Weight; 
  define HR / display;  
  define Weight / sum; 
run; 

proc report data=bs.medical nowd; 
  column HR Weight; 
  define HR / display "Heart Rate" width=4;  
  define Weight / display width=6; 
run;

title "Demonstrating a GROUP Usage"; 
proc report data=bs.medical; 
  column Clinic HR Weight; 
  define Clinic / group width=11; 
  define HR / mean "Average Heart Rate" width=12  
             format=5.;  
  define Weight / analysis mean "Average Weight" width=12  
                 format=6.; 
run;

title "Demonstrating the FLOW Option"; 
proc report data=bs.medical headline  
         split='' ls=80; 
  column Patno VisitDate DX HR Weight Comment; 
  define Patno     / "Patient Number" width=7; 
  define VisitDate / "Visit Date" width=9 format=date9.; 
  define DX        / "DX Code" width=4 center; 
  define HR        / "Heart Rate" width=6; 
  define Weight    / width=6; 
  define Comment   / width=30 flow; 
run;

title "Demonstrating the Group variables"; 
proc report data=bs.bicycles nowd headline  ls=80; 
  column Country Units TotalSales N; 
  define Country / group width=14 order=data; 
  define Model   / group width=13 order=frequency descending; 
  define Units   / sum "Number of Units" width=8  
                  format=comma8.; 
  define TotalSales / sum "Total Sales (in thousands)"  
                     width=15 format=dollar10.; 
run; 

title "Listing from SALES in EmpID Order"; 
proc report data=bs.sales nowd headline; 
  column EmpID Quantity TotalSales; 
  define EmpID / descending order "Employee ID" width=11 order=freq; 
  define Quantity / width=8 format=comma8.; 
  define TotalSales / "Total Sales" width=9  
                      format=dollar9.; 
run; 
 
title "Random Assignment - Three Groups";
proc report data=bs.assign nowd panels=99  
              headline headskip headline ps=16 ls=256; 
  columns Subject Group; 
  define Subject / display "Sbj" width=7; 
  define Group / "Grp" width=5; 
  
run;

title "Producing Report Breaks"; 
proc report data=bs.sales nowd headline; 
  column Region Quantity TotalSales; 
run;

proc report data=bs.sales nowd headline; 
  column Region Quantity TotalSales; 
  define Region / order width=6; 
  define Quantity / sum width=8 format=comma8.; 
  define TotalSales / mean "Total Sales" width=9  
                      format=dollar9.; 
  rbreak after/ dol ul summarize; 
  break after Region / summarize;
run;

data temp; 
  set bs.sales; 
  length LastName $ 10; 
  LastName = scan(Name,-1,' '); 
run; 

title "Listing Ordered by Last Name"; 
proc report data=temp nowd headline; 
  column LastName Name EmpID TotalSales; 
  define LastName / group noprint; 
  define Name / group width=15; 
  define EmpID / "Employee ID" group width=11; 
  define TotalSales / sum "Total Sales" width=9  
                     format=dollar9.; 
run;

title "Creating a Character Variable in a COMPUTE Block"; 
proc report data=bs.medical nowd; 
  column Patno HR Weight Rate WtKg; 
  define Patno / display "Patient Number" width=7; 
  define HR / display "Heart Rate" width=5;  
  define Weight / display width=6; 
  define WtKg / computed "Weight in Kg"  
                   width=6 format=6.1;
  define Rate / computed width=6; 

  compute WtKg; 
  	WtKg  = Weight / 2.2; 
  endcomp;
  compute Rate / character length=5; 
    if HR gt 75 then Rate = 'Fast'; 
    else if HR gt 55 then Rate = 'Normal'; 
    else if not missing(HR) then Rate='Slow'; 
  endcomp; 
run;

title "Demonstrating an ACROSS Usage"; 
proc report data=bs.bicycles;
  column Country Model Units; 

proc report data=bs.bicycles nowd headline ls=80; 
  column Country Model,Units Units ; 
  define Country  / group width=14; 
  define Model    / across "= Model ="; 
  define Units    / sum "# of Units" width=14 
                   format=comma8.; 
run;

title "Demonstrating an ACROSS Usage"; 
proc report data=bs.bicycles nowd headline ls=80; 
  column Model Units Country; 
  define Country  / group width=14; 
  define Model    / across "- Model -"; 
  define Units    / sum "# of Units" width=14 
                   format=comma8.; 
run;

title "Average Blood Counts by Age Group"; 
proc report data=bs.blood nowd headline; 
  column Gender BloodType AgeGroup,WBC AgeGroup,RBC; 
  define Gender    / group width=8; 
  define BloodType / group width=8 "Blood Group"; 
  define AgeGroup  / across "- Age Group -"; 
  define WBC       / analysis mean format=comma8.; 
  define RBC       / analysis mean format=8.2; 
run;

title "Average Blood Counts by Age Group"; 
proc report data=bs.blood nowd headline; 
  column Gender BloodType AgeGroup,(WBC RBC); 
  define Gender    / group width=8; 
  define BloodType / group width=8 "Blood Group"; 
  define AgeGroup  / across "- Age Group -"; 
  define WBC       / analysis mean format=comma8.; 
  define RBC       / analysis mean format=8.2; 
run;

