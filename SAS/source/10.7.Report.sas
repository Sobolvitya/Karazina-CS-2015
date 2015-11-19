data Age; 
  do Strata = 'A', 'B';
  do i = 100 to 100 + ceil(1000*ranuni(0));
  	 Age = 20 + ceil(20*ranuni(0));
	 output;
  end;
  end;


  drop i;
run;

/*proc print data=Age;*/

proc means data=Age P25 P75 noprint;
  by Strata;
  var Age;
  output out=AgeMeans(drop=_TYPE_ _FREQ_ rename=(_STAT_=Stat)); 
run;


data Sex;
  length Sex $6;

  do Strata = 'A', 'B';
    Sex = 'Male';
	Val = ranuni(0);
	output;
    Sex = 'Female';
	Val = 1-Val;
	output;
  end;
run;


proc sql;
  create table preRepData as 
  select 
    'Age(months)' as Cat ,
	Lower(Stat) as Label,
	Strata as Strata,
	Age as Value
  from AgeMeans
  union all 
  select 
    'Sex' as Cat ,
	Sex as Label,
	Strata as Strata,
	Val as Value
  from Sex;

  create table repData as
  select
    Cat, Label,
	max(ifn(Strata='A', Value, .)) as ValA,
	max(ifn(Strata='B', Value, .)) as ValB,
	Sum(Value) as ValTotal
  from preRepData
  group by Cat, Label;

  create table repDataCat as
  select distinct Cat from repData;
run;


/*proc print data=repData;*/

data repData_mod;
  set repDataCat repData;
  by cat;
  format _NUMERIC_ 7.1;
run;

/*proc print data=repData_mod;*/

options missing=' ';

ods rtf body = 'body.txt';
proc report data=repData_mod nowd;
  column Cat Label Lbl ValA ValB ValTotal;
  define Cat/order noprint;
  define Label/order missing noprint;
  define Lbl/computed;
  define ValA/ display width=20 left;
  define ValB/ display width=20;
  define ValTotal/ display width=20;

  compute before;
    tmp=0;
  endcomp;
  compute ValA;
    if mod(tmp, 2) = 1 then	call define(_col_, "style", "style=[backgroundcolor=yellow textalign=left]");
	  else call define(_col_, "style", "style=[backgroundcolor=red textalign=right]");
	tmp+1;
  endcomp;
  compute Lbl / character length=30;
    if Cat ~= '' then Lbl = Cat;
	  else Lbl = "  " || Label;
  endcomp; 
  compute after Cat;
    line ' ';
  endcomp;
run;
ods rtf close;
