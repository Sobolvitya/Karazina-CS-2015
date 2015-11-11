%include "~/my_content/include/data_base.txt";
/*data base;*/
/*  input c $ n @@;  */
/*datalines;*/
/*a 1 b 2 c 3 d 4 e 5*/
/*;    */
/*run;*/
%include "~/my_content/include/data_comp.txt";
/*data comp;*/
/*  input c $ n @@;  */
/*datalines;*/
/*a 1 b 2 d 3 e 5*/
/*;    */
/*run;*/



proc compare base=base compare=comp;

