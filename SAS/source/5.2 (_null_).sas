%let datapath = /courses/d2598a15ba27fe300;

/*1. _null_ for input*/
data _null_;
	infile "&datapath/Fall/textdata/internal_org.txt";
	input;
	put _infile_;
run;

/*2. _null_ for output*/
data _null_;
	file "&datapath/Fall/textdata/my_output.txt";
	
	put "Hello!";
	PUT "My name is Bogdan!";
	file log;
	put "Goodbye!";
	put "It was nice to meet you!";
run;

data _null_;
	infile "&datapath/Fall/textdata/my_output.txt";
	input;
	file print;
	put _infile_;
run;

data aaa;
	infile "&datapath/Fall/textdata/my_output.txt";
	input;
	text = _infile_;
run;

proc print data=aaa; 


/*3. _null_ and put JIC*/
data _null_;
input name $ 1-12 score1 score2 score3;
file print;
put name $12.-r +3 score1 3. score2 3. 
   score3 4.;
datalines;
Joseph                  11   32   76
Mitchel                 13   29   82
Sue Ellen               14   27   74
;


data _null_;
input name $ 1-12 score1 score2 score3;
file print;
put name $12.-l +3 score1 3. score2 3. 
   score3 4.;
datalines;
Joseph                  11   32   76
Mitchel                 13   29   82
Sue Ellen               14   27   74
;
