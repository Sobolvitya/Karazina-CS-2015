/* example data set */ 
data one; 
  do byVar = "a", "b"; 
    do var = 1 to 100; 
      output; 
    end; 
  end;
run; 

filename res1 "D:\SAS Studies\MegaProject\Outdata\Res1.txt";
filename res2 "D:\SAS Studies\MegaProject\Outdata\Res2.txt";
 
options linesize=64 nonumber nodate; 
ods _all_ close;
ods listing file= res1;
%let pageno=0;

title "title";
proc report data=one nowd headline missing; 
  column byVar var; 
  define byVar / display; 
  define var / display; 
 
  compute before _page_;   
  	_page = input(symget('pageno'), best.);
    _page + 1; 
  	call symput('pageno', _page);
    line "page: " _page " of <<PAGENO>>"; 
  endcomp ; 
run;
ods listing;

data _null_;
  infile res1 lrecl=32767;
  file res2;
  input;
  _infile_ = tranwrd(_infile_ , "<<PAGENO>>", trim("&pageno"));
  put _infile_;
run;