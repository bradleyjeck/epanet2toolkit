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
void RENgetresultindex(int *type, int *index, int *residx, int *ENreturn_value);
void RENsetflowunits(int *units, int *ENreturn_value);

void RENaddnode(char **id, int *nodeType, int *index, int *ENreturn_value);
void RENdeletenode(int *index, int *code, int *ENreturn_value);
void RENsetnodeid(int *index, char **newid, int *ENreturn_value);
void RENsetjuncdata(int *index, double *elev, double *dmnd, char **dmndpat, int *enrv);
void RENsettankdata(int *index, double *elev, double *initlvl, double *maxlvl, double *diam, double *minvol, char **volcurve, int *enrv);

void RENgetdemandmodel( int *model, double *pmin, double *preq, double *pexp, int *enrv);
void RENsetdemandmodel(int *model, double *pmin, double *preq, double *pexp, int *enrv);
void RENadddemand(int *nodeIndex, double *baseDemand, char **demandPattern, char **demandName, int *enrv);
void RENdeletedemand(int *nodeIndex, int *demandIndex, int *enrv);
void RENgetnumdemands(int *nodeIndex, int *numDemands, int *enrv);
void RENgetdemandindex(int *nodeIndex, char **demandName, int *demandIndex, int *enrv);
void RENgetbasedemand(int *nodeIndex, int *demandIndex, double *baseDemand, int *enrv);
void RENsetbasedemand(int *nodeIndex, int *demandIndex, double *baseDemand, int *enrv);
void RENgetdemandpattern(int *nodeIndex, int *demandIndex, int *patIndex, int *enrv);
void RENsetdemandpattern(int *nodeIndex, int *demandIndex, int *patIndex, int *enrv);
void RENgetdemandname(int *nodeIndex, int *demandIndex, char **demandName, int *enrv);
void RENsetdemandname(int *nodeIndex, int *demandIndex, char **demandName, int *enrv);

void RENaddlink(char **id, int *linkType, char **fromNode, char **toNode, int *index, int *enrv);
void RENdeletelink(int *index, int *actionCode, int *enrv);
void RENsetlinkid(int *index, char **newid, int *enrv);
void RENsetlinktype(int *index, int *linkType, int *actionCode, int *enrv);
void RENgetlinknodes(int *index, int *node1, int *node2, int *enrv);
void RENsetlinknodes(int *index, int *node1, int *node2, int *enrv);
void RENgetvertexcount(int *index, int *count, int *enrv);
void RENgetvertex(int *index, int *vertex, double *x, double *y, int *enrv);
void RENsetvertices(int *index, double *x, double *y, int *count, int *enrv);

void RENgetpumptype(int *index, int *pumpType, int *enrv);
void RENgetheadcurveindex(int *linkIndex, int *curveIndex, int *enrv);
void RENsetheadcurveindex(int *linkIndex, int *curveIndex, int *enrv);

void RENaddpattern(char **id, int *enrv);
void RENdeletepattern(int *index, int *enrv);
void RENsetpatternid(int *index, char **id, int *enrv);
void RENgetaveragepatternvalue(int *index, double *value, int *enrv);

void RENaddcurve(char **id, int *enrv);
void RENdeletecurve(int *index, int *enrv);
void RENgetcurveindex(char **id, int *index, int *enrv);
void RENgetcurveid(int *index, char **id, int *enrv);
void RENsetcurveid(int *index, char **id, int *enrv);
void RENgetcurvelen(int *index, int *len, int *enrv);
void RENgetcurvetype(int *index, int *type, int *enrv);
void RENgetcurvevalue(int *curveIndex, int *pointIndex, double *x, double *y, int *enrv);
void RENsetcurvevalue(int *curveIndex, int *pointIndex, double *x, double *y, int *enrv);
//void RENgetcurve(int *index, char **id, int *nPoints, double *xValues, double *yValues, int *enrv);
//void RENsetcurve(int *index, double *xValues, double *yValues, int *nPoints, int *enrv);

void RENaddcontrol(int *type, int *linkIndex, double *setting, int *nodeIndex, double *level, int *index, int *enrv);
void RENdeletecontrol(int *index, int *enrv);
void RENgetcontrol(int *index, int *type, int *linkIndex, double *setting, int *nodeIndex, double *level, int *enrv);
void RENsetcontrol(int *index, int *type, int *linkIndex, double *setting, int *nodeIndex, double *level, int *enrv);

void RENaddrule(char **rule, int *enrv);
void RENdeleterule(int *index, int *enrv);
void RENgetrule(int *index, int *nPremises, int *nThenActions, int *nElseActions, double *priority, int *enrv);
void RENgetruleID(int *index, char **id, int *enrv);
void RENgetpremise(int *ruleIndex, int *premiseIndex, int *logop, int *object, int *objIndex, int *variable, int *relop, int *status, double *value, int *enrv);
void RENsetpremise(int *ruleIndex, int *premiseIndex, int *logop, int *object, int *objIndex, int *variable, int *relop, int *status, double *value, int *enrv);
void RENsetpremiseindex(int *ruleIndex, int *premiseIndex, int *objIndex, int *enrv);
void RENsetpremisestatus(int *ruleIndex, int *premiseIndex, int *status, int *enrv);
void RENsetpremisevalue(int *ruleIndex, int *premiseIndex, double *value, int *enrv);
void RENgetthenaction(int *ruleIndex, int *actionIndex, int *linkIndex, int *status, double *setting, int *enrv);
void RENsetthenaction(int *ruleIndex, int *actionIndex, int *linkIndex, int *status, double *setting, int *enrv);
void RENgetelseaction(int *ruleIndex, int *actionIndex, int *linkIndex, int *status, double *setting, int *enrv);
void RENsetelseaction(int *ruleIndex, int *actionIndex, int *linkIndex, int *status, double *setting, int *enrv);
void RENsetrulepriority(int *index, double *priority, int *enrv);





