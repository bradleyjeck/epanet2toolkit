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

void RENrunH(int* currentTime, int* ENreturn_value){
	int rv;
	long curtime;
	long *pcurtime = &curtime;
	rv = ENrunH(pcurtime);
	// return an int since R does not support long
	*currentTime = curtime; 
	*ENreturn_value = rv;
}

void RENnextH(int* tStep, int* ENreturn_value){
	int rv;
	long lngStep;
	long *pStep = &lngStep;
	rv = ENnextH(pStep);
	// return an int since R does not support long
	*tStep = lngStep;
	*ENreturn_value = rv;
}

void RENcloseH(int* ENreturn_value){
	int rv;
	rv = ENcloseH();
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

void RENsetnodeid(int *index, char **newid, int *ENreturn_value){
	int idx = *index;
	int rv = ENsetnodeid(idx, *newid);
	*ENreturn_value = rv;
}


void RENsetnodevalue(int *index, int *property, double *value, int *enrv){
	int rv;
	EN_API_FLOAT_TYPE val = (EN_API_FLOAT_TYPE) *value;
	rv = ENsetnodevalue(*index, *property, val);
	*enrv = rv;
}

void RENsetjuncdata(int *index, double *elev, double *dmd, char **dmdpat, int *ENreturn_value){
	int idx = *index;
	double elevation = *elev;
	double demand = *dmd;
	int rv = ENsetjuncdata(idx, elevation, demand, *dmdpat);
	*ENreturn_value = rv;
}

void RENsettankdata(int *index, double *elev, double *initlvl, double *minlvl,
                    double *maxlvl, double *diam, double *minvol, char **volcurve,
					int *ENreturn_value){
	int idx = *index;
	double elevation = *elev;
	double initlevel = *initlvl;
	double minlevel = *minlvl;
	double maxlevel = *maxlvl;
	double diameter = *diam;
	double minvolume = *minvol;

	int rv = ENsettankdata(idx, elevation, initlevel, minlevel, maxlevel, diameter, minvolume, *volcurve);
	*ENreturn_value=rv;
}

void RENgetdemandmodel(int *model, double *pmin, double *preq, double *pexp, int *enrv){

	EN_API_FLOAT_TYPE pressmin = 0.0;
	EN_API_FLOAT_TYPE pressrqd = 0.0;
	EN_API_FLOAT_TYPE pressexp = 0.0;
	EN_API_FLOAT_TYPE *ppmin = &pressmin;
	EN_API_FLOAT_TYPE *ppreq = &pressrqd;
	EN_API_FLOAT_TYPE *ppexp = &pressexp;
	int rv = ENgetdemandmodel(model, ppmin, ppreq, ppexp);
	*pmin = (double) pressmin;
	*preq = (double) pressrqd;
	*pexp = (double) pressexp;
	*enrv = rv;
}

void RENsetdemandmodel(int *model, double *pmin, double *preq, double *pexp, int *enrv){
	int mod = *model;
	EN_API_FLOAT_TYPE pressmin = *pmin;
	EN_API_FLOAT_TYPE pressrqd = *preq;
	EN_API_FLOAT_TYPE pressexp = *pexp;
	int rv = ENsetdemandmodel(mod, pressmin, pressrqd, pressexp);
	*enrv = rv;
}

void RENadddemand(int *index, double *baseDemand, char **dmdpatrn, char **dmdname, int *enrv){
    int idx = *index;
	double basedmd = *baseDemand;

	int rv = ENadddemand(idx, basedmd, *dmdpatrn, *dmdname);
	*enrv = rv;
}

void RENdeletedemand(int *nodeIndex, int *demandIndex, int *enrv){
    int nidx = *nodeIndex;
	int didx = *demandIndex;
	int rv = ENdeletedemand(nidx, didx);
	*enrv = rv;
}

void RENgetnumdemands(int *nodeIndex, int *numDemands, int *enrv){
	int nidx = *nodeIndex;
	int numd=0;
	int *pnumd=&numd;
	int rv = ENgetnumdemands(nidx,pnumd);
	*numDemands=numd;
	*enrv=rv;
}

void RENgetdemandindex(int *nodeIndex, char **demandName, int *demandIndex, int *enrv){
	int nidx = *nodeIndex;
    int didx=0;
	int *pdidx = &didx;
	int rv = ENgetdemandindex(nidx, *demandName, pdidx);
	*demandIndex = didx;
	*enrv = rv;
}

void RENgetbasedemand(int *nodeIndex, int *demandIndex, double *baseDemand, int *enrv){
	int nidx = *nodeIndex;
	int didx = *demandIndex;
	EN_API_FLOAT_TYPE bdmd=0.0;
	EN_API_FLOAT_TYPE *pbdmd = &bdmd;
	int rv = ENgetbasedemand(nidx, didx, pbdmd);
	*baseDemand = (double) bdmd;
	*enrv = rv;
}

void RENsetbasedemand(int *nodeIndex, int *demandIndex, double *baseDemand, int *enrv){
	int nidx = *nodeIndex;
	int didx = *demandIndex;
	double dmd = *baseDemand;
	int rv = ENsetbasedemand(nidx, didx,dmd);
	*enrv = rv;
}

void RENgetdemandpattern(int *nodeIndex, int *demandIndex, int *patIndex, int *enrv){
	int nidx = *nodeIndex;
	int didx = *demandIndex;
	int patidx = 0;
	int *ppatidx = &patidx;
	int rv = ENgetdemandpattern(nidx, didx, ppatidx);
	*patIndex = patidx;
	*enrv = rv;
}

void RENsetdemandpattern(int *nodeIndex, int *demandIndex, int *patIndex, int *enrv){
	int nidx = *nodeIndex;
	int didx = *demandIndex;
	int pidx = *patIndex;
	int rv = ENsetdemandpattern(nidx, didx, pidx);
	*enrv = rv;
}

void RENgetdemandname(int *nodeIndex, int *demandIndex, char **demandName, int *enrv){
	int nidx = *nodeIndex;
	int didx = *demandIndex;
	int rv = ENgetdemandname(nidx, didx, *demandName);
	*enrv = rv;
}

void RENsetdemandname(int *nodeIndex, int *demandIndex, char **demandName, int *enrv){
	int nidx = *nodeIndex;
	int didx = *demandIndex;
	int rv = ENsetdemandname(nidx, didx, *demandName);
	*enrv = rv;
}

void RENaddlink( char **id, int *linkType, char **fromNode, char **toNode, int *index, int *enrv){
	int ltype = *linkType;
	int idx = 0;
	int *pidx = &idx;
	int rv = ENaddlink(*id, ltype, *fromNode, *toNode, pidx);
	*enrv = rv;
	*index = idx;
}

void RENdeletelink(int *index, int *actionCode, int *enrv){
	int idx = *index;
	int action = *actionCode;
	int rv = ENdeletelink(idx, action);
	*enrv = rv; 
}

void RENsetlinkid(int *index, char **newid, int *enrv){
	int idx = *index;
	int rv = ENsetlinkid(idx, *newid);
	*enrv = rv;
}

void RENsetlinkvalue(int *index, int *property, double *value, int *enrv){
	int rv;
	EN_API_FLOAT_TYPE val = (EN_API_FLOAT_TYPE) *value;
	rv = ENsetlinkvalue(*index, *property, val);
	*enrv = rv;
}

void RENsetlinktype(int *index, int *linkType, int *actionCode, int *enrv){
	int type = *linkType;
	int action = *actionCode;
	int rv = ENsetlinktype(index, type, action);
	*enrv = rv;
}

void RENsetlinknodes(int *index, int *node1, int *node2, int *enrv){
	int idx = *index;
	int n1 = *node1;
	int n2 = *node2;
	int rv = ENsetlinknodes(idx, n1, n2);
	*enrv = rv;
}

void RENgetvertexcount(int *index, int *count, int *enrv){
	int idx = *index;
	int ct = 0;
	int *pct = &ct;
	int rv = ENgetvertexcount(idx, pct);
	*count = ct;
	*enrv = rv;
}

void RENgetvertex(int *index, int *vertex, double *x, double *y, int *enrv){
	int idx = *index;
	int ver = *vertex;
	double xx = 0.0;
	double yy = 0.0;
	double *pxx = &xx;
	double *pyy = &yy;
	int rv = ENgetvertex(idx, ver, pxx, pyy);
	*x = xx;
	*y = yy;
	*enrv = rv;
}

void RENsetvertices(int *index, double *x, double *y, int *count, int *enrv){
	int idx = *index;
	int ct = *count;
	int rv = ENsetvertices(idx, x, y, ct);
	*enrv = rv;
}

void RENgetpumptype(int *index, int *pumpType, int *enrv){
	int idx = *index;
	int rv = ENgetpumptype(idx, pumpType);
    *enrv = rv;
}

void RENgetheadcurveindex(int *linkIndex, int *curveIndex, int *enrv){
	int lidx = *linkIndex;
	int rv = ENgetheadcurveindex(lidx, curveIndex);
	*enrv = rv;
}

void RENsetheadcurveindex(int *linkIndex, int *curveIndex, int *enrv){
	int lidx = *linkIndex;
	int cidx = *curveIndex;
	int rv = ENsetheadcurveindex(lidx, cidx);
	*enrv = rv;
}

void RENaddpattern(char **id, int *enrv){
	int rv = ENaddpattern(*id);
	*enrv = rv;
}

void RENdeletepattern(int *index, int *enrv){
	int idx = *index;
	int rv = ENdeletepattern(idx);
	*enrv = rv;
}

void RENsetpatternid(int *index, char **id, int *enrv){
	int idx = *index;
	int rv = ENsetpatternid(idx,*id);
	*enrv = rv;
}

void RENsetpattern(int *index, double *values, int *len, int *enrv){
	int rv;
	int patlen=*len;
	EN_API_FLOAT_TYPE vals[patlen];
	for(int i=0; i < patlen; i++)
	    vals[i] = (EN_API_FLOAT_TYPE) values[i];
	rv = ENsetpattern(*index, vals, patlen);
	*enrv = rv;
} 

void RENsetpatternvalue(int *index, int *period, double *value, int *enrv){
	int rv;
	EN_API_FLOAT_TYPE val = (EN_API_FLOAT_TYPE) *value;
	rv = ENsetpatternvalue(*index, *period, val);
	*enrv = rv;
}

void RENgetaveragepatternvalue(int *index, double *value, int *enrv){
	int idx = *index;
	EN_API_FLOAT_TYPE val = 0.0;
	EN_API_FLOAT_TYPE *pval = &val;
	int rv = ENgetaveragepatternvalue(idx, pval);
	*value = (double) val;
	*enrv = rv;
}

void RENaddcurve(char **id, int *enrv){
	int rv = ENaddcurve(*id);
	*enrv = rv;
}

void RENdeletecurve(int *index, int *enrv){
	int idx = *index;
	int rv = ENdeletecurve(idx);
	*enrv = rv;
}

void RENgetcurveindex(char **id, int *index, int *enrv){
	int rv = ENgetcurveindex(*id, index);
	*enrv = rv;
}

void RENgetcurveid(int *index, char **id, int *enrv){
	int idx = *index;
	int rv = ENgetcurveid(idx, *id);
	*enrv = rv;
}

void RENsetcurveid(int *index, char **id, int *enrv){
    int idx = *index;
    int rv = ENsetcurveid(idx, *id);
	*enrv = rv;
}


void RENgetcurvelen(int *index, int *len, int *enrv){
	int idx = *index;
	int rv = ENgetcurvelen(idx, len);
	*enrv = rv;
}

void RENgetcurvetype(int *index, int *type, int *enrv){
	int idx = *index;
	int rv = ENgetcurvetype(idx, type);
	*enrv = rv;
}

void RENgetcurvevalue(int *curveIndex, int *pointIndex, double *x, double *y, int *enrv){
	int cidx = *curveIndex;
	int pidx = *pointIndex;
	EN_API_FLOAT_TYPE xx = 0.0;
	EN_API_FLOAT_TYPE *pxx = &xx;
	EN_API_FLOAT_TYPE yy = 0.0;
	EN_API_FLOAT_TYPE *pyy = &yy;
	int rv = ENgetcurvevalue(cidx, pidx, pxx, pyy);
	*x = (double) xx;
	*y = (double) yy;
	*enrv = rv;
}

void RENsetcurvevalue(int *curveIndex, int *pointIndex, double *x, double *y, int *enrv){
	int cidx = *curveIndex;
	int pidx = *pointIndex;
	double xx = *x;
	double yy = *y;
	int rv = ENsetcurvevalue(cidx, pidx, xx, yy);
	*enrv = rv;
}

/********************
void RENgetcurve(int *curveIndex, char **id, int *nPoints, double *x, double *y, int *enrv){
	int cidx = *curveIndex;
	double xx = 0.0;
	double *pxx = &xx;
	double yy = 0.0;
	double *pyy = &yy;
	int np = 0;
	int *pnp = &np;
	int rv = ENgetcurve(cidx, *id, *pnp,  *pxx, *pyy);
	*x = xx;
	*y = yy;
	*enrv = rv;
}

void RENsetcurve(int *curveIndex, double *x, double *y, int *nPts, int *enrv){
	int cidx = *curveIndex;
	int npts = *nPts;
	EN_API_FLOAT_TYPE xval = (EN_API_FLOAT_TYPE) *x;
	EN_API_FLOAT_TYPE *pxx = &xval;
	EN_API_FLOAT_TYPE yval = (EN_API_FLOAT_TYPE) *y;
	EN_API_FLOAT_TYPE *pyy = &yval;
	int rv = ENsetcurve(cidx, *pxx, *pyy, npts);
	*enrv = rv;
}

*********************************************/

void RENaddcontrol(int *type, int *linkIndex, double *setting, int *nodeIndex, double *level, int *index, int *enrv){

	int ct = *type;
	int lidx = *linkIndex;
	EN_API_FLOAT_TYPE set = *setting;
	int nidx = *nodeIndex;
	EN_API_FLOAT_TYPE lvl =  *level;
	int rv = ENaddcontrol(ct, lidx, set, nidx, lvl, index);
	*enrv = rv;
}

void RENsetcontrol(int *index, int *type, int *linkIndex, double *setting, int *nodeIndex, double *level, int *enrv){
	int rv;
	EN_API_FLOAT_TYPE set = (EN_API_FLOAT_TYPE) *setting;
	EN_API_FLOAT_TYPE lev = (EN_API_FLOAT_TYPE) *level;
	rv = ENsetcontrol(*index, *type, *linkIndex, set, *nodeIndex, lev);
	*enrv = rv;
}



void RENdeletecontrol(int *index, int *enrv){
	int idx = *index;
	int rv = ENdeletecontrol(idx);
	*enrv = rv;
}

void RENaddrule(char **rule, int *enrv){
	int rv = ENaddrule(*rule);
	*enrv = rv;
}

void RENdeleterule(int *index, int *enrv){
	int idx = *index;
	int rv = ENdeleterule(idx);
	*enrv = rv;
}

void RENgetrule(int *index, int *nPremises, int *nThenActions, int *nElseActions, double *priority, int *enrv){
	int idx = *index;

	EN_API_FLOAT_TYPE pty = 0.0;
	EN_API_FLOAT_TYPE *ppty = &pty;
	int rv = ENgetrule(idx, nPremises, nThenActions, nElseActions, ppty);
	*priority = (double) pty;
	*enrv = rv;
}


void RENgetruleID(int *index, char **id, int *enrv){
	int idx = *index;
	int rv = ENgetruleID(idx, *id);
	*enrv = rv;
}


void RENgetpremise(int *ruleIndex, int *premiseIndex, int *logop, int *object, int *objIndex, 
                   int *variable, int *relop, int *status, double *value, int *enrv){
	
	int ridx = *ruleIndex;
	int pidx = *premiseIndex;
	EN_API_FLOAT_TYPE val = 0.0;
	EN_API_FLOAT_TYPE *pval = &val;
	int rv = ENgetpremise(ridx, pidx, logop, object, objIndex, variable, relop, status, pval);
	*value = (double) val;
	*enrv = rv;
}


void RENsetpremise(int *ruleIndex, int *premiseIndex, int *logop, int *object, int *objIndex, 
                   int *variable, int *relop, int *status, double *value, int *enrv){
	
	int ridx = *ruleIndex;
	int pidx = *premiseIndex;
	int gop = *logop;
	int obj = *object;
	int oidx = *objIndex;
	int var = *variable;
	int rop = *relop;
	int stat = *status;
	EN_API_FLOAT_TYPE val = (EN_API_FLOAT_TYPE) *value;
	int rv = ENsetpremise(ridx, pidx, gop, obj, oidx, var, rop, stat, val);
	*enrv = rv;
}


void RENsetpremiseindex(int *ruleIndex, int *premiseIndex, int *objIndex, int *enrv){
	int ridx = *ruleIndex;
	int pidx = *premiseIndex;
	int oidx = *objIndex;
	int rv = ENsetpremiseindex(ridx, pidx, oidx);
	*enrv = rv;
}

void RENsetpremisestatus(int *ruleIndex, int *premiseIndex, int *status, int *enrv){
	int ridx = *ruleIndex;
	int pidx = *premiseIndex;
	int stat = *status;
	
	int rv = ENsetpremisestatus(ridx, pidx, stat);
	*enrv = rv;
}

void RENsetpremisevalue(int *ruleIndex, int *premiseIndex, double *value, int *enrv){
	int ridx = *ruleIndex;
	int pidx = *premiseIndex;
	EN_API_FLOAT_TYPE val = (EN_API_FLOAT_TYPE) *value;

	int rv = ENsetpremisevalue(ridx, pidx, val);
	*enrv = rv;
}

void RENgetthenaction(int *ruleIndex, int *actionIndex, int *linkIndex, int *status, double *setting, int *enrv){
    int ridx = *ruleIndex;
	int aidx = *actionIndex;
	EN_API_FLOAT_TYPE stg = 0.0;
	EN_API_FLOAT_TYPE *pstg = &stg; 
	int rv = ENgetthenaction(ridx, aidx, linkIndex, status, pstg);
	*setting = (double) stg;
	*enrv = rv;
}

void RENsetthenaction(int *ruleIndex, int *actionIndex, int *linkIndex, int *status, double *setting, int *enrv){
    int ridx = *ruleIndex;
	int aidx = *actionIndex;
	int lidx = *linkIndex;
	EN_API_FLOAT_TYPE stg = (EN_API_FLOAT_TYPE) *setting;
	int rv = ENsetthenaction(ridx, aidx, lidx, *status, stg);
	*enrv = rv;
}

void RENgetelseaction(int *ruleIndex, int *actionIndex, int *linkIndex, int *status, double *setting, int *enrv){
    int ridx = *ruleIndex;
	int aidx = *actionIndex;
	EN_API_FLOAT_TYPE stg = 0.0;
	EN_API_FLOAT_TYPE *pstg = &stg; 

	int rv = ENgetelseaction(ridx, aidx, linkIndex, status, pstg);
	*setting = (double) stg;
	*enrv = rv;
}

void RENsetelseaction(int *ruleIndex, int *actionIndex, int *linkIndex, int *status, double *setting, int *enrv){
    int ridx = *ruleIndex;
	int aidx = *actionIndex;
	int lidx = *linkIndex;
	int stat = *status;
	EN_API_FLOAT_TYPE stg = (EN_API_FLOAT_TYPE) *setting;

	int rv = ENsetelseaction(ridx, aidx, lidx, stat, stg);
	*enrv = rv;
}

void RENsetrulepriority(int *index, double *priority, int *enrv){
	int idx = *index;
	EN_API_FLOAT_TYPE pty = (EN_API_FLOAT_TYPE) *priority;

	int rv = ENsetrulepriority(idx, pty);
	*enrv = rv;
}

