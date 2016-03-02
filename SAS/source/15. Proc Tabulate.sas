%let datapath = ~/my_content/example_data;
libname bs "&datapath";


title "Simple report"; 
proc report data=bs.blood(obs=20);

title "Simple tabulate"; 
proc tabulate data=bs.blood  format=6.; 
  class Gender BloodType AgeGroup; 
  table Gender BloodType; 
  table Gender,BloodType; 
  table Gender BloodType, AgeGroup; 
  table Gender, BloodType AgeGroup; 
  table Gender, BloodType, AgeGroup; 
run;

title "Demonstrating Nesting"; 
proc tabulate data=bs.blood format=6.; 
  class Gender BloodType AgeGroup; 
  table AgeGroup, Gender * BloodType; 
run;

title "Adding the Keyword ALL to the TABLE Request"; 
proc tabulate data=bs.blood format=6.; 
  class Gender BloodType AgeGroup; 
  table Gender ALL, 
       BloodType ALL; 
  table Gender ALL AgeGroup, 
       BloodType ALL; 
  table ALL; 
  table ALL*ALL, ALL, ALL*ALL ALL; 
run;

title "Demonstrating Analysis Variables"; 
proc tabulate data=bs.blood; 
  var RBC WBC; 
  class Gender;
  table RBC WBC; 
  table RBC*mean WBC*mean; 
  table (RBC WBC)*(mean median ALL GENDER); 
  table RBC*(mean median) WBC*mean*(ALL Gender); 
  table RBC*(mean median) WBC*(ALL Gender)*mean; 
run;

title "Combining CLASS and Analysis Variables"; 
proc tabulate data=bs.blood format=comma11.2; 
  class Gender AgeGroup; 
  var RBC WBC Chol; 
  table (Gender ALL)*(AgeGroup All), 
        (RBC WBC Chol)*mean; 
run;

title "Specifying Formats and Renaming Keywords"; 
proc tabulate data=bs.blood; 
  class Gender; 
  var RBC WBC; 
  table Gender ALL, 
        RBC*(mean*f=9.1 std*f=9.2) 
       WBC*(mean*f=comma9. std*f=comma9.1); 
  keylabel ALL  = 'Total' 
          mean = 'Average' 
          std  = 'Standard Deviation'; 
run;

proc tabulate data=bs.blood format=6.; 
  class Gender BloodType;  var RBC;
  table Gender; 
  table Gender*n=' '; 
  table Gender, RBC; 
  table Gender*n=' ', RBC; 
  table Gender*n=' ', RBC All; 
  table Gender, RBC*n=' '; 
  table Gender, RBC*nmiss=' '; 
  table Gender BloodType; 
  table Gender*n=' ' BloodType; 
  table Gender*BloodType; 
  table (Gender=' ')*(BloodType=' ')*n=' '; 
  table (Gender=' '),(BloodType=' '); 
  table (Gender=' '),(BloodType=' ')*n=' '; 
  table (Gender=' '),(BloodType=' ')*n=' '; 
run; 

title "Counts and Percentages"; 
proc format; 
  picture pctfmt low-high='009.9%'; 
run; 
 
proc tabulate data=bs.blood; 
  class BloodType Gender AGegROUP; 
  var RBC;
  table (BloodType ALL)*(n*f=5. pctn*f=pctfmt7.1); 
  table (BloodType ALL='All Blood Types'), 
        (Gender ALL)*(n*f=5. colpctn*f=pctfmt7.1) /RTS=25; 
  table (BloodType ALL='All Blood Types'), 
        (Gender ALL)*(n*f=5. pctn*f=pctfmt7.1)  /RTS=10; 
  table (BloodType ALL='All Blood Types'), 
        (Gender ALL)*(n*f=5. rowpctn*f=pctfmt7.1)  /RTS=10; 
  table Gender, (BloodType ALL='All Blood Types'), 
        (AgeGroup ALL)*(n*f=5. pctn*f=pctfmt7.1)  /RTS=10; 
  table (BloodType ALL='All Blood Types'), 
        (AgeGroup ALL)*RBC*(n*f=5. rowpctsum*f=pctfmt7.1 pctsum*f=pctfmt7.1) ; 
  keylabel All     = 'Both Genders' 
          n       = 'Count' 
          pctn = 'Percent'
          colpctn = 'Percent'; 
run; 

title "Computing Percentages on a Numerical Value"; 
proc tabulate data=bs.sales; 
  class Region; 
  var TotalSales; 
  table (Region ALL), 
        TotalSales*(n*f=6. sum*f=dollar8.  
                    pctsum*f=pctfmt7.); 
  table (Region ALL),
        TotalSales*(n*f=6. sum*f=dollar8.  
                    pctsum*f=pctfmt7.); 
      
  keylabel ALL     = 'All Regions' 
          n       = 'Number of Sales' 
          sum     = 'Sum' 
          pctsum  = 'Percent'; 
  label TotalSales = 'Total Sales'; 
run;

title "The Effect of Missing Values on CLASS variables"; 
proc print data=bs.missing;

proc tabulate data=bs.missing format=4.; 
  class A B; 
  table A ALL,B ALL; 
run;

proc tabulate data=bs.missing format=4.; 
  class A B C; 
  table A ALL,B ALL; 
run;

title "Demonstrating the MISSTEXT TABLES Option"; 
proc tabulate data=bs.missing format=7. missing; 
  class A B; 
  table A ALL,B ALL; 
  table A ALL,B ALL / misstext='no data' ; 
run;


/*
proc tabulate data=bs.blood; 
  class Gender BloodType AgeGroup; 
  table Gender BloodType; 
  table Gender*f=CHAR6. BloodType; 
run;*/


proc tabulate data=bs.sales style={foreground=blue}; 
  class Region; 
  var TotalSales; 
  table (Region ALL), 
        TotalSales*(n={label='NNN' style={cellwidth=200}}*f=6. sum*f=dollar8.  
                    pctsum*f=pctfmt7.)/; 
      
  keylabel ALL     = 'All Regions' 
          n       = 'Number of Sales' 
          sum     = 'Average' 
          pctsum  = 'Percent'; 
  label TotalSales = 'Total Sales'; 
run;
