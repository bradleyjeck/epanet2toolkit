/*****************************************
*
* (C) Copyright IBM Corp. 2017, 2020
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
/*	{"RgetOpenflag"   , (DL_FUNC) &RgetOpenflag, 1},
    {"RgetOpenHflag"  , (DL_FUNC) &RgetOpenHflag, 1},  */
    {"RENepanet"      , (DL_FUNC) &RENepanet, 4},
	{"RENopen" 		  , (DL_FUNC) &RENopen, 4},
	{"RENclose"  	  , (DL_FUNC) &RENclose,       1},
	{"RENinit"        , (DL_FUNC) &RENinit, 5},
	{"RENgettitle"    , (DL_FUNC) &RENgettitle, 4},
    {"RENsaveinpfile" ,(DL_FUNC)  &RENsaveinpfile ,2},
	{"RENopenH"       , (DL_FUNC) &RENopenH       ,1},
	{"RENinitH"       , (DL_FUNC) &RENinitH       ,2},
	{"RENrunH"        , (DL_FUNC) &RENrunH       ,2},
	{"RENnextH"       , (DL_FUNC) &RENnextH       ,2},
	{"RENcloseH"      , (DL_FUNC) &RENcloseH       ,1},
    {"RENsolveH"      , (DL_FUNC) &RENsolveH      ,1},
    {"RENsaveH"       , (DL_FUNC) &RENsaveH       ,1},
    {"RENsavehydfile" , (DL_FUNC) &RENsavehydfile ,2},
    {"RENusehydfile"  , (DL_FUNC) &RENusehydfile  ,2},
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
    {"RENcopyreport"  , (DL_FUNC) &RENcopyreport  ,2},
    {"RENclearreport" , (DL_FUNC) &RENclearreport ,1},
    {"RENresetreport" , (DL_FUNC) &RENresetreport ,1},
    {"RENsetreport"   , (DL_FUNC) &RENsetreport   ,2},
    {"RENsetstatusreport", (DL_FUNC) &RENsetstatusreport,2},
	{"RENgeterror"    , (DL_FUNC) &RENgeterror    ,4},
	{"RENgetstatistic", (DL_FUNC) &RENgetstatistic,3},
	{"RENgetresultindex",(DL_FUNC) &RENgetresultindex,4},
	{"RENsetflowunits", (DL_FUNC) &RENsetflowunits,2},
	{"RENaddnode"     , (DL_FUNC) &RENaddnode     ,4},
	{"RENsetnodevalue", (DL_FUNC) &RENsetnodevalue,4},
	{"RENdeletenode"  , (DL_FUNC) &RENdeletenode  ,3},
	{"RENsetnodeid"   , (DL_FUNC) &RENsetnodeid   ,3},
	{"RENsetjuncdata" , (DL_FUNC) &RENsetjuncdata ,5},
	{"RENsettankdata" , (DL_FUNC) &RENsettankdata ,9},
	{"RENgetdemandmodel",(DL_FUNC) &RENgetdemandmodel,5},
	{"RENsetdemandmodel",(DL_FUNC) &RENsetdemandmodel,5},
	{"RENadddemand"   , (DL_FUNC) &RENadddemand   ,5},
	{"RENdeletedemand", (DL_FUNC) &RENdeletedemand,3},
	{"RENgetnumdemands", (DL_FUNC) &RENgetnumdemands,3},
	{"RENgetdemandindex", (DL_FUNC) &RENgetdemandindex,4},
	{"RENgetbasedemand", (DL_FUNC) &RENgetbasedemand,4},
	{"RENsetbasedemand", (DL_FUNC) &RENsetbasedemand,4},
	{"RENgetdemandpattern", (DL_FUNC) &RENgetdemandpattern,4},
	{"RENsetdemandpattern", (DL_FUNC) &RENsetdemandpattern,4},
	{"RENgetdemandname", (DL_FUNC) &RENgetdemandname,4},
	{"RENsetdemandname", (DL_FUNC) &RENsetdemandname,4},
	{"RENaddlink"      , (DL_FUNC) &RENaddlink     ,6},
	{"RENdeletelink"   , (DL_FUNC) &RENdeletelink  ,3},
	{"RENsetlinkid"    , (DL_FUNC) &RENsetlinkid   ,3},
	{"RENsetlinktype"  , (DL_FUNC) &RENsetlinktype ,4},
	{"RENsetlinknodes" , (DL_FUNC) &RENsetlinknodes,4},
	{"RENsetlinkvalue" , (DL_FUNC) &RENsetlinkvalue, 4},
	{"RENgetvertexcount",(DL_FUNC) &RENgetvertexcount,3},
	{"RENgetvertex"    , (DL_FUNC) &RENgetvertex    ,5},
	{"RENsetvertices"  , (DL_FUNC) &RENsetvertices  ,5},
	{"RENgetpumptype"  , (DL_FUNC) &RENgetpumptype  ,3},
	{"RENgetheadcurveindex" , (DL_FUNC) &RENgetheadcurveindex ,3},
	{"RENsetheadcurveindex" , (DL_FUNC) &RENsetheadcurveindex ,3},
	{"RENaddpattern"   , (DL_FUNC) &RENaddpattern   ,2},
	{"RENdeletepattern", (DL_FUNC) &RENdeletepattern,2},
	{"RENsetpatternid" , (DL_FUNC) &RENsetpatternid ,3},
	{"RENsetpattern"   , (DL_FUNC) &RENsetpattern   ,4},
	{"RENsetpatternvalue",(DL_FUNC) &RENsetpatternvalue, 4},
	{"RENgetaveragepatternvalue", (DL_FUNC) &RENgetaveragepatternvalue,3},
	{"RENaddcurve"     , (DL_FUNC) &RENaddcurve     ,2},
	{"RENdeletecurve"  , (DL_FUNC) &RENdeletecurve  ,2},
	{"RENgetcurveindex", (DL_FUNC) &RENgetcurveindex,3},
	{"RENgetcurveid"   , (DL_FUNC) &RENgetcurveid   ,3},
	{"RENsetcurveid"   , (DL_FUNC) &RENsetcurveid   ,3},
	{"RENgetcurvelen"  , (DL_FUNC) &RENgetcurvelen  ,3},
	{"RENgetcurvetype" , (DL_FUNC) &RENgetcurvetype ,3},
	{"RENgetcurvevalue", (DL_FUNC) &RENgetcurvevalue,5},
	{"RENsetcurvevalue", (DL_FUNC) &RENsetcurvevalue,5},
//	{"RENgetcurve"     , (DL_FUNC) &RENgetcurve     ,6},
//	{"RENsetcurve"     , (DL_FUNC) &RENsetcurve     ,5},
    {"RENsetcontrol"   , (DL_FUNC) &RENsetcontrol 	,7},
	{"RENaddcontrol"   , (DL_FUNC) &RENaddcontrol   ,7},
	{"RENdeletecontrol", (DL_FUNC) &RENdeletecontrol,2},
	{"RENaddrule"      , (DL_FUNC) &RENaddrule      ,2},
	{"RENdeleterule"   , (DL_FUNC) &RENdeleterule   ,2},
	{"RENgetrule"      , (DL_FUNC) &RENgetrule      ,6},
	{"RENgetruleID"    , (DL_FUNC) &RENgetruleID    ,3},
	{"RENgetpremise"   , (DL_FUNC) &RENgetpremise   ,10},
	{"RENsetpremise"   , (DL_FUNC) &RENsetpremise   ,10},
	{"RENsetpremiseindex",(DL_FUNC) &RENsetpremiseindex,4},
	{"RENsetpremisestatus",(DL_FUNC) &RENsetpremisestatus,4},
	{"RENsetpremisevalue",(DL_FUNC) &RENsetpremisevalue,4},
	{"RENgetthenaction", (DL_FUNC) &RENgetthenaction,6},
	{"RENsetthenaction", (DL_FUNC) &RENsetthenaction,6},
	{"RENgetelseaction", (DL_FUNC) &RENgetelseaction,6},
	{"RENsetelseaction", (DL_FUNC) &RENsetelseaction,6},
	{"RENsetrulepriority", (DL_FUNC) &RENsetrulepriority,3},
    {NULL}
};

static const R_CallMethodDef callMethods[] ={
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
	{"enSetQualType"  , (DL_FUNC) &enSetQualType  , 4},
    {NULL}
};

void R_init_epanet2toolkit(DllInfo *dll)
{
    R_registerRoutines(dll, cMethods, callMethods, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
