title1 "The XYZ Company"; 
title3 "Sales Figures for Fiscal 2006"; 
title4 "Prepared by Roger Rabbit"; 
title5 "-----------------------------"; 
footnote "All sales figures are confidential"; 

proc sort data=bs.sales out=sales;
  by EmpId Region;

proc print data=sales;
 
proc print data=sales l n="Total number of Observations:" noobs; 
*  where Quantity gt 400; 
  by EmpID Region notsorted;
  sum Quantity TotalSales;
  sumby	EmpID;

  id ; 
  var EmpID Region Customer Quantity TotalSales; 
  format TotalSales dollar10.2 Quantity comma7.; 
  label EmpID = "Employee ID" 
           TotalSales = "Total Sales" 
           Quantity = "Number Sold";
run;

