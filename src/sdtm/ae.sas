/*STUDYID DOMAIN USUBJID AETERM AESEV*/
proc sql;
	create table ae01 as
	select a.*,
	d.STUDYID,
	"DM" as DOMAIN,
	d.USUBJID,
	event_term as AETERM,
	upcase(severity) as AESEV
	from ae_raw as a
	left join sdtm.dm as d
	on a.subject_id=d.SUBJID;
quit;

/*AESEQ*/
proc sort data=ae01;
	by USUBJID start_date;
run;
data ae02;
	set ae01;
	by USUBJID;
	if first.USUBJID then AESEQ=0;
	AESEQ+1;
run;

/*AESTDTC AEENDTD*/
data sdtm.ae;
	retain STUDYID DOMAIN USUBJID AESEQ AETERM AESEV AESTDTC AEENDTC;
	set ae02;
	AESTDTC=put(dhms(start_date,0,0,start_time),E8601DT20.);
	AEENDTC=put(dhms(end_date,0,0,end_time),E8601DT20.);
	keep STUDYID DOMAIN USUBJID AESEQ AETERM AESEV AESTDTC AEENDTC;
run;

	
	