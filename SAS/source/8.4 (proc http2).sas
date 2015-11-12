libname mydata "~/my_content/";
filename _inbox "~/my_content/streaming2.sas7bdat";

proc http method="get" 
 url="https://docs.google.com/uc?export=download%str(&)id=0BxXr-5OwM1J0OEU2eWlpUGFwdDg" 
 out=_inbox 
;
run;

/*proc contents data=mydata._all_ nods;*/
/*proc print data=mydata.streaming2(obs=15);*/
/**/
/*data mydata.streaming2;*/
/*	set mydata.streaming2;*/
/*	where SeriesTitle not like 'Waverly%';*/
/*run;*/
/**/
/*proc print data=mydata.streaming2(obs=15);*/




/*http://blogs.sas.com/content/sasdummy/2012/12/18/using-sas-to-access-data-stored-on-dropbox/*/
/*http://support.sas.com/documentation/cdl/en/proc/61895/HTML/default/viewer.htm#a003286808.htm*/
/*https://developers.google.com/drive/web/manage-uploads*/
/*http://stackoverflow.com/questions/10317638/inserting-file-to-google-drive-through-api*/

filename postPrm "~/my_content/postParams.txt";
filename postOut "~/my_content/postOut.txt";

data _null_;
   file postPrm;
   input; 
   put _infile_;
datalines4;
POST /upload/drive/v2/files/0BxXr-5OwM1J0S0ZobkY4ZW9YSlE?uploadType=media HTTP/1.1
Host: www.googleapis.com
Authorization: Bearer <OAuth 2.0 access token here>
Content-Type: mime/type

<file content here>
;;;;

proc http in=postPrm out=postOut
	url="https://www.googleapis.com/upload/drive/v2/files" ;
/*     method="POST";*/
run;

data _null_;
   file print;
   infile postOut;
   input; 
   put _infile_;
run;
