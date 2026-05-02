/*STUDYID DOMAIN USUBJID EXTRT EXDOSE _exstdtc _exendtc*/
proc sql;
	create table ex01 as
	select e.*,
	study_id as STUDYID,
	"EX" as DOMAIN,
	d.USUBJID,
	upcase(study_drug_name) as EXTRT,
	dose_administered as EXDOSE,
	min(administration_date) as _exstdtc,
	max(administration_date) as _exendtc
	from ex_raw as e
	left join sdtm.dm as d
	on e.subject_id=d.SUBJID
	group by d.USUBJID;
quit;

/*EXSEQ EXSTDTC EXENDTC*/
proc sort data=ex01;
	by USUBJID administration_date;	
run;

data sdtm.ex;
	retain STUDYID DOMAIN USUBJID EXSEQ EXTRT EXDOSE EXSTDTC EXENDTC;
	set ex01;
	by USUBJID;
	if first.USUBJID then EXSEQ=0;
	EXSEQ+1;
	EXSTDTC=put(_exstdtc,E8601DA10.);
	EXENDTC=put(_exendtc,E8601DA10.);
	keep STUDYID DOMAIN USUBJID EXSEQ EXTRT EXDOSE EXSTDTC EXENDTC;
run;
	