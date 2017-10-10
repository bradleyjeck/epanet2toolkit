/*****************************************
*
* (C) Copyright IBM Corp. 2017
* Author: Bradley J Eck
*
* Registering functions for calling EPANET from R 
*****************************************/

#include <stdio.h>
#include <string.h>
#include <R_ext/Rdynload.h>
#include "Repanet2.h"
#include "toolkit.h"

/********************************************
* Register methods with R
*********************************************/
static const R_CMethodDef cMethods[] = {
	{"RgetOpenflag"   , (DL_FUNC) &RgetOpenflag, 1},
    {"RgetOpenHflag"  , (DL_FUNC) &RgetOpenHflag, 1},
    {"RENepanet"      , (DL_FUNC) &RENepanet, 4},
    {"RENsaveinpfile" ,(DL_FUNC)  &RENsaveinpfile ,2},
    {"RENsolveH"      , (DL_FUNC) &RENsolveH      ,1},
    {"RENsaveH"       , (DL_FUNC) &RENsaveH       ,1},
	{"RENgettimeparam", (DL_FUNC) &RENgettimeparam,3},
	{"RENsettimeparam", (DL_FUNC) &RENsettimeparam,3},
	{"RENgetcount"    , (DL_FUNC) &RENgetcount    ,3},
	{"RENgetversion"  , (DL_FUNC) &RENgetversion  ,2},
	{"RENgetoption"   , (DL_FUNC) &RENgetoption   ,3},
	{"RENsetoption"   , (DL_FUNC) &RENsetoption   ,3},
	{"RENsolveQ"      , (DL_FUNC) &RENsolveQ      ,1},
	{"RENopenQ"       , (DL_FUNC) &RENopenQ       ,1},
	{"RENinitQ"       , (DL_FUNC) &RENinitQ       ,2},
	{"RENrunQ"        , (DL_FUNC) &RENrunQ        ,2},
	{"RENnextQ"       , (DL_FUNC) &RENnextQ       ,2},
	{"RENstepQ"       , (DL_FUNC) &RENstepQ       ,2},
	{"RENcloseQ"      , (DL_FUNC) &RENcloseQ      ,1},
	{"RENgetqualtype" , (DL_FUNC) &RENgetqualtype ,3},
	{"RENsetqualtype" , (DL_FUNC) &RENsetqualtype ,5},
	{"RENgetqualinfo" , (DL_FUNC) &RENgetqualinfo ,5},
	{"RENgetcoord"    , (DL_FUNC) &RENgetcoord    ,4},
	{"RENsetcoord"    , (DL_FUNC) &RENsetcoord    ,4},
        {"RENreport"      , (DL_FUNC) &RENreport      ,1},
    NULL
};

static const R_CallMethodDef callMethods[] ={
    {"enOpen"         , (DL_FUNC) &enOpen         , 1},
    {"enClose"        , (DL_FUNC) &enClose        , 0},
    {"enGetNodeIndex" , (DL_FUNC) &enGetNodeIndex , 1},
	{"enGetNodeID"    , (DL_FUNC) &enGetNodeID    , 1},
	{"enGetNodeType"  , (DL_FUNC) &enGetNodeType  , 1},
	{"enGetNodeValue" , (DL_FUNC) &enGetNodeValue , 2},
	{"enGetLinkIndex" , (DL_FUNC) &enGetLinkIndex , 1},
	{"enGetLinkID"    , (DL_FUNC) &enGetLinkID    , 1},
	{"enGetLinkType"  , (DL_FUNC) &enGetLinkType  , 1},
	{"enGetLinkValue" , (DL_FUNC) &enGetLinkValue , 2},
	{"enGetLinkNodes" , (DL_FUNC) &enGetLinkNodes , 1},
	{"enGetPatternID" , (DL_FUNC) &enGetPatternID , 1},
	{"enGetPatternIndex" , (DL_FUNC) &enGetPatternIndex , 1},
	{"enGetPatternLen", (DL_FUNC) &enGetPatternLen, 1},
	{"enGetPatternValue", (DL_FUNC) &enGetPatternValue, 2},
	{"enGetControl"   , (DL_FUNC) &enGetControl   , 1},
	{"enGetFlowUnits" , (DL_FUNC) &enGetFlowUnits , 0},
	{"enGetTimeParam" , (DL_FUNC) &enGetTimeParam , 1},
	{"enGetQualType"  , (DL_FUNC) &enGetQualType  , 0},
	{"enGetVersion"   , (DL_FUNC) &enGetVersion   , 0},
	{"enSetControl"   , (DL_FUNC) &enSetControl   , 6},
	{"enSetNodeValue" , (DL_FUNC) &enSetNodeValue , 3},
	{"enSetLinkValue" , (DL_FUNC) &enSetLinkValue , 3},
	{"enSetPattern"   , (DL_FUNC) &enSetPattern   , 3},
	{"enOpenH"        , (DL_FUNC) &enOpenH        , 0},
	{"enInitH"        , (DL_FUNC) &enInitH        , 1},
	{"enRunH"         , (DL_FUNC) &enRunH         , 0},
	{"enNextH"        , (DL_FUNC) &enNextH        , 0},
	{"enCloseH"       , (DL_FUNC) &enCloseH       , 0},
	{"enSetPatternValue",(DL_FUNC) &enSetPatternValue , 3},
	{"int2SEXP"       , (DL_FUNC) &int2SEXP       , 1},
	{"char2SEXP"      , (DL_FUNC) &char2SEXP      , 1},
	{"float2SEXP"     , (DL_FUNC) &float2SEXP     , 1},
	{"enSetQualType"  , (DL_FUNC) &enSetQualType  , 4},
    NULL
};

void R_init_epanet2toolkit(DllInfo *dll)
{
    R_registerRoutines(dll, cMethods, callMethods, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
