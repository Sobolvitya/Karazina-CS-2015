/*http://blogs.sas.com/content/iml/2011/08/24/how-to-generate-random-numbers-in-sas.html*/

proc format;
value fname 1 = 'Tyrion'
          2 = 'Jamie'
          3 = 'Aria'
          4 = 'Daenerys'
          5 = "Sansa"
          6 = "Joffrey"
          7 = "Jon"
          8 = "Margaery"
          9 = "Hodor";
value lname
           1 = 'Baratheon'
           2 = 'Lannister'
           3 = 'Stark'
           4 = 'Targaryen'
           5 = "Tyrell"
           6 = "Snow"
           7 = "Baelish"
           8 = "Greyjoy"
           9 = "Reed"
            ;
value event
    1 = "GETS"
    2 = "SPENDS"
    3 = "GETS%"
    4 = "SPENDS%"
    5 = "DIES";
run;

%let CNT = 4;
%let EVENTS = 10;

data Characters;
    do n=1 to &CNT;
        name = catx(" ", put(ceil(9*rand("Uniform")), fname.), put(ceil(9*rand("Uniform")), lname.));
        weight = 50 + rand("Uniform")*100;
        height = 150 + rand("Uniform")*65;
        wealth = floor(rand ("Uniform")*10000);
        output;
    end;
run;
proc print data=Characters; title "Characters"; run;

