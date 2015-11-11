data _null_;
	file print;
	put "%sysfunc(getoption(work))";
run;


/*http://blogs.sas.com/content/sasdummy/2012/12/18/using-sas-to-access-data-stored-on-dropbox/*/
proc datasets lib=work kill nolist; run;

filename _inbox "%sysfunc(getoption(work))/streaming.sas7bdat";

proc http method="get"
url="https://dl.dropbox.com/s/pgo6ryv8tfjodiv/streaming.sas7bdat"
out=_inbox
;
run;

proc contents data=work._all_;

proc print data=streaming;