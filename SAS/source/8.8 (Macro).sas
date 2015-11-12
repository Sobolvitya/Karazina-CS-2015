%macro SIMPLEMACRO;
data _null_;
	file print;
	put "THIS IS A MACRO";
run;
%mend;

%macro LISTVARS_INLINE;
	array nm[*] _numeric_;
	if (_N_ =1); do;
		do i=1 to dim(nm); 
			VarName = VNAME(nm[i]);
			output;
		end;
	end;
	Keep Var:;
%mend;


%macro LISTVARS (TBLNAME);
data &TBLNAME._vars;
	set &TBLNAME;
	%LISTVARS_INLINE;	
run;
%mend;


%SIMPLEMACRO;

%LISTVARS (Characters);

proc print data=Characters_Vars;

data Ev_Vars;
	set Events;
	%LISTVARS_INLINE;
run;

proc print data=Ev_Vars;