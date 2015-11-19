title1 'Using Proc REPORT'; 
title2 'Using the Comma to Attach Statistics'; 
title3 'Mean WEIGHT and HEIGHT'; 
proc report data=sashelp.class nowd; 
   column age weight,mean (Mean stderr),(height weight) n; 
   define age    / group; 
   define weight / display width=20;   
   define height / analysis; 
   run; 

title1 'Using Proc REPORT'; 
title2 'Using Parentheses to form Groups'; 
title3 'Grouping Under an ACROSS Variable'; 
proc report data=sashelp.class nowd; 
   column age sex,weight,(N Mean); 
   define age    / group; 
   define sex    / across; 
   define weight / analysis; 
   run;
