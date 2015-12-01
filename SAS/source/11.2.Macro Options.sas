/*http://support.sas.com/documentation/cdl/en/mcrolref/61885/HTML/default/viewer.htm#a000543586.htm*/
/*http://support.sas.com/documentation/cdl/en/mcrolref/61885/HTML/default/viewer.htm#a001066200.htm*/
options nosource nonotes errors=0;
options nomlogic nomlogicnest nosymbolgen nomprint nomprintnest;

%macro mktitle(proc,data);
    title "%upcase(&proc) of %upcase(&data)";
%mend mktitle;

%macro runplot(ds);
   %if %sysprod(graph)=1 %then
      %do;
         %mktitle (plot,&ds)
         proc plot data=&ds;
            plot SBP*DBP;
         run;
         quit;
      %end;
   %else
      %do;
         %mktitle (plot,&ds)
         proc plot data=&ds;
            plot SBP*DBP;
         run;
         quit;
      %end;
%mend runplot;

%put ============================ NOSYMBOLGEN(Default);
%runplot(bs.clinic);

options symbolgen;
%put ============================ SYMBOLGEN;
%runplot(bs.clinic);

options mlogic;
%put ============================ SYMBOLGEN;
%runplot(bs.clinic);

options mlogicnest;
%put ============================ MLOGICNEST;
%runplot(bs.clinic);

options nomlogic nomlogicnest source;
%put ============================ SOURCE;
%runplot(bs.clinic);

options nomlogic nomlogicnest mprint;
%put ============================ MPRINT;
%runplot(bs.clinic);

options mprintnest;
%put ============================ MPRINTNEST;
%runplot(bs.clinic);

options mlogic mlogicnest mprint mprintnest symbolgen source;
%put ============================ EVERYTHING;
%runplot(bs.clinic);

