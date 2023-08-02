/* Import the data */
proc import datafile='/home/u63491031/KIGEA/banklist.csv'
    dbms=csv
    out=banklist
    replace;
    getnames=yes;
run;

/*Sort the data by state and count the number of failed banks for each state */
proc sort data=banklist;
    by ST;
run;

proc freq data=banklist noprint;
    tables ST / out=failed_banks(keep=ST count rename=(count=failed_banks_count));
run;

/* Sort the results in descending order */
proc sort data=failed_banks;
    by descending failed_banks_count;
run;

/*  Display the output in descending order */
proc print data=failed_banks noobs;
    var ST failed_banks_count;
    title 'Number of Failed Banks by State ';
run;
