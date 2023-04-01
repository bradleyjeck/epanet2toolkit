/*****************************************
*
* (C) Copyright IBM Corp. 2017, 2020
* Author: Bradley J Eck
*
* C Functions for calling EPANET from R 
*****************************************/

#include <stdio.h>
#include <string.h>
#define  EXTERN extern 
#include "types.h"
#include "epanet2.h" 

/**
void RgetOpenflag(int* flagval ){
	*flagval = __defaultProject.Openflag;
}

void RgetOpenHflag(int* flagval) {
    *flagval = 0; //OpenHflag;
}
**/

void RENepanet( char** inp, char** rpt, char** bin, int* ENreturn_value) {

  int rv;
  rv = ENepanet( *inp, *rpt, *bin, NULL);
  *ENreturn_value = rv;

}

void RENinit(char **rptFile, char **binOutFile, int *unitsType, int *headlossType, int *ENreturn_value){

  int rv;
  rv = ENinit( *rptFile, *binOutFile, *unitsType, *headlossType );
  *ENreturn_value = rv;
}


void RENopen(char **inpFile, char **rptFile, char **binOutFile, int* ENreturn_value){
  int rv;
  rv = ENopen( *inpFile, *rptFile, *binOutFile);
  *ENreturn_value = rv;
}

void RENgettitle(char **line1, char **line2, char **line3, int *ENreturn_value){
	int rv = ENgettitle( *line1, *line2, *line3);
	*ENreturn_value = rv;
}

void RENsettitle(char **line1, char **line2, char **line3, int *ENreturn_value){
	int rv;
	rv = ENsettitle(*line1, *line2, *line3);
	*ENreturn_value = rv;
}

void  RENsaveinpfile(char **filename, int* ENreturn_value){
  int rv;
  rv = ENsaveinpfile( *filename) ;
  *ENreturn_value = rv;
}

void RENclose(int* ENreturn_value){
  int rv;
  rv = ENclose();
  *ENreturn_value = rv;
}

void RENsolveH(int* ENreturn_value){
  int rv;
  rv = ENsolveH();
  *ENreturn_value = rv;
}

void RENsaveH(int* ENreturn_value){

  int rv;
  rv = ENsaveH();
  *ENreturn_value = rv;
}

void  RENopenH(int* ENreturn_value){
  int rv;
  rv = ENopenH();
  *ENreturn_value = rv;
}

void RENinitH(int initFlag, int* ENreturn_value){
  int rv;
  rv = ENinitH(initFlag);
  *ENreturn_value = rv;
}

void RENsavehydfile(char **filename, int *ENreturn_value){
	int rv;
	rv = ENsavehydfile(*filename);
	*ENreturn_value = rv;
}

void RENusehydfile(char **filename, int *ENreturn_value){
	int rv;
	rv = ENusehydfile(*filename);
	*ENreturn_value = rv;
}

void RENgettimeparam(int *code, char** value, int* ENreturn_value){
	int rv;
	long lval=0;
	long* plval;
	plval = &lval;
	rv = ENgettimeparam(*code, plval);
	size_t bufsize=50;
	snprintf(*value, bufsize, "%-38ld", *plval);
	*ENreturn_value=rv;
}

void RENsettimeparam(int *code, char** value, int* ENreturn_value){
	int rv;
	long lval=999999999;
	long *plval = &lval;
    char *p_v = value[0];
    sscanf(p_v, "%ld", plval);

	rv = ENsettimeparam(*code, lval);
	*ENreturn_value=rv;
}


void RENgetcount( int *code, int *count, int *ENreturn_value){
    int rv;
    int val = 0;
    int *pval;
    pval = &val;
	rv = ENgetcount( *code, pval);
	*count = val;
	*ENreturn_value=rv;
}

void RENgetversion( int* version, int *ENreturn_value){
    int rv;
    int val = 0;
    int *pval;
    pval = &val;
	rv = ENgetversion( pval);
	*version = val;
	*ENreturn_value=rv;

}

void RENgetoption(int *code, double *value, int *ENreturn_value ){
	int rv;
	EN_API_FLOAT_TYPE val = 0.0;
	EN_API_FLOAT_TYPE *pval;
	pval = &val;
	rv = ENgetoption(*code, pval) ;
	*value = (double) val;
	*ENreturn_value=rv;
}

void RENsetoption(int *code, double *value, int *ENreturn_value ){
	int rv;
	EN_API_FLOAT_TYPE val = (EN_API_FLOAT_TYPE) *value;
	rv = ENsetoption(*code, val) ;
	*ENreturn_value=rv;
}

void RENsolveQ( int *ENreturn_value){
	int rv;
	rv = ENsolveQ();
	*ENreturn_value=rv;
}

void RENopenQ( int *ENreturn_value){
	int rv;
	rv = ENopenQ();
	*ENreturn_value=rv;
}

void RENinitQ(int *saveFlag, int *ENreturn_value){
	int rv;
	rv = ENinitQ(*saveFlag);
	*ENreturn_value=rv;
}

void RENrunQ(char **time, int *ENreturn_value){
	int rv;
	long lval=0;
	long* plval;
	plval = &lval;
	rv = ENrunQ(plval);
	size_t bufsize=50;
	snprintf(*time, bufsize, "%-38ld", *plval);
	*ENreturn_value=rv;
}

void RENnextQ(char **time, int *ENreturn_value){
	int rv;
	long lval=0;
	long* plval;
	plval = &lval;
	rv = ENnextQ(plval);
	size_t bufsize=50;
	snprintf(*time, bufsize, "%-38ld", *plval);
	*ENreturn_value=rv;
}

void RENstepQ(char **time, int *ENreturn_value){
	int rv;
	long lval=0;
	long* plval;
	plval = &lval;
	rv = ENstepQ(plval);
	size_t bufsize=50;
	snprintf(*time, bufsize, "%-38ld", *plval);
	*ENreturn_value=rv;
}

void RENcloseQ( int *ENreturn_value){
	int rv;
	rv = ENcloseQ();
	*ENreturn_value = rv;
}

void RENgetqualtype( int *qc, int *tn, int *ENreturn_value){
	int rv;
	int qualcode=0;
	int tracenode=0;
	int *pqc;
	int *ptn;
	pqc = &qualcode;
	ptn = &tracenode;
	rv = ENgetqualtype( pqc, ptn) ;
	*qc = qualcode;
	*tn = tracenode;
	*ENreturn_value = rv;
}

void RENsetqualtype(int *code, char **chemname, char **chemunit, char **tracenode, int *ENreturn_value){
	int rv;
	char *cname;
	cname = chemname[0];
	char *cunit;
	cunit = chemunit[0];
	char *tnode;
	tnode = tracenode[0];

	rv = ENsetqualtype( *code, cname, cunit, tnode) ;
	*ENreturn_value = rv;
}

void RENgetqualinfo(int *code, char **chemname, char **chemunit, int *tracenode, int *ENreturn_value){
  int rv;

  char cn[32];
  cn[0]='a';
  char *pcn;
  pcn = &cn[0];

  char cu[32];
  cu[0]='b';
  char *pcu;
  pcu = &cu[0];

  rv = ENgetqualinfo( code, pcn, pcu, tracenode) ;
  *ENreturn_value = rv;
  strcpy(chemunit[0], cu);
  strcpy(chemname[0], cn);
}

void RENgetcoord( int* index, double *xx, double *yy, int *ENreturn_value){
    int nodeindex = *index;
    double x = 0.0;
    double y = 0.0;
    double* px;
    double* py;
    px = &x;
    py = &y;
    int rv;
    
    rv = ENgetcoord( nodeindex, px, py);
    *ENreturn_value = rv;
    *xx = x;
    *yy = y;

}

void RENsetcoord( int *index, double *xx, double *yy, int *ENreturn_value){
    int nodeindex = *index;
    double x =  *xx;
    double y =  *yy;
    int rv;

    rv = ENsetcoord( nodeindex, x, y);
    *ENreturn_value = rv;
}

void RENreport(int *ENreturn_value){
   int rv = ENreport();
   *ENreturn_value = rv;
}

void RENcopyreport(char **rptfile, int *ENreturn_value){
	int rv = ENcopyreport(*rptfile);
    *ENreturn_value = rv;
}
void RENclearreport(int *ENreturn_value){
	int rv = ENclearreport();
    *ENreturn_value = rv;
}
void RENresetreport(int *ENreturn_value){
	int rv = ENresetreport();
    *ENreturn_value = rv;
}
void RENsetreport(char **format, int *ENreturn_value){
	int rv = ENsetreport(*format);
	*ENreturn_value = rv;
}
void RENsetstatusreport(int *level, int *ENreturn_value){
	int lev = *level;
	int rv = ENsetstatusreport(lev);
	*ENreturn_value = rv;
}
void RENgeterror(int *errcode, char **errmsg, int *maxLen, int *ENreturn_value){
	int ecode = *errcode;
	int len = *maxLen;
	int rv = ENgeterror(ecode, *errmsg, len);
	*ENreturn_value = rv;
}
void RENgetstatistic(int *statcode, double *statval, int *ENreturn_value){
	int sc = *statcode;
	float sv=0.0;
	float *psv;
    psv = &sv;
	int rv = ENgetstatistic(sc, psv);
	*ENreturn_value = rv;
	*statval =(double) sv;
}

void RENgetresultindex(int *type, int *index, int *residx, int *ENreturn_value){
	int ty = *type;
	int iix = *index;
	int rix = 0;
	int *prix = &rix;
	int rv = ENgetresultindex(ty, iix, prix);
	*ENreturn_value = rv;
	*residx = rix;
}

void RENsetflowunits(int *units, int *ENreturn_value){
	int fu = *units;
	int rv = ENsetflowunits(fu);
	*ENreturn_value = rv;
}

void RENaddnode(char **id, int *nodeType, int *index, int *ENreturn_value){
	int ntype = *nodeType;
	int nix = 0;
	int *pnix = &nix;
	int rv = ENaddnode( *id, ntype, pnix);
	*ENreturn_value = rv;
	*index = nix;
}

void RENdeletenode(int *index, int *code, int *ENreturn_value){
	int idx = *index;
	int acode = *code;
	int rv = ENdeletenode(idx, acode);
	*ENreturn_value = rv;
}