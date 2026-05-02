/*STUDYID USUBJID AVISIT AVISITN PARAM AVAL*/
proc sql;
	create table advs01 as
	select
	STUDYID,
	USUBJID,
	VISIT as AVISIT,
	VSSEQ as AVISITN,
	VSTEST as PARAM,
	VSORRES as AVAL
	from sdtm.vs;
run;

/*BASE CHG*/
proc sort data=advs01;
	by USUBJID AVISITN;
run;
data advs02;
	set advs01;
	by USUBJID;
	if first.USUBJID then BASE=.;
	if AVISIT="Baseline" then BASE=AVAL;
	retain BASE;
	CHG=AVAL-BASE;
run;

/*TRTP*/
proc sql;
	create table advs03 as
	select 
	v.*,
	s.TRT01P as TRTP
	from advs02 as v
	right join adam.adsl as s
	on v.USUBJID=s.USUBJID;
quit;
proc sort data=advs03;
	by USUBJID AVISITN;
run;

data adam.advs;
	retain STUDYID USUBJID TRTP AVISIT AVISITN PARAM AVAL BASE CHG;
	set advs03;
run;
	