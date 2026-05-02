/*Demographics Table (ADSL)*/
title1 "Demographics Table";
title2 "Mean age by Dose Group";
proc means data=adam.adsl mean ;
	class TRT01P;
	var AGE;
run;

title2 "Gender Distribution";
proc freq data=adam.adsl;
	table TRT01P*SEX;
run;

/*Primary Table (ADVS)*/
title "Primary Table";
title2 "SBP Change from Baseline";

proc means data=adam.advs mean stddev;
	class TRTP AVISIT/order=data;
	var CHG;
	where AVISIT ne "Screening";
run;

/*Safety Table*/
proc sql;
	create table adsl_ae as
	select 
	a.USUBJID,
	a.TRT01P,
	s.AETERM
	from adam.adsl as a
	inner join sdtm.ae as s
	on a.USUBJID=s.USUBJID;
quit;

title "Safety Table";
title2 "Adverse Events by Dose Group";
proc freq data=adsl_ae ;
	table TRT01P*AETERM /nopercent nocol norow;
run;


/*Change in SBP by Dose Group*/
title "Change in SBP by Dose Group";
title2 "Boxplot of CHG";
proc sgplot data=adam.advs;
    vbox CHG/Category=TRTP;
    where AVISIT ne "Screening"; 
run;