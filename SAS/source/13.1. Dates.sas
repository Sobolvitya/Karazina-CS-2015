*Data set HOSP;
data hosp;
   do j = 1 to 1000;
      AdmitDate = int(ranuni(1234)*1200 + 15500);
      quarter = intck('qtr','01jan2002'd,AdmitDate);
      do i = 1 to quarter;
         if ranuni(0) lt .1 and weekday(AdmitDate) eq 1 then
            AdmitDate = AdmitDate + 1;
         if ranuni(0) lt .1 and weekday(AdmitDate) eq 7 then
            AdmitDate = AdmitDate - int(3*ranuni(0) + 1);
         DOB = int(25000*Ranuni(0) + '01jan1920'd);
         DischrDate = AdmitDate + abs(10*rannor(0) + 1);
         Subject + 1;
         output;
      end;
   end;
   drop i j;
   format AdmitDate DOB DischrDate mmddyy10.;
run;

*Data set DISCHARGE;
data discharge;
   set hosp(keep=Subject DischrDate
                  rename=(Subject=PatNo)
                  where=(DischrDate between '01Jan2003'd
                         and '31Dec2003'd)
                  firstobs=208
                  obs=217);
run;



options yearcutoff=1926;

data four_dates; 
  infile datalines truncover; 
  input @1  Subject   $3. 
       @5 DOB       mmddyy10. 
       @16 VisitDate mmddyy8.  
       @26 TwoDigit  mmddyy8.  
       @34 LastDate  date9.; 

  Age = yrdif(DOB,VisitDate,'Actual'); 
  Age2 = yrdif(DOB,'01Jan2006'd,'Actual'); 
  Age3 = int(yrdif(DOB,today())); 
		   
  DOBF=put (DOB, ddmmyy.);
  Day = weekday(DOB); 
  DayOfMonth = day(DOB); 
  Month = Month(DOB); 
  Year = year(DOB); 
datalines;
001 10/21/1950 05122003 08/10/80 23Dec2005
002 01/01/1960 11122009 09/13/02 02Jan1960 
run;


proc print data=four_dates;

proc print data=four_dates;
	format DOB VisitDate date9. 
            TwoDigit mmddyy6. LastDate mmddyy8.;
run;

*Data set MONTH_DAY_YEAR;
data month_day_year;
  input Month Day Year;
  Date = mdy(Month, Day, Year); dt=Date; output;  
  Date+1; dt+1; output;
  Date+1.5; dt+1.5; output;
  format Date date.;
  format DT datetime.;
datalines;
10 21 1950
1 15 05
3 . 2005
5 7 2000
;

proc print data=month_day_year;

data intervals;
	length int $5;
	format D1 D2 Date9.;
	input (D1 D2)(: Date9.);
	do int='year', 'month', 'qtr', 'week';
		diff=intck(int, D1, D2);
		output;
	end;
datalines;
01Jan2005 31Dec2005
31Dec2005 01Jan2006
01Jan2005 31Jan2005
31Jan2005 01Feb2005
25Mar2005 15Apr2005
run;

data intervals;
	int = 'week30';
	format D1 Date9.;
	do D1=-7 to 27;
		wd = weekday(D1);
		diff=intck(int, D1, D1+1);
		output;
	end;
run;


data intervals2;
	format D1 D2 Date9.;
	input int :$10. (D1 D2)(: Date9.);
	diff=intck(int, D1, D2);
datalines;
year 01Jan2005 31Dec2005
year.2 01Jan2005 31Dec2005
year.2 31Jan2005 1Feb2005
year2 01Jan2005 01Jan2015
year3 01Jan60 01Jan70
year3.13 01Jan60 01Jan70
year3.25 01Jan60 01Jan70
run;

proc print data=intervals;
proc print data=intervals2;

data followup; 
     set discharge; 
     FollowDate = intnx('month',DischrDate,6); 
     format FollowDate date9.; 
  run;

*Data set HOSP;
data hosp;
   do j = 1 to 1000;
      AdmitDate = int(ranuni(1234)*1200 + 15500);
      quarter = intck('qtr','01jan2002'd,AdmitDate);
      do i = 1 to quarter;
         if ranuni(0) lt .1 and weekday(AdmitDate) eq 1 then
            AdmitDate = AdmitDate + 1;
         if ranuni(0) lt .1 and weekday(AdmitDate) eq 7 then
            AdmitDate = AdmitDate - int(3*ranuni(0) + 1);
         DOB = int(25000*Ranuni(0) + '01jan1920'd);
         DischrDate = AdmitDate + abs(10*rannor(0) + 1);
         Subject + 1;
         output;
      end;
   end;
   drop i j;
   format AdmitDate DOB DischrDate mmddyy10.;
run;

*Data set DISCHARGE;
data discharge;
   set hosp(keep=Subject DischrDate
                  rename=(Subject=PatNo)
                  where=(DischrDate between '01Jan2003'd
                         and '31Dec2003'd)
                  firstobs=208
                  obs=217);
  FollowDate1 = intnx('month2',DischrDate,3); 
  FollowDate2 = intnx('month2',DischrDate,3, 'sameday'); 
  FollowDate3 = intnx('month3',DischrDate,2, 'sameday'); 
     format FollowDate1-FollowDate3 mmddyy.;
run;

proc print data=discharge;

