data health;
input ID     NAME  $   TEAM $   WEIGHT;
datalines;
 1114    sally    blue      125       
 1114    lena    orange      125       
 1441    sue      green     145       
 1750    joey     red       189       
 1994    mark     yellow    165
 2304    joe      red       170
 ;

data fitness;
input ID     NAME  $   TEAM $   WEIGHT;
datalines;
 1114    garry    .      .
 1114    .    .      119
 1114    .    .      132
 1994    .     .    174
 2305    .      .       165
;

proc print data= health; title "health"; run;
proc print data= fitness; title "health"; run;

data newhealth;
update health fitness;
by id;
run; 

proc print data= newhealth; title "new health"; run;
