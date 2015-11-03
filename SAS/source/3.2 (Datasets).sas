%let datapath = /courses/d2598a15ba27fe300;
libname mydata "/courses/d2598a15ba27fe300";
libname A "/courses/d2598a15ba27fe300/a";


/*=================================================================*/
/*=================================================================*/
/*=================================================================*/
data mydata.base;
    do i = 1 to 5;
        j=_n_;
        output;
    end;
run;

data mydata.base2;    
    drop i;

    do i = 1 to 5;
        j=_n_;
        k=i**2;
        
        output;
    end;
run;

proc print data=mydata.base;
proc print data=mydata.base2;

/*=================================================================*/
/*================   CONTENTS   ===================================*/
/*=================================================================*/
title "datasets";
proc datasets lib=mydata nolist; run;
title "contents";
proc contents data=mydata._all_ nods; run;


/*=================================================================*/
/*=============   COPY          ===================================*/
/*=================================================================*/
title "datasets for library A";
proc datasets lib=A kill nolist; run;

proc copy in=mydata out=A; run;
proc datasets lib=A kill; run;

proc datasets nolist; copy in=mydata out=A; select base; run;

title "datasets for library A (after copy)";
proc datasets lib=A kill; run;




/*=================================================================*/
/*=============   RENAMING AND MODIFYING       ====================*/
/*=================================================================*/
title;
proc copy in=mydata out=A; run;

data A.newbase;
    set A.base;
    j = _n_;
    output;
    output;
run;

proc print data=A.base; title "base"; run;
proc print data=A.newbase; title "newbase (created with data step)"; run;

title "Listing";
proc datasets lib=A; run;


title "Listing after renaming using DATASETS";
proc datasets  lib=A nolist; change base=newbase2;  run; 
proc datasets  lib=A;
proc print data=A.newbase2; title "newbase2 (created with CHANGE statement in DATASETS)"; run;

data A.newbase3(drop=i);
    label something_meaningfull="Something Meaningfull";
    format something_meaningfull dollar6.;   
    set A.newbase2;
    something_meaningfull=i;
run;

proc datasets  lib=A nolist; 
    modify newbase2; 
    rename i=something_meaningfull; 
    format something_meaningfull dollar6.;   
    label something_meaningfull="Something Meaningfull";
run; 
proc print data=A.newbase2 label; title "newbase2 - after modification"; run;
proc print data=A.newbase3 label; title "newbase3 - modified with datastep"; run;

title;
proc datasets lib=A kill nolist;  run;





/*=================================================================*/
/*=============   DELETING                     ====================*/
/*=================================================================*/
title;
proc copy in=mydata out=A; run;
proc datasets lib=A; title "Listing of A";  run;
title "Listing of A";
proc datasets lib=A nolist; run;

proc datasets lib=A nolist; delete base2 country;  run;


title "Listing of A(after delete)";
proc datasets lib=A;run;

title;
proc datasets lib=A kill nolist;  run;