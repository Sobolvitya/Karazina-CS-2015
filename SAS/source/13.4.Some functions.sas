/*============= CONST*/
data constance; 
     Pi = constant ('pi'); 
     e = constant ('e'); 
     Integer3 = constant ('exactint',3); 
     Integer4 = constant ('exactint',4); 
     Integer5 = constant ('exactint',5); 
     Integer6 = constant ('exactint',6); 
     Integer7 = constant ('exactint',7); 
     Integer8 = constant ('exactint',8); 
run;

proc print data=constance;

/*============= DIF*/
data diff; 
     input Time Temperature; 
     Diff_temp = dif (Temperature); 
  datalines; 
  1 60 
  2 62 
  3 65 
  4 70 
  ;

proc print data=diff;


/*====================  STRINGS*/
libname learn "~/my_content/example_data";

data standard; 
	set learn.address; 
	Name = compbl(propcase (Name)); 
	Street = compbl(propcase (Street)); 
	City = compbl(propcase (City)); 
	State =  upcase(State); 
run;
proc print data=standard;



/*===========  CATS*/
title "Demonstrating the Concatenation Functions"; 
 
data xxxx; 
	First = 'Ron  '; 
	Last = 'Cody  '; 
	Join = ':' || First || 12345678901234; 
	Name1 = First || Last; 
	Name2 =  cat (First,123, Last); 
	Name3 =  cats(First,Last); 
	Name4 =  catx(' ',First,Last); 
	file print; 
	put Join= / 
		Name1= / 
		Name2= / 
		Name3= / 
		Name4= /; 
run;

proc contents data=xxxx;
/*===========  Blanks & Compress*/
title;
data blanks; 
     String = '  ABC '; 
     ***There are 3 leading and 2 trailing blanks in String; 
     JoinLeft = ':' ||  left(String) || ':'; 
     JoinTrim = ':' ||  trim(String) || ':'; 
     JoinStrip = ':' || strip(String) || ':'; 
run;

proc print data=blanks;

data phone; 
	length PhoneNumber $ 10; 
	set learn.phone; 

	PhoneNumber = compress (Phone,' ()-.'); 
	PhoneNumber2 = compress (Phone,,'kd');
run; 

proc print data=phone;

/*===========  Find*/
data English; 
	 set learn.mixed_nuts(rename= 
	           (Weight = Char_Weight 
	           Height = Char_Height)); 
	 if  find(Char_Weight,'lb','i') then 
	    Weight = input(compress (Char_Weight,,'kd'),8.); 
	 else if  find(Char_Weight,'kg','i') then 
	    Weight = 2.2*input(compress (Char_Weight,,'kd'),8.); 
	 if find(Char_Height,'in','i') then 
	    Height = input(compress (Char_Height,,'kd'),8.); 
	 else if  find(Char_Height,'cm','i') then 
	    Height = input(compress (Char_Height,,'kd'),8.)/2.54; 
run;

proc print data=english;


data look_for_roger; 
	input String $40.; 
	if  findw(String,'Roger') then Match = 'Yes'; 
	else Match = 'No'; 
datalines; 
Will Rogers 
Roger Cody 
Was roger here? 
Was Roger here? 
; 

proc print data=look_for_roger;

/*===========  Verify*/
title "Data Cleaning Application"; 
proc print data=learn.cleaning;
data _null_; 
	file print; 
	set learn.cleaning; 
	if  anyalpha (trim(Letters)) then put Subject= Letters=; 
	if  anydigit (trim(Numerals)) then put Subject= Numerals=; 
	if  anyalnum (trim(Both))   then put Subject= Both=; 
run;

data errors valid; 
     input ID $ Answer : $5.; 
     if  verify(Answer,'ABCDE') then output errors; 
     else output valid; 
datalines; 
001 AABDE 
002 A5BBD 
003 12345 
;

proc print data=valid; title 'valid'; run;
proc print data=errors; title 'errors'; run;



/*===========  Substr*/
data extract; 
	 input ID : $10. @@; 
	 length State $ 2 Gender $ 1 Last $ 5; 
	 State =  substr(ID,1,2); 
	 Number = input(substr(ID,3,2),3.); 
	 Gender = substr(ID,5,1); 
	 Last = substr(ID,6); 
datalines; 
NJ12M99 NY76F4512 TX91M5 
;
proc print data=extract;

data original; 
	input Name $ 30.; 
datalines; 
Jeffrey Smith 
Ron Cody 
Alan,Wilson 
Alfred E. Newman 
;
 
data first_last; 
	set original; 
	length First Last $ 15; 
	First =  scan(Name,1,' ,'); 
	Last = scan(Name,-1,' ,'); 
run;
proc print data=first_last;

/* ========= Compare */
data diagnosis; 
     input Code $10.; 
     if  compare(Code,'V450','i:') eq 0 then Match = 'Yes'; 
     else Match = 'No'; 
datalines; 
V450 
v450 
v450.100 
V900 
;

proc print data=diagnosis;

data _null_; 
     String1 = 'ABCY  '; 
     String2 = 'ABCXYZ'; 
     Compare1 = compare(String1,String2,':'); 
     Compare2 = compare(trim(String1),String2,':'); 
	 file print;
     put String1= String2= Compare1= Compare2=; 
run;

/*=========================== tranwrd*/
data address; 
     infile datalines dlm=' ,'; 
     *Blanks or commas are delimiters; 
     input #1 NameOrig $30. 
           #2 Line1 $40. 
           #3 City & $20. State : $2. Zip : $5.; 
 	 Name = NameOrig;
     Name = tranwrd(Name,'Mr.',' '); 
     Name = tranwrd(Name,'Mrs.',' '); 
     Name = tranwrd(Name,'Dr.',' '); 
     Name = tranwrd(Name,'Ms.',' '); 
     Name = left(Name); 
 
     Line1 =  tranwrd(Line1,'Street','St.'); 
     Line1 =  tranwrd(Line1,'Road','Rd.'); 
     Line1 =  tranwrd(Line1,'Avenue','Ave.'); 
datalines; 
Dr. Peter Benchley 
123 River Road 
Oceanside, NY 11518 
Mr. Robert Merrill 
878 Ocean Avenue 
Long Beach, CA 90818 
Mrs. Laura Smith 
80 Lazy Brook Road 
Flemington, NJ 08822 
;

proc print data=address;