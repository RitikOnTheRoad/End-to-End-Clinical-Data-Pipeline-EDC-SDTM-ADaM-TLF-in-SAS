/*Joining ex_raw for ARM*/
proc sort data=ex_raw; /*Sort ex_raw to find the first administered dose*/
	by subject_id administration_date;
run;

data ex_join;
	set ex_raw;
	by subject_id;
	if first.subject_id;
run;

proc sql; /*dose_administered as a proxy for treatment arm */
	create table dm01 as
	select d.*,e.dose_administered from dm_raw as d
	left join ex_join as e
	on d.subject_id=e.subject_id;
quit;

data dm02;
	set dm01;
	length ARM $11;
	if dose_administered>50 then ARM="High Dose";
	else if dose_administered<=50 and dose_administered>20 then ARM="Medium Dose";
	else ARM="Low Dose";
run;

/*STUDYID DOMAIN USUBJID SUBJID AGE SEX ARMCD SITEID*/
data sdtm.dm;
	retain STUDYID DOMAIN USUBJID SUBJID SITEID AGE SEX ARMCD ARM;
	set dm02;
	STUDYID=study_id;
	DOMAIN="DM";
	USUBJID=catx("-",study_id,site_number,subject_id);
	SUBJID=subject_id;
	AGE=age_years;
	
	if gender="Male" then SEX="M"; else SEX="F";
	
	if ARM="High Dose" then ARMCD="HD"; 
	else if ARM="Medium Dose" then ARMCD="MD";
	else ARMCD="LD";
	
	SITEID=site_number;
	
	keep STUDYID DOMAIN USUBJID SUBJID SITEID AGE SEX ARMCD ARM;
run;

/*Validation*/
proc freq data=sdtm.dm;
	table ARM;
run;
	