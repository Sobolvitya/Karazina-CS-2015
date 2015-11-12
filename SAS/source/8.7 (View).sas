%let CNT = 4;
%let EVENTS = 10;

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


data Events (drop=u i ev);
	array events[5] $10 _temporary_ ("GETS","SPENDS","GETS%","SPENDS%","DIES"); 
    do i=1 to &CNT*&EVENTS;
        n = ceil(&CNT*rand("Uniform"));
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
        event = events(ev);

        output;
    end;
run;

proc print data=Characters; title "Characters"; run;
libname mydata "~/my_content/";
proc print data=Events(obs=15); title "Events"; run;
 
proc SQL;
	create view COMBINED as
		SELECT Characters.*, Events.Event, Events.val 
		FROM Characters
		LEFT JOIN Events
			ON Characters.n = Events.n;
run;

proc print data=COMBINED(obs=15); title "Combined"; run;

data Characters;
	set Characters;
	name = scan(name, 1);
run;



proc print data=Characters; title "Characters MOD"; run;
proc print data=COMBINED(obs=15); title "Combined MOD"; run;

proc contents data=work._all_ nods;