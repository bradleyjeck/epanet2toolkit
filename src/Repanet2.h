/*****************************************
*
* (C) Copyright IBM Corp. 2017, 2023
* Author: Bradley J Eck
*
* Function prototypes for calling EPANET from R 
* using .C()
*****************************************/


void RgetOpenflag(int* flagval );

void RgetOpenHflag(int* flagval);

void RENepanet( char** inp, char** rpt, char** bin, int* ENreturn_value);

void RENinit(char **rptFile, char **outFile, int *unitsType, int *headlossType, int *ENreturn_value);
 
void RENopen(char **inpFile, char **rptFile, char **binOutFile, int* ENreturn_value);

void RENgettitle(char **line1, char **line2, char **line3, int *ENreturn_value);

void RENsettitle(char **line1, char **line2, char **line3, int *ENreturn_value);

void RENsaveinpfile(char **filename, int* ENreturn_value);

void RENclose(int* ENreturn_value);

void RENsolveH(int* ENreturn_value);

void RENsaveH(int* ENreturn_value);

void  RENopenH(int* ENreturn_value);

void RENinitH(int initFlag, int* ENreturn_value);

void RENsavehydfile(char **filename, int *ENreturn_value);

void RENusehydfile(char **filename, int *ENreturn_value);


void RENgettimeparam(int *code, char** value, int* ENreturn_value);

void RENsettimeparam(int *code, char** value, int* ENreturn_value);



void RENgetcount( int *code, int *count, int *ENreturn_value);

void RENgetversion( int* version, int *ENreturn_value);

void RENgetoption(int *code, double *value, int *ENreturn_value );
void RENsetoption(int *code, double *value, int *ENreturn_value );

void RENsolveQ( int *ENreturn_value);

void RENopenQ( int *ENreturn_value);

void RENinitQ(int *saveFlag, int *ENreturn_value);

void RENrunQ(char **time, int *ENreturn_value);

void RENnextQ(char **time, int *ENreturn_value);

void RENstepQ(char **time, int *ENreturn_value);

void RENcloseQ( int *ENreturn_value);

void RENgetqualtype( int *qc, int *tn, int *ENreturn_value);

void RENsetqualtype(int *code, char **chemname, char **chemunit, char **tracenode, int *ENreturn_value);

void RENgetqualinfo(int *code, char **chemname, char **chemunit, int *tracenode, int *ENreturn_value);


void RENgetcoord( int *index, double *xx, double *yy, int *ENreturn_value);
void RENsetcoord( int *index, double *xx, double *yy, int *ENreturn_value);

void RENreport(int *ENreturn_value);

void RENcopyreport( char ** rptfile, int *ENreturn_value);
void RENclearreport(int *ENreturn_value);
void RENresetreport(int *ENreturn_value);
void RENsetreport(char **format, int *ENreturn_value);
void RENsetstatusreport(int *level, int *ENreturn_value);
void RENgeterror(int *errcode, char **errmsg, int *maxLen, int *ENreturn_value);
void RENgetstatistic(int *statcode, double *statval, int *ENreturn_value);