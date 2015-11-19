title "Scatter Plot of SBP by DBP"; 

symbol;
symbol value=dot;
proc gplot data=learn.clinic; 
  plot SBP * DBP; 
  plot SBP * DBP / haxis=70 to 120 by 5 
                      vaxis=100 to 220 by 10;
run;

title "Scatter Plot of SBP by DBP"; 
title2 h=1.2 "Interpolation Methods"; 
symbol value=dot interpol=join width=2; 
proc gplot data=learn.clinic; 
  plot SBP * DBP; 
run;

proc sort data=learn.clinic out=clinic; 
  by DBP; 
run; 
 
title "Scatter Plot of SBP by DBP"; 
title2 h=1.2 "Interpolation Methods"; 
symbol value=dot interpol=join width=2; 
proc gplot data=clinic; 
  plot SBP * DBP; 
run;

title "Scatter Plot of SBP by DBP"; 
title2 h=1.2 "Interprelation Methods"; 
symbol value=dot interpol=sms line=1 width=2; 
proc gplot data=learn.clinic; 
  plot SBP * DBP; 
run;

