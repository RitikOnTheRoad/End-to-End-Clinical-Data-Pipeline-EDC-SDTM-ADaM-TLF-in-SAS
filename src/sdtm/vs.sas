/*STUDYID DOMAIN USUBJID VSTEST VSORRES VISIT*/
proc sql;
	create table vs01 as
	select 
	v.*,
	study_id as STUDYID,
	"VS" as DOMAIN,
	d.USUBJID,
	"SYSBP" as VSTEST,
	systolic_bp_mmhg as VSORRES,
	visit_name as VISIT
	from vs_raw as v
	left join sdtm.dm as d
	on v.subject_id=d.SUBJID;
quit;

/*VSSEQ VISITNUM VSDTC*/
proc sort data=vs01;
	by USUBJID assessment_date;
run;
data sdtm.vs;
	retain STUDYID DOMAIN USUBJID VSSEQ VSTEST VSORRES VISIT VSDTC;
	set vs01;
	by USUBJID;
	if first.USUBJID then VSSEQ=0;
	VSSEQ+1;
	VSDTC=put(assessment_date,E8601DA10.);
	keep STUDYID DOMAIN USUBJID VSSEQ VSTEST VSORRES VISIT VSDTC;
run;
	