/* /* Nicholas Stambaugh, STA 216 04 */
/* Homework #2 */

/*Item #1 */
PROC IMPORT 
DATAFILE='/home/u56440190/STA 216/FantasyBaseball2.csv'
DBMS=CSV REPLACE OUT=FANTASY;
GETNAMES=YES;
RUN;

/*Item #2 */
PROC FORMAT;
VALUE personinitial  1 = "DJ"
					 2 = "AR"
					 3 = "BK"
					 4 = "JW"
					 5 = "TS"
					 6 = "RL"
					 7 = "DR"
					 8 = "MF"
;

DATA FANTASY; SET FANTASY;
SqrtTime = sqrt(time);
label time = 'Time to make selection (in seconds)'
	 person = 'Person making selection'
	 SqrtTime = 'Square root of time (in seconds) to make selection'
;
format Person personinitial.;


/*Item #3 */
PROC SGPLOT data=fantasy;
vbox time /group=person;
title "Comparison Boxplot: Times per Person";
title2 "Nicholas Stambaugh";
RUN;

PROC MEANS data=fantasy n min max mean std median skewness kurtosis maxdec=3;
var time;
class person;
title "Summary Statistics: Times per Person";
title2 "Nicholas Stambaugh";
RUN;

/*Item #4 */
ods graphics on;
PROC GLM data=fantasy plots=diagnostics;
class Person;
model Time = Person;
means Person / BON cldiff lines alpha = .05;
title 'ANOVA Model: Times = Person';
title2'Nicholas Stambaugh';
RUN; 

/*Item #5*/
PROC MEANS data=fantasy n min max mean std median skewness kurtosis maxdec=3;
var Sqrttime;
class person;
title "Summary Statistics: Sqrttime per person";
title2 "Nicholas Stambaugh";
RUN;

ods graphics on;
PROC GLM data=fantasy plots=diagnostics;
class Person;
model Sqrttime = person;
means Person / BON cldiff lines alpha = .05;
title 'ANOVA Model: SqrtTime = Person';
title2'Nicholas Stambaugh';
RUN; QUIT;




					 