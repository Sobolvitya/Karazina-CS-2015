%let CNT = 4;
%let EVENTS = 10;

proc format;
value event
    1 = "GETS"
    2 = "SPENDS"
    3 = "GETS%"
    4 = "SPENDS%"
    5 = "DIES";
run;


data Characters;
	array fnm{9} $ 20 _temporary_
	    ('Tyrion', 'Jamie' ,'Aria' ,'Daenerys' ,"Sansa"
          ,"Joffrey" ,"Jon" ,"Margaery" ,"Hodor");

	array lnm{9} $ 20 _temporary_
	    ('Baratheon', 'Lannister' ,'Stark' ,'Targaryen' ,"Tyrell"
          ,"Snow" ,"Baelish" ,"Greyjoy" ,"Reed");
 
    do n=1 to &CNT;
        name = catx(" ", fnm(ceil(dim(fnm)*rand("Uniform"))), 
			lnm(ceil(dim(lnm)*rand("Uniform"))));
        weight = 50 + rand("Uniform")*100;
        height = 150 + rand("Uniform")*65;
        wealth = floor(rand ("Uniform")*10000);
        output;
    end;
run;

proc print data=Characters; title "Characters"; run;

data Events (drop=u i j ev val);
	length n 8;
	array evs[&EVENTS] $10;
	array vals[*] val1-val&EVENTS;

	do n=1 to &CNT;
		do i=1 to &EVENTS;
	        u = ceil(100*rand("Uniform"));
	        if u<= 35 then do;
	            ev = 1;    
	            val = ceil(200*rand("Uniform")); 
	        end;else if u<=70 then do;
	            ev = 2;    
	            val = ceil(200*rand("Uniform")); 
	        end;else if u<=83 then do;
	            ev = 3;    
	            val = 0.4*rand("Uniform"); 
	        end;else if u<=96 then do;
	            ev = 4;    
	            val = 0.4*rand("Uniform"); 
	        end;else do; 
	            ev = 5;  
	            val = .; 
	        end; 

	        evs[i] = put(ev, event.);
			vals[i] = val;
/*			valsum = sum(vals);	*/
	    end;
	    output;
	end;
run;
proc print data=Events; run;

/*==============================================================================*/
/*===========================   SUM */
/*http://www.pauldickman.com/teaching/sas/functions.php*/
data event_sum(drop= evs: val: );
	set events;
	vsum = sum(of val1-val&EVENTS);
	vsum2 = sum(of val:);
	vsum3 = sum(of val1, val2, val3, val4, val5, val6, val7, val8, val9, val10);
	vsum4 = val1 + val2 + val3 + val4 + val5 + val6 + val7 + val8 + val9 + val10;
	vsum5 = sum(of evs1--val&EVENTS);
	nmiss = nmiss(of val:);
run;

data rawdata;
	input val1 val3 val2 value;
datalines;
1 1 1 1
2 2 2 2
1 2 3 4
3 2 1 0
;
run;

data sumdata;
	set rawdata;
	sum1 = sum(of val1-val3);
	sum2 = sum(of val1--val3);
	sum3 = sum(of _numeric_);
	sum4 = sum(of val:);
run;

proc print data=sumdata;


proc print data=event_sum;

/*==============================================================================*/
/*===========================   VARIABLES LISTING */
data vars;
	set Characters;
	array nm[*] _numeric_;
	if (_N_ =1); do;
		do i=1 to dim(nm); 
			VarName = VNAME(nm[i]);
			VarType = VTYPE(nm[i]);
			VarLen = VLENGTH(nm[i]);
			VarLabel= VLABEL(nm[i]);
			output;
		end;
	end;
	Keep Var:;
run;

proc print data=vars;

