/*Libnames*/
/*SDTM outputs*/
libname sdtm "/home/u64281498/Clinical_Pipeline/Outputs/SDTM";
/*ADAM outputs*/
libname adam "/home/u64281498/Clinical_Pipeline/Outputs/ADaM";

/*Raw csv dataset import*/

/*dm_raw*/
proc import datafile="/home/u64281498/Clinical_Pipeline/data/raw_edc/dm_raw_20260428_131519.csv"
	 replace 
	 dbms=csv
	 out=dm_raw;
run;

/*ex_raw*/
proc import datafile="/home/u64281498/Clinical_Pipeline/data/raw_edc/ex_raw_20260428_131519.csv"
	 replace 
	 dbms=csv
	 out=ex_raw;
run;

/*ae_raw*/
proc import datafile="/home/u64281498/Clinical_Pipeline/data/raw_edc/ae_raw_20260428_131519.csv"
	 replace 
	 dbms=csv
	 out=ae_raw;
run;

/*vs_raw*/
proc import datafile="/home/u64281498/Clinical_Pipeline/data/raw_edc/vs_raw_20260428_131519.csv"
	 replace 
	 dbms=csv
	 out=vs_raw;
run;
