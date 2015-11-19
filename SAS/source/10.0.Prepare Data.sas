%let datapath = ~/my_content/example_data;
libname bs "&datapath";
proc contents data=bs._all_ nods;

*Data set BLOODPRESSURE;
data bs.bloodpressure;
   input Gender : $1. 
         Age
         SBP
         DBP;
datalines;
M 23 144 90
F 68 110 62
M 55 130 80
F 28 120 70
M 35 142 82
M 45 150 96
F 48 138 88
F 78 132 76
;


data bs.missing;
   input A $ B $ C $;
datalines;
X Y Z
X Y Y
Z Z Z
X X .
Y Z .
X . .
;


*Data set SALES;
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


data bs.medical;
   input Patno       : $3.
         Clinic      & $15.
         VisitDate   : mmddyy10.
         Weight      : 3.
         HR          : 3.
         DX          : $3.
         Comment     & $50.;
   format VisitDate mmddyy10.;
   label VisitDate = 'Visit Date'
         HR        = 'Heart Rate';
datalines;
001 Mayo Clinic  10/21/2006 120 78 7 Patient has had a persistent cough for 3 weeks
003 HMC  9/1/2006 166 58 8 Patient placed on beta-blockers on 7/1/2006
002 Mayo Clinic  10/01/2006 210 68 9 Patient has been on antibiotics for 10 days
004 HMC  11/11/2006 288 88 9 Patient advised to lose some weight
007 Mayo Clinic  5/1/2006 180 54 7 This patient is always under high stress
050 HMC  7/6/2006 199 60 123 Refer this patient to mental health for evaluation
;


*Data set BICYCLES;
data bs.bicycles;
   input Country  & $25.
         Model    & $14.
         Manuf    : $10.
         Units    :   5.
         UnitCost :  comma8.;
   TotalSales = (Units * UnitCost) / 1000;
   format UnitCost TotalSales dollar10.;
   label TotalSales = "Sales in Thousands"
         Manuf = "Manufacturer";
datalines;
USA  Road Bike  Trek 5000 $2,200
USA  Road Bike  Cannondale 2000 $2,100
USA  Mountain Bike  Trek 6000 $1,200
USA  Mountain Bike  Cannondale 4000 $2,700
USA  Hybrid  Trek 4500 $650
France  Road Bike  Trek 3400 $2,500
France  Road Bike  Cannondale 900 $3,700
France  Mountain Bike  Trek 5600 $1,300
France  Mountain Bike  Cannondale  800 $1,899
France  Hybrid  Trek 1100 $540
United Kingdom  Road Bike  Trek 2444 $2,100
United Kingdom  Road Bike  Cannondale  1200 $2,123
United Kingdom  Hybrid  Trek 800 $490
United Kingdom  Hybrid  Cannondale 500 $880
United Kingdom  Mountain Bike  Trek 1211 $1,121
Italy  Hybrid  Trek 700 $690
Italy  Road Bike  Trek 4500  $2,890
Italy  Mountain Bike  Trek 3400  $1,877
;

*Data set ASSIGN;
data temp;
   do Subject = 1 to 36;
      Group = ranuni(1357);
      output;
   end;
run;
proc format;
   value groupfmt 0 = 'A' 1 = 'B' 2 = 'C';
run;
proc rank data=temp groups=3 out=bs.assign;
   var Group;
   format Group groupfmt.;
   label Group = "Group";
run;
