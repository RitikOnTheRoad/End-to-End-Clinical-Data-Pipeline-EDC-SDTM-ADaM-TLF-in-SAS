/*STUDYID USUBJID SUBJID SITEID AGE SEX SAAFL TRT01P TRT01PN*/
proc sql;
	create table adsl01 as
	select 
	STUDYID,
	USUBJID,
	SUBJID,
	SITEID,
	AGE,
	SEX,
	"Y" as SAFFL,
	ARM as TRT01P,
	case 
		when ARM="Low Dose" then 1
		when ARM="Medium Dose" then 2
		else 3
		end as TRT01PN
	from sdtm.dm as d;
quit;
	
data adam.adsl;
	retain STUDYID USUBJID SUBJID SITEID AGE SEX SAFFL TRT01P TRT01PN;
	set adsl01(rename=(SITEID=_siteid));
	SITEID=put(_siteid,3.);
	drop _siteid;
run;