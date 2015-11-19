%let datapath=~/my_content/example_data;
%let temppath=~/my_content/temp_data;
libname bs "&datapath";

ods listing;  
* Adding graphics; 
proc format;   
  value $regfile 
   '1','2','3' = 'NoEast'  
   '4'         = 'SoEast' 
   '5' - '8'   = 'MidWest'  
   '9', '10'   = 'Western'; 
  run; 
 
pattern1 v=psolid c="yellowish red" r=1; 
pattern2 v=psolid c="very dark brown" r=1; 
pattern3 v=psolid c="cyan" r=1; 
pattern4 v=psolid c="navy" r=1; 
 
title1; 
 
* Clear the graphics catalog; 
proc datasets library=work mt=cat nolist; 
  delete gseg; 
  quit; 
 
* Dummy records force proper pattern statement usage; 
data dummy(keep=region proced wt ht edu); 
  do region='5 ','1','4','9'; 
   do proced=' ','1','2','3'; 
     wt=.; ht=.; edu=.; 
     output; 
   end; 
  end; 
run; 
 
* Dummy records are appended to force each region to  
* have all procedures. This causes patterns to match 
* across regions;  
data clinics(keep=reggrp proced wt ht edu cnt); 
  set bs.clinics(keep=region proced wt ht edu) 
      dummy(in=indum); 
  reggrp = put(region,$regfile.); 
  * CNT=1 for valid records; 
  cnt = 1-indum; 
run;     

proc print data=clinics;
 
%macro bldimage; 
proc sql noprint;  
  select distinct(reggrp) 
  into :reg1-:reg99 
     from clinics; 
  %let regcnt = &sqlobs; 
quit;  
 
 
%do i = 1 %to &regcnt; 
  %put &&reg&i;
  filename propie "&temppath/results/&&reg&i...gif"; 
  goptions dev=gif160 
           gsfname=propie; 
  proc gchart data=clinics(where=(reggrp="&&reg&i")); 
  pie proced / noheading missing 
                type=sum 
                sumvar=cnt 
                slice=none 
                name="&&reg&i";  
 run; 
 quit; 
%end; 
%mend bldimage; 
%bldimage 
 
ods listing close; 
  
ods html path="&temppath/results" 
         body="ch10_3_1b.html"

         style=default; 
*ods pdf file="&temppath\results\ch10_3_1b.pdf" 
         style=minimal; 
*ods rtf file="&temppath\results\ch10_3_1b.rtf" 
        style=rtf; 
 
title1 'Interfacing with REPORT'; 
title2 'Adding Graphics'; 
title3 'Reduced Size GIF Files'; 

 
proc report data=clinics nowd split='*'; 
  column reggrp image image2 edu ht wt; 
  define reggrp / group width=10 'Region' order=formatted; 
  define image / computed 'style'; 
  define image2 / computed 'grseg'; 
  define edu  / analysis mean 'Years of*Education'  
                format=9.2 style={color=red}; 
  define ht   / analysis mean format=6.2 'Height'; 
  define wt   / analysis mean format=6.2 'Weight'; 
 
  compute image / char length=10;  
   image=' '; 
   imageloc = "style={postimage='&temppath/results/" 
                      ||trim(reggrp)|| ".gif'}"; 
   * Specify the image using the STYLE=; 
   call define('image', 
               'style', 
               imageloc); 
*   call define('edu', 
               'style', 
               'style={backcolor=red}'); 

  endcomp; 
   
  compute image2 / char length=10; 
   image2=' '; 
   imageloc = "work.gseg."||trim(reggrp)||'.grseg'; 
 
* Specify the image using the GRSEG attribute; 
   call define('image2', 
               'grseg', 
                imageloc); 
  endcomp; 
  run; 
ods _all_ close;