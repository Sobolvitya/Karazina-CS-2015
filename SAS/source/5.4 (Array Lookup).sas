%let CNT = 4;
%let EVENTS = 10;

data Characters;
	array smth[3] (1,2,3); 
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
