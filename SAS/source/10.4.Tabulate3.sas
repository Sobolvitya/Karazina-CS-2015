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
