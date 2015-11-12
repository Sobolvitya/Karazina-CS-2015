%let INCPATH = ~/my_content/include;
%include "&INCPATH/Sasdiff.sas";

%SASDIFF (
	FILEIN1= &INCPATH/data_base.txt, 
	FILEIN2= &INCPATH/data_comp.txt, 
	IGNORE_MATCHES=Y);
