//*****************************************
//
// (C) Copyright IBM Corp. 2017
// Author: Ernesto Arandia & Bradley J Eck
//
//*****************************************


#ifndef TOOLKIT_H
#define TOOLKIT_H

#include <stdio.h>
#include <R.h>
#include <Rdefines.h>
#include <stdio.h>
#include <string.h>
//#include "types.h"
#define EXTERN extern 
#include "epanet2.h"

//void RgetOpenHflag(int* flagval );
SEXP enOpen(SEXP files);
SEXP enClose();
SEXP enGetNodeIndex(SEXP id);
SEXP enGetNodeID(SEXP index);
SEXP enGetNodeType(SEXP index);
SEXP enGetNodeValue(SEXP index, SEXP paramCode);
SEXP enGetLinkIndex(SEXP id);
SEXP enGetLinkID(SEXP index);
SEXP enGetLinkType(SEXP index);
SEXP enGetLinkValue(SEXP index, SEXP paramCode);
SEXP enGetLinkNodes(SEXP index);
SEXP enGetPatternID(SEXP index);
SEXP enGetPatternIndex(SEXP id);
SEXP enGetPatternLen(SEXP index);
SEXP enGetPatternValue(SEXP index, SEXP period);
SEXP enGetControl(SEXP cindex);
SEXP enGetCount(SEXP countcode);
SEXP enGetFlowUnits();
SEXP enGetTimeParam(SEXP paramcode);
SEXP enGetQualType();
SEXP enGetOption(SEXP optioncode);
SEXP enGetVersion();
SEXP enSetControl(SEXP cindex, SEXP ctype, SEXP lindex, SEXP setting, SEXP nindex, SEXP level);
SEXP enSetNodeValue(SEXP index, SEXP paramcode, SEXP value);
SEXP enSetLinkValue(SEXP index, SEXP paramcode, SEXP value);
SEXP enSetPattern(SEXP index, SEXP factors, SEXP nfactors);
SEXP enOpenH();
SEXP enInitH(SEXP flag);
SEXP enRunH();
SEXP enNextH();
SEXP enCloseH();
SEXP enSetPatternValue(SEXP index, SEXP period, SEXP value);
SEXP enSetQualType(SEXP qualcode, SEXP chemname, SEXP chemunits, SEXP tracenode);
SEXP int2SEXP(int myInt);
SEXP char2SEXP(char *myChar);
int SEXP2int(SEXP mySEXP);
SEXP float2SEXP(float myFloat);
float SEXP2float(SEXP mySEXP);
char *SEXP2char(SEXP mySEXP);
SEXP setlistint(SEXP sxvalue, SEXP sxerrorcode);
SEXP setlistfloat(SEXP sxvalue, SEXP sxerrorcode);
SEXP setlist2int(SEXP sxvalue1, SEXP sxvalue2, SEXP sxerrorcode);
SEXP setcontrollist(SEXP sxctype, SEXP sxlindex, SEXP sxsetting, SEXP sxnindex, SEXP sxlevel, SEXP sxerrorcode);

SEXP setlistci(SEXP sxvalue, SEXP sxerrorcode);
SEXP setlistic(SEXP sxvalue, SEXP sxerrorcode);

#endif

