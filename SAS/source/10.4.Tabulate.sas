title "Demonstrating Concatenation"; 
proc tabulate data=bs.blood  format=6.; 
  class Gender BloodType; 
  table Gender BloodType; 
run;