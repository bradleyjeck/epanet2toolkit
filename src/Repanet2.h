/*****************************************
*
* (C) Copyright IBM Corp. 2017
* Author: Bradley J Eck
*
* Function prototypes for calling EPANET from R 
* using .C()
*****************************************/


void RgetOpenflag(int* flagval );

void RgetOpenHflag(int* flagval);

void RENepanet( char** inp, char** rpt, char** bin, int* ENreturn_value);
 
void RENopen(char **inpFile, char **rptFile, char **binOutFile, int* ENreturn_value);

void RENsaveinpfile(char **filename, int* ENreturn_value);

void RENclose(int* ENreturn_value);

void RENsolveH(int* ENreturn_value);

void RENsaveH(int* ENreturn_value);

void  RENopenH(int* ENreturn_value);

void RENinitH(int initFlag, int* ENreturn_value);


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
