%let datapath = ~/my_content/example_data;
libname bs "&datapath";

%let path=~/my_content/example_data;
%let srcpath=~/my_content/example_data;

data bs.blood;
   infile "&srcpath/blood.txt" truncover;
   length Gender $ 6 BloodType $ 2 AgeGroup $ 5;
   input Subject 
         Gender 
         BloodType 
         AgeGroup
         WBC 
         RBC 
         Chol;
   label Gender = "Gender"
         BloodType = "Blood Type"
         AgeGroup = "Age Group"
         Chol = "Cholesterol";
run;

data bs.hosp;
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

data bs.sales;
   input    EmpID     :       $4. 
            Name      &      $15.
            Region    :       $5.
            Customer  &      $18.
            Date      : mmddyy10.
            Item      :       $8.
            Quantity  :        5.
            UnitCost  :  dollar9.;
   TotalSales = Quantity * UnitCost;
/*   format date mmddyy10. UnitCost TotalSales dollar9.;*/
   drop Date;
datalines;
1843 George Smith  North Barco Corporation  10/10/2006 144L 50 $8.99
1843 George Smith  South Cost Cutter's  10/11/2006 122 100 $5.99
1843 George Smith  North Minimart Inc.  10/11/2006 188S 3 $5,199
1843 George Smith  North Barco Corporation  10/15/2006 908X 1 $5,129
1843 George Smith  South Ely Corp.  10/15/2006 122L 10 $29.95
0177 Glenda Johnson  East Food Unlimited  9/1/2006 188X 100 $6.99
0177 Glenda Johnson  East Shop and Drop  9/2/2006 144L 100 $8.99
1843 George Smith  South Cost Cutter's  10/18/2006 855W 1 $9,109
9888 Sharon Lu  West Cost Cutter's  11/14/2006 122 50 $5.99
9888 Sharon Lu  West Pet's are Us  11/15/2006 100W 1000 $1.99
0017 Jason Nguyen  East Roger's Spirits  11/15/2006 122L 500 $39.99
0017 Jason Nguyen  South Spirited Spirits  12/22/2006 407XX 100 $19.95
0177 Glenda Johnson  North Minimart Inc.  12/21/2006 777 5 $10.500
0177 Glenda Johnson  East Barco Corporation  12/20/2006 733 2 $10,000
1843 George Smith  North Minimart Inc.  11/19/2006 188S 3 $5,199
;

*Data set CLINIC;
options fmtsearch=(bs);
proc format library=bs;
   value $dx 1 = 'Routine Visit'
             2 = 'Cold'
             3 = 'Heart Problems'
             4 = 'GI Problems'
             5 = 'Psychiatric'
             6 = 'Injury'
             7 = 'Infection';
run;
data bs.clinic;
   input ID : $5.
         VisitDate : mmddyy10.
         Dx : $3.
         HR SBP DBP;
   format VisitDate mmddyy10.
          Dx $dx.;
datalines;
101 10/21/2005 4 68 120 80
255 9/1/2005 1 76 188 100
255 12/18/2005 1 74 180 95
255 2/1/2006 3 79 210 110
255 4/1/2006 3 72 180 88
101 2/25/2006 2 68 122 84
303 10/10/2006 1 72 138 84
409 9/1/2005 6 88 142 92
409 10/2/2005 1 72 136 90
409 12/15/2006 1 68 130 84
712 4/6/2006 7 58 118 70
712 4/15/2006 7 56 118 72
;
