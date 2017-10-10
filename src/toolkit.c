//*****************************************
//
// (C) Copyright IBM Corp. 2017
// Author: Ernesto Arandia & Bradley J Eck
//
//*****************************************

#include "toolkit.h"


//---------------------
//  Helper functions
//---------------------


// convert int to SEXP
SEXP int2SEXP(int myInt) {

    SEXP result;
    int *pResult;
    PROTECT(result = NEW_INTEGER(1));
    pResult = INTEGER_POINTER(result);
    pResult[0] = myInt;
    UNPROTECT(1);
    return result;

}

// convert char to SEXP
SEXP char2SEXP(char *myChar) {

    SEXP result;
    PROTECT(result = allocVector(STRSXP, 1));
    SET_STRING_ELT(result, 0, mkChar(myChar));
    UNPROTECT(1);
    return result;//

}

// convert SEXP to int
int SEXP2int(SEXP mySEXP) {

    int result;
    mySEXP = coerceVector(mySEXP, INTSXP);
    result = INTEGER(mySEXP)[0];
    return result;

}

// convert float to SEXP
SEXP float2SEXP(float myFloat) {

    SEXP result;
    PROTECT(result = allocVector(REALSXP, 1));
    REAL(result)[0] = myFloat;
    UNPROTECT(1);
    return result;

}

// convert SEXP to float
float SEXP2float(SEXP mySEXP) {

    float result;
    mySEXP = coerceVector(mySEXP, REALSXP);
    result = (float)REAL(mySEXP)[0];
    return result;

}

// convert SEXP to char
char *SEXP2char(SEXP mySEXP) {

	char *pChar;
	PROTECT(mySEXP = AS_CHARACTER(mySEXP));
	pChar = R_alloc(strlen(CHAR(STRING_ELT(mySEXP, 0))), sizeof(char));
	strcpy(pChar, CHAR(STRING_ELT(mySEXP, 0)));
	UNPROTECT(1);
	return pChar;

}


//void RgetOpenHflag(int* flagval ){
//    *flagval = OpenHflag;
//}


SEXP setlistint(SEXP sxvalue, SEXP sxerrorcode) {
    
    int value = SEXP2int(sxvalue);
    int errorcode = SEXP2int(sxerrorcode);
    int *perrcode, *pvalue, i;
    SEXP envalue, enerror, list, listnames;
    char *names[2] = {"value", "errorcode"};
    
    // create an integer vector to hold the error code
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    
    // create a vector to hold the desired value
    PROTECT(envalue = NEW_INTEGER(1));
    pvalue = INTEGER_POINTER(envalue);
    
    // store the value and error code
    pvalue[0] = value;
    perrcode[0] = errorcode;
    
    // create a character string vector of the "names" attribute of the objects in out list
    PROTECT(listnames = allocVector(STRSXP,2));
    for(i = 0; i < 2; i++)
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    
    // create a list with 2 vector elements
    PROTECT(list = allocVector(VECSXP, 2));
    
    // attach value vector to list
    SET_VECTOR_ELT(list, 0, envalue);
    
    // attach enerror vector to list
    SET_VECTOR_ELT(list, 1, enerror);
    
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);
    
    UNPROTECT(4);
    return list;
    
}


SEXP setlist2int(SEXP sxvalue1, SEXP sxvalue2, SEXP sxerrorcode) {
    
    int value1 = SEXP2int(sxvalue1);
    int value2 = SEXP2int(sxvalue2);
    int errorcode = SEXP2int(sxerrorcode);
    int *perrcode, *pvalue, i;
    SEXP envalue, enerror, list, listnames;
    char *names[2] = {"value", "errorcode"};
    
    // create an integer vector to hold the error code
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    
    // create a vector to hold the desired value
    PROTECT(envalue = NEW_INTEGER(2));
    pvalue = INTEGER_POINTER(envalue);
    
    // store the value and error code
    pvalue[0] = value1;
    pvalue[1] = value2;
    perrcode[0] = errorcode;
    
    // create a character string vector of the "names" attribute of the objects in out list
    PROTECT(listnames = allocVector(STRSXP,2));
    for(i = 0; i < 2; i++)
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    
    // create a list with 2 vector elements
    PROTECT(list = allocVector(VECSXP, 2));
    
    // attach value vector to list
    SET_VECTOR_ELT(list, 0, envalue);
    
    // attach enerror vector to list
    SET_VECTOR_ELT(list, 1, enerror);
    
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);
    
    UNPROTECT(4);
    return list;
    
}


SEXP setlistic(SEXP sxvalue, SEXP sxerrorcode) {
    
    //char *value = SEXP2char(sxvalue);
    int errorcode = SEXP2int(sxerrorcode);
    int *perrcode, i;
    SEXP envalue, enerror, list, listnames;
    char *names[2] = {"value", "errorcode"};
    
    // create an integer vector to hold the error code
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    
    // create a character string vector to hold the desired value
    PROTECT(envalue = allocVector(STRSXP, 1));
    SET_STRING_ELT(envalue, 0, mkChar("abbds"));
    
    // store the value and error code
    //pvalue[0] = value;
    perrcode[0] = errorcode;
    
    // create a character string vector of the "names" attribute of the objects in out list
    PROTECT(listnames = allocVector(STRSXP, 2));
    for(i = 0; i < 2; i++)
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    
    // create a list with 2 vector elements
    PROTECT(list = allocVector(VECSXP, 2));
    
    // attach value vector to list
    SET_VECTOR_ELT(list, 0, envalue);
    
    // attach enerror vector to list
    SET_VECTOR_ELT(list, 1, enerror);
    
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);
    
    UNPROTECT(4);
    return list;
    
}


SEXP setlistfloat(SEXP sxvalue, SEXP sxerrorcode) {
    
    // create a numeric vector to hold the desired value
    SEXP envalue;
    double *pvalue;
    PROTECT(envalue = NEW_NUMERIC(1));
    pvalue = NUMERIC_POINTER(envalue);
    pvalue[0] = (double)SEXP2float(sxvalue);
    
    // create an integer vector to hold the error code
    SEXP enerror;
    int *perrcode;
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    perrcode[0] = SEXP2int(sxerrorcode);
    
    // create "names" attribute for return list
    SEXP listnames;
    PROTECT(listnames = allocVector(STRSXP, 2));
    char *names[2] = {"value", "errorcode"};
    for(int i = 0; i < 2; i++) {
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    }
    
    // create a list with 2 vector elements
    SEXP list;
    PROTECT(list = allocVector(VECSXP, 2));
    
    // attach error code vector to list
    SET_VECTOR_ELT(list, 1, enerror);
    
    // attach value vector to list
    SET_VECTOR_ELT(list, 0, envalue);
    
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);
    
    UNPROTECT(4);
    return list;
    
}


SEXP setcontrollist(SEXP sxctype, SEXP sxlindex, SEXP sxsetting, SEXP sxnindex, SEXP sxlevel, SEXP sxerrorcode) {
    
    // create a vector to hold the integer values
    SEXP intvalue;
    int *pintvalue;
    PROTECT(intvalue = NEW_INTEGER(3));
    pintvalue = INTEGER_POINTER(intvalue);
    // store the integer values
    pintvalue[0] = SEXP2int(sxctype);
    pintvalue[1] = SEXP2int(sxlindex);
    pintvalue[2] = SEXP2int(sxnindex);
    
    // create a vector to hold the float values
    SEXP floatvalue;
    double *pfloatvalue;
    PROTECT(floatvalue = NEW_NUMERIC(2));
    pfloatvalue = NUMERIC_POINTER(floatvalue);
    // store the float values
    pfloatvalue[0] = (double)SEXP2float(sxsetting);
    pfloatvalue[1] = (double)SEXP2float(sxlevel);
    
    // create an integer vector to hold the error code
    SEXP enerror;
    int *perrcode;
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    // store the error code
    perrcode[0] = SEXP2int(sxerrorcode);
    
    // create a character string vector of the "names" attribute of the objects in out list
    char *names[3] = {"valueint", "valuefloat", "errorcode"};
    SEXP listnames;
    PROTECT(listnames = allocVector(STRSXP, 3));
    for(int i = 0; i < 3; i++) {
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    }
    
    // create a list with 3 vector elements
    SEXP list;
    PROTECT(list = allocVector(VECSXP, 3));
    // attach integer value vector to list
    SET_VECTOR_ELT(list, 0, intvalue);
    // attach float value vector to list
    SET_VECTOR_ELT(list, 1, floatvalue);
    // attach enerror vector to list
    SET_VECTOR_ELT(list, 2, enerror);
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);
    
    UNPROTECT(5);
    return list;
    
}


//=================================
// Functions for opening/closing
//=================================


SEXP enOpen(SEXP files) {

    char *pFiles[3];

    PROTECT(files = AS_CHARACTER(files));

    // allocate memory
    pFiles[0] = R_alloc(strlen(CHAR(STRING_ELT(files, 0))), sizeof(char));
    pFiles[1] = R_alloc(strlen(CHAR(STRING_ELT(files, 1))),  sizeof(char));
    pFiles[2] = R_alloc(strlen(CHAR(STRING_ELT(files, 2))),  sizeof(char));

    // copy argument to allocated variable
    strcpy(pFiles[0], CHAR(STRING_ELT(files, 0)));
    strcpy(pFiles[1], CHAR(STRING_ELT(files, 1)));
    strcpy(pFiles[2], CHAR(STRING_ELT(files, 2)));

    // open the INP file
    int errcode = ENopen(pFiles[0], pFiles[1], pFiles[2]);
    int res;
    if (errcode > 0) {
        res = errcode;
    }
    else {
        res = errcode;
    }
    SEXP result = int2SEXP(res);
    UNPROTECT(1);
    return result;

 }

SEXP enClose() {

    // close the INP file
    int errcode = ENclose();

    // make the output
    SEXP result = int2SEXP(errcode);
    return result;

}


//======================
// Functions for nodes
//======================

SEXP enGetNodeIndex(SEXP id) {

    char *pID;

    PROTECT(id = AS_CHARACTER(id));

    // allocate memory
    pID = R_alloc(strlen(CHAR(STRING_ELT(id, 0))), sizeof(char));

    // copy the argument
    strcpy(pID, CHAR(STRING_ELT(id, 0)));

    // get the node index
    int value;
    int errcode = ENgetnodeindex(pID, &value);
    
    // create an integer vector to hold the desired value
    SEXP envalue;
    int *pvalue;
    PROTECT(envalue = NEW_INTEGER(1));
    pvalue = INTEGER_POINTER(envalue);
    pvalue[0] = value;
    // create an integer vector to hold the error code
    SEXP enerror;
    int *perrcode;
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    perrcode[0] = errcode;
    // create a character string vector of the "names" attribute of the objects in out list
    SEXP listnames;
    PROTECT(listnames = allocVector(STRSXP, 2));
    char *names[2] = {"value", "errorcode"};
    for(int i = 0; i < 2; i++)
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    // create a list with 2 vector elements
    SEXP list;
    PROTECT(list = allocVector(VECSXP, 2));
    // attach enerror vector to list
    SET_VECTOR_ELT(list, 1, enerror);
    // attach value vector to list
    SET_VECTOR_ELT(list, 0, envalue);
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);

    // make the output
    UNPROTECT(5);
    return list;

}


SEXP enGetNodeID(SEXP index) {

    int ind = SEXP2int(index);

    // get the node ID
    char cid[16];
    int errcode = ENgetnodeid(ind, cid);
    
    // create a character string vector to hold the desired value
    SEXP envalue;
    PROTECT(envalue = allocVector(STRSXP, 1));
    SET_STRING_ELT(envalue, 0, mkChar(cid));
    // create an integer vector to hold the error code
    SEXP enerror;
    int *perrcode;
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    perrcode[0] = errcode;
    // create a character string vector of the "names" attribute of the objects in out list
    SEXP listnames;
    PROTECT(listnames = allocVector(STRSXP, 2));
    char *names[2] = {"value", "errorcode"};
    for(int i = 0; i < 2; i++)
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    // create a list with 2 vector elements
    SEXP list;
    PROTECT(list = allocVector(VECSXP, 2));
    // attach enerror vector to list
    SET_VECTOR_ELT(list, 1, enerror);
    // attach value vector to list
    SET_VECTOR_ELT(list, 0, envalue);
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);

    UNPROTECT(4);
    return list;

}


SEXP enGetNodeType(SEXP index) {

    int ind = SEXP2int(index);

    // get the node ID
    int type;
    int errcode = ENgetnodetype(ind, &type);
    
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = int2SEXP(type);
    
    // store the value and error code in the result list
    SEXP resultlist = setlistint(sxvalue, sxerr);
    
    return resultlist;

}


SEXP enGetNodeValue(SEXP index, SEXP paramCode) {

    int ind = SEXP2int(index);
    int code = SEXP2int(paramCode);

    // get the node value
    float value;
    int errcode = ENgetnodevalue(ind, code, &value);

    // store the value and error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = float2SEXP(value);
    SEXP resultlist = setlistfloat(sxvalue, sxerr);
    
    return resultlist;

}


SEXP enSetNodeValue(SEXP index, SEXP paramcode, SEXP value) {
    
    // set the node value and return error code
    int ind = SEXP2int(index);
    int code = SEXP2int(paramcode);
    float val = SEXP2float(value);
    int errcode = ENsetnodevalue(ind, code, val);
    
    // store error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = R_NilValue;
    SEXP resultlist = setlistfloat(sxvalue, sxerr);
    
    return resultlist;
    
}


//======================
// Functions for links
//======================


SEXP enGetLinkIndex(SEXP id) {

    char *pID;

    PROTECT(id = AS_CHARACTER(id));

    // allocate memory
    pID = R_alloc(strlen(CHAR(STRING_ELT(id, 0))), sizeof(char));

    // copy the argument
    strcpy(pID, CHAR(STRING_ELT(id, 0)));

    // get the link index
    int index;
    int errcode = ENgetlinkindex(pID, &index);

    // create an integer vector to hold the desired value
    SEXP envalue;
    int *pvalue;
    PROTECT(envalue = NEW_INTEGER(1));
    pvalue = INTEGER_POINTER(envalue);
    pvalue[0] = index;
    // create an integer vector to hold the error code
    SEXP enerror;
    int *perrcode;
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    perrcode[0] = errcode;
    // create a character string vector of the "names" attribute of the objects in out list
    SEXP listnames;
    PROTECT(listnames = allocVector(STRSXP, 2));
    char *names[2] = {"value", "errorcode"};
    for(int i = 0; i < 2; i++)
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    // create a list with 2 vector elements
    SEXP list;
    PROTECT(list = allocVector(VECSXP, 2));
    // attach enerror vector to list
    SET_VECTOR_ELT(list, 1, enerror);
    // attach value vector to list
    SET_VECTOR_ELT(list, 0, envalue);
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);
    
    // make the output
    UNPROTECT(5);
    return list;
    
}


SEXP enGetLinkID(SEXP index) {

    int ind = SEXP2int(index);

    // get the link ID
    char cid[16];
    int errcode = ENgetlinkid(ind, cid);
    
    // create a character string vector to hold the desired value
    SEXP envalue;
    PROTECT(envalue = allocVector(STRSXP, 1));
    SET_STRING_ELT(envalue, 0, mkChar(cid));
    // create an integer vector to hold the error code
    SEXP enerror;
    int *perrcode;
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    perrcode[0] = errcode;
    // create a character string vector of the "names" attribute of the objects in out list
    SEXP listnames;
    PROTECT(listnames = allocVector(STRSXP, 2));
    char *names[2] = {"value", "errorcode"};
    for(int i = 0; i < 2; i++)
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    // create a list with 2 vector elements
    SEXP list;
    PROTECT(list = allocVector(VECSXP, 2));
    // attach enerror vector to list
    SET_VECTOR_ELT(list, 1, enerror);
    // attach value vector to list
    SET_VECTOR_ELT(list, 0, envalue);
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);
    
    UNPROTECT(4);
    return list;

}

SEXP enGetLinkType(SEXP index) {

    // get the node index
    int ind = SEXP2int(index);
    int type;
    int errcode = ENgetlinktype(ind, &type);
    
    // convert and store the values in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = int2SEXP(type);
    SEXP resultlist = setlistint(sxvalue, sxerr);
    
    return resultlist;

}


SEXP enGetLinkNodes(SEXP index) {

    // get the link nodes
	int ind = SEXP2int(index);
	int node1, node2;
	int errcode = ENgetlinknodes(ind, &node1, &node2);
    
    // convert and store the values in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxnode1 = int2SEXP(node1);
    SEXP sxnode2 = int2SEXP(node2);
    
    // store the value and error code in the result list
    SEXP resultlist = setlist2int(sxnode1, sxnode2, sxerr);
    
    return resultlist;

}


SEXP enGetLinkValue(SEXP index, SEXP paramCode) {
    
    int ind = SEXP2int(index);
    int code = SEXP2int(paramCode);
    
    // get the node value
    float value;
    int errcode = ENgetlinkvalue(ind, code, &value);
    
    // store the value and error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = float2SEXP(value);
    SEXP resultlist = setlistfloat(sxvalue, sxerr);
    
    return resultlist;
    
}


SEXP enSetLinkValue(SEXP index, SEXP paramcode, SEXP value) {
    
    int ind = SEXP2int(index);
    int code = SEXP2int(paramcode);
    float val = SEXP2float(value);
    int errcode = ENsetlinkvalue(ind, code, val);
    
    // store error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = R_NilValue;
    SEXP resultlist = setlistfloat(sxvalue, sxerr);
    
    return resultlist;

    
}


//=========================
// Functions for patterns
//=========================


SEXP enGetPatternID(SEXP index) {
    
    int ind = SEXP2int(index);
    
    // get the pattern ID
    char cid[100];
    int errcode = ENgetpatternid(ind, cid);

    
    // create a character string vector to hold the desired value
    SEXP envalue;
    PROTECT(envalue = allocVector(STRSXP, 1));
    SET_STRING_ELT(envalue, 0, mkChar(cid));
    // create an integer vector to hold the error code
    SEXP enerror;
    int *perrcode;
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    perrcode[0] = errcode;
    // create a character string vector of the "names" attribute of the objects in out list
    SEXP listnames;
    PROTECT(listnames = allocVector(STRSXP, 2));
    char *names[2] = {"value", "errorcode"};
    for(int i = 0; i < 2; i++)
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    // create a list with 2 vector elements
    SEXP list;
    PROTECT(list = allocVector(VECSXP, 2));
    // attach enerror vector to list
    SET_VECTOR_ELT(list, 1, enerror);
    // attach value vector to list
    SET_VECTOR_ELT(list, 0, envalue);
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);
    
    
    UNPROTECT(4);
    return list;
    
}


SEXP enGetPatternIndex(SEXP id) {

    char *pID;

    PROTECT(id = AS_CHARACTER(id));

    // allocate memory
    pID = R_alloc(strlen(CHAR(STRING_ELT(id, 0))), sizeof(char));

    // copy the argument
    strcpy(pID, CHAR(STRING_ELT(id, 0)));

    // get the pattern index
    int value;
    int errcode = ENgetpatternindex(pID, &value);
    
    // create an integer vector to hold the desired value
    SEXP envalue;
    int *pvalue;
    PROTECT(envalue = NEW_INTEGER(1));
    pvalue = INTEGER_POINTER(envalue);
    pvalue[0] = value;
    // create an integer vector to hold the error code
    SEXP enerror;
    int *perrcode;
    PROTECT(enerror = NEW_INTEGER(1));
    perrcode = INTEGER_POINTER(enerror);
    perrcode[0] = errcode;
    // create a character string vector of the "names" attribute of the objects in out list
    SEXP listnames;
    PROTECT(listnames = allocVector(STRSXP, 2));
    char *names[2] = {"value", "errorcode"};
    for(int i = 0; i < 2; i++)
        SET_STRING_ELT(listnames, i, mkChar(names[i]));
    // create a list with 2 vector elements
    SEXP list;
    PROTECT(list = allocVector(VECSXP, 2));
    // attach enerror vector to list
    SET_VECTOR_ELT(list, 1, enerror);
    // attach value vector to list
    SET_VECTOR_ELT(list, 0, envalue);
    // attach the vector names
    setAttrib(list, R_NamesSymbol, listnames);
    
    
    UNPROTECT(5);
    return list;

}


SEXP enGetPatternLen(SEXP index) {
  
  int ind, val, errcode;
  SEXP resultlist, sxerr, sxvalue;
  
  
  ind = SEXP2int(index);
  //sxind = int2SEXP(ind);
  
  // get the value and error code from EPANET
  errcode = ENgetpatternlen(ind, &val);
  sxerr = int2SEXP(errcode);
  sxvalue = int2SEXP(val);
  
  // store the value and error code in the result list
  resultlist = setlistint(sxvalue, sxerr);
  
  return resultlist;
  
}


SEXP enGetPatternValue(SEXP index, SEXP period) {

    // get the pattern value from EPANET
    int ind = SEXP2int(index);
    int per = SEXP2int(period);
    SEXP resultlist;
    float value;
    int errcode = ENgetpatternvalue(ind, per, &value);
    
    // store the value and error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = float2SEXP(value);
    resultlist = setlistfloat(sxvalue, sxerr);
    
    return resultlist;
    
}


SEXP enSetPattern(SEXP index, SEXP factors, SEXP nfactors) {
    
    // set the pattern and return error code
    int ind = SEXP2int(index);
    int nfac = SEXP2int(nfactors);
    float *pFac;
    float fac[nfac];
    SEXP sxpFac;
    PROTECT(sxpFac = allocVector(REALSXP, 1));
    for (int i = 0; i < nfac; i++) {
        REAL(sxpFac)[0] = REAL(factors)[i];
        fac[i] = SEXP2float(sxpFac);
    }
    UNPROTECT(1);
    
    // store error code in the result list
    pFac = fac;
    int errcode = ENsetpattern(ind, pFac, nfac);
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = R_NilValue;
    SEXP resultlist = setlistfloat(sxvalue, sxerr);
    
    return resultlist;
    
}


SEXP enSetPatternValue(SEXP index, SEXP period, SEXP value) {
    
    // set the pattern value and return error code
    int ind = SEXP2int(index);
    int code = SEXP2int(period);
    float val = SEXP2float(value);
    int errcode = ENsetpatternvalue(ind, code, val);
    
    // store error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = R_NilValue;
    SEXP resultlist = setlistint(sxvalue, sxerr);
    
    return resultlist;
    
}


//==========================
//  Functions for controls
//==========================


SEXP enGetControl(SEXP cindex) {
 
    // get the control values and error code
	int ind = SEXP2int(cindex);
	int ctype, lindex, nindex;
	float setting, level;
	int errcode = ENgetcontrol(ind, &ctype, &lindex, &setting, &nindex, &level);
    
    // store values and error code in result list
    SEXP sxctype = int2SEXP(ctype);
    SEXP sxlindex = int2SEXP(lindex);
    SEXP sxnindex = int2SEXP(nindex);
    SEXP sxsetting = float2SEXP(setting);
    SEXP sxlevel = float2SEXP(level);
    SEXP sxerrorcode = int2SEXP(errcode);
    SEXP resultlist = setcontrollist(sxctype, sxlindex, sxsetting, sxnindex, sxlevel, sxerrorcode);
    
    return resultlist;

}


SEXP enSetControl(SEXP cindex, SEXP ctype, SEXP lindex, SEXP setting, SEXP nindex, SEXP level) {
    
    // set the control values
    int cind = SEXP2int(cindex);
    int ctyp = SEXP2int(ctype);
    int lind = SEXP2int(lindex);
    int nind = SEXP2int(nindex);
    float sett = SEXP2float(setting);
    float lev = SEXP2float(level);
    int errcode = ENsetcontrol(cind, ctyp, lind, sett, nind, lev);

    // store error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = R_NilValue;
    SEXP resultlist = setlistint(sxvalue, sxerr);
    
    return resultlist;
    
}




//SEXP enGetCount(SEXP countcode) {
//
//	SEXP result;
//	int code = SEXP2int(countcode);
//	int count;
//	int errcode = ENgetcount(code, &count);
//	if (errcode > 0) {
//		result = R_NilValue;
//	}
//	else {
//		result = int2SEXP(count);
//	}
//	return result;
//
//}


SEXP enGetFlowUnits() {

	SEXP result;
	int unitscode;
	int errcode = ENgetflowunits(&unitscode);
	if (errcode > 0) {
		result = R_NilValue;
	}
	else {
		result = int2SEXP(unitscode);
	}
	return result;

}

SEXP enGetTimeParam(SEXP paramcode) {

	SEXP result;
	int code = SEXP2int(paramcode);
	long timevalue;
	int errcode = ENgettimeparam(code, &timevalue);
	int timeval = (int)timevalue;
	if (errcode > 0) {
		result = R_NilValue;
	}
	else {
		result = int2SEXP(timeval);
	}
	return result;

}

SEXP enGetQualType() {

	int qualcode, tracenode;
	int errcode = ENgetqualtype(&qualcode, &tracenode);
	SEXP result;
	if (errcode > 0) {
		result = R_NilValue;
	}
	else {
		result = PROTECT(allocVector(INTSXP, 2));
		INTEGER(result)[0] = asInteger(int2SEXP(qualcode));
		INTEGER(result)[1] = asInteger(int2SEXP(tracenode));
		UNPROTECT(1);
	}
	return result;

}


SEXP enGetVersion() {

	SEXP result;
	int version;
	int errcode = ENgetflowunits(&version);
	if (errcode > 0) {
		result = R_NilValue;
	}
	else {
		result = int2SEXP(version);
	}
	return result;

}


SEXP enSetQualType(SEXP qualcode, SEXP chemname, SEXP chemunits, SEXP tracenode) {

	int ind = SEXP2int(qualcode);
	char *chemnm = SEXP2char(chemname);
	char *chemun = SEXP2char(chemunits);
	char *tracen = SEXP2char(tracenode);
	int errcode = ENsetqualtype(ind, chemnm, chemun, tracen);
	SEXP result;
	if (errcode > 0) {
		result = R_NilValue;
	}
	else {
		result = int2SEXP(errcode);
	}
	return result;

}


//============================
//  Functions for hydraulics
//============================


SEXP enOpenH() {

    // run toolkit function and return error code
	int errcode = ENopenH();
    
    // store error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = R_NilValue;
    SEXP resultlist = setlistint(sxvalue, sxerr);
    
    return resultlist;

}


SEXP enInitH(SEXP flag) {

    // run toolkit function and return error code
	int flg = SEXP2int(flag);
	int errcode = ENinitH(flg);
    
    // store error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = R_NilValue;
    SEXP resultlist = setlistint(sxvalue, sxerr);
    
    return resultlist;

}


SEXP enRunH() {

	// run toolkit function and return error code
    long time;
	int errcode = ENrunH(&time);
    
    // store value and error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = int2SEXP((int)time);
    SEXP resultlist = setlistint(sxvalue, sxerr);
    
    return resultlist;

}


SEXP enNextH() {

    // run toolkit function and return error code
	long tst;
	int errcode = ENnextH(&tst);
    
    // store value and error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = int2SEXP((int)tst);
    SEXP resultlist = setlistint(sxvalue, sxerr);
    
    return resultlist;

}


SEXP enCloseH() {

    // run toolkit function and return error code
	int errcode = ENcloseH();
    
    // store value and error code in the result list
    SEXP sxerr = int2SEXP(errcode);
    SEXP sxvalue = R_NilValue;
    SEXP resultlist = setlistint(sxvalue, sxerr);
    
    return resultlist;

}
