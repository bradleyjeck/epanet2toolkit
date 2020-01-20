/*****************************************
*
* (C) Copyright IBM Corp. 2019
* Author: Bradley J Eck
*
* Define symbols that are declared vars.h
******************************************/

#define  EXTERN extern 
#include "types.h"
#include "vars.h"

FILE	*InFile,               
         *OutFile,             
         *RptFile,             
         *HydFile,             
         *TmpOutFile;          
long     HydOffset,    
         OutOffset1,   
         OutOffset2;   
char     Msg[MAXMSG+1],
         LongMsg[(MAXMSG+1)*2 ],         /* Text of output message       */
         InpFname[MAXFNAME+1],  /* Input file name              */
         Rpt1Fname[MAXFNAME+1], /* Primary report file name     */
         Rpt2Fname[MAXFNAME+1], /* Secondary report file name   */
         HydFname[MAXFNAME+1],  /* Hydraulics file name         */
         OutFname[MAXFNAME+1],  /* Binary output file name      */
         MapFname[MAXFNAME+1],  /* Map file name                */
         TmpFname[MAXFNAME+1],  /* Temporary file name          */      //(2.00.12 - LR)
         TmpDir[MAXFNAME+1],    /* Temporary directory name     */      //(2.00.12 - LR)
         Title[MAXTITLE][MAXMSG+1], /* Problem title            */
         ChemName[MAXID+1],     /* Name of chemical             */
         ChemUnits[MAXID+1],    /* Units of chemical            */
         DefPatID[MAXID+1],     /* Default demand pattern ID    */
         Atime[13],             /* Clock time (hrs:min:sec)     */
         Outflag,               /* Output file flag             */      //(2.00.12 - LR)
         Hydflag,               /* Hydraulics flag              */
         Qualflag,              /* Water quality flag           */
         Reactflag,             /* Reaction indicator           */      //(2.00.12 - LR)
         Unitsflag,             /* Unit system flag             */
         Flowflag,              /* Flow units flag              */
         Pressflag,             /* Pressure units flag          */
         Formflag,              /* Hydraulic formula flag       */
         Rptflag,               /* Report flag                  */
         Summaryflag,           /* Report summary flag          */
         Messageflag,           /* Error/warning message flag   */
         Statflag,              /* Status report flag           */
         Energyflag,            /* Energy report flag           */
         Nodeflag,              /* Node report flag             */
         Linkflag,              /* Link report flag             */
         Tstatflag,             /* Time statistics flag         */
         Warnflag,              /* Warning flag                 */
         Openflag,              /* Input processed flag         */
         OpenHflag,             /* Hydraul. system opened flag  */
         SaveHflag,             /* Hydraul. results saved flag  */
         OpenQflag,             /* Quality system opened flag   */
         SaveQflag,             /* Quality results saved flag   */
         Saveflag,              /* General purpose save flag    */
         Coordflag;             /* Load coordinates flag        */
int      MaxNodes,              /* Node count from input file   */
         MaxLinks,              /* Link count from input file   */
         MaxJuncs,              /* Junction count               */
         MaxPipes,              /* Pipe count                   */
         MaxTanks,              /* Tank count                   */
         MaxPumps,              /* Pump count                   */
         MaxValves,             /* Valve count                  */
         MaxControls,           /* Control count                */
         MaxRules,              /* Rule count                   */
         MaxPats,               /* Pattern count                */
         MaxCurves,             /* Curve count                  */
         Nnodes,                /* Number of network nodes      */
         Ntanks,                /* Number of tanks              */
         Njuncs,                /* Number of junction nodes     */
         Nlinks,                /* Number of network links      */
         Npipes,                /* Number of pipes              */
         Npumps,                /* Number of pumps              */
         Nvalves,               /* Number of valves             */
         Ncontrols,             /* Number of simple controls    */
         Nrules,                /* Number of control rules      */
         Npats,                 /* Number of time patterns      */
         Ncurves,               /* Number of data curves        */
         Nperiods,              /* Number of reporting periods  */
         Ncoeffs,               /* Number of non-0 matrix coeffs*/
         DefPat,                /* Default demand pattern       */
         Epat,                  /* Energy cost time pattern     */
         MaxIter,               /* Max. hydraulic trials        */
         ExtraIter,             /* Extra hydraulic trials       */
         TraceNode,             /* Source node for flow tracing */
         PageSize,              /* Lines/page in output report  */
         CheckFreq,             /* Hydraulics solver parameter  */
         MaxCheck;              /* Hydraulics solver parameter  */
double   Ucf[MAXVAR],           /* Unit conversion factors      */
         Ctol,                  /* Water quality tolerance      */
         Htol,                  /* Hydraulic head tolerance     */
         Qtol,                  /* Flow rate tolerance          */
         RQtol,                 /* Flow resistance tolerance    */
         Hexp,                  /* Exponent in headloss formula */
         Qexp,                  /* Exponent in orifice formula  */
         Dmult,                 /* Demand multiplier            */
         Hacc,                  /* Hydraulics solution accuracy */
         DampLimit,             /* Solution damping threshold   */      //(2.00.12 - LR)
         BulkOrder,             /* Bulk flow reaction order     */
         WallOrder,             /* Pipe wall reaction order     */
         TankOrder,             /* Tank reaction order          */
         Kbulk,                 /* Global bulk reaction coeff.  */
         Kwall,                 /* Global wall reaction coeff.  */
         Climit,                /* Limiting potential quality   */
         Rfactor,               /* Roughness-reaction factor    */
         Diffus,                /* Diffusivity (sq ft/sec)      */
         Viscos,                /* Kin. viscosity (sq ft/sec)   */
         SpGrav,                /* Specific gravity             */
         Ecost,                 /* Base energy cost per kwh     */
         Dcost,                 /* Energy demand charge/kw/day  */
         Epump,                 /* Global pump efficiency       */
         Emax,                  /* Peak energy usage            */
         Dsystem,               /* Total system demand          */
         Wbulk,                 /* Avg. bulk reaction rate      */
         Wwall,                 /* Avg. wall reaction rate      */
         Wtank,                 /* Avg. tank reaction rate      */
         Wsource;               /* Avg. mass inflow             */
long     Tstart,                /* Starting time of day (sec)   */
         Hstep,                 /* Nominal hyd. time step (sec) */
         Qstep,                 /* Quality time step (sec)      */
         Pstep,                 /* Time pattern time step (sec) */
         Pstart,                /* Starting pattern time (sec)  */
         Rstep,                 /* Reporting time step (sec)    */
         Rstart,                /* Time when reporting starts   */
         Rtime,                 /* Next reporting time          */
         Htime,                 /* Current hyd. time (sec)      */
         Qtime,                 /* Current quality time (sec)   */
         Hydstep,               /* Actual hydraulic time step   */
         Rulestep,              /* Rule evaluation time step    */
         Dur;                   /* Duration of simulation (sec) */
SField   Field[MAXVAR];         /* Output reporting fields      */


char     *LinkStatus,           /* Link status                  */
         *OldStat;              /* Previous link/tank status    */
double   *NodeDemand,           /* Node actual demand           */
         *NodeQual,             /* Node actual quality          */
         *E,                    /* Emitter flows                */
         *LinkSetting,          /* Link settings                */
         *Q,                    /* Link flows                   */
         *PipeRateCoeff,        /* Pipe reaction rate           */
         *X,                    /* General purpose array        */
         *TempQual;             /* General purpose array for water quality        */
double   *NodeHead;             /* Node heads                   */
double *QTankVolumes;
double *QLinkFlow;
//STmplist *Patlist;              /* Temporary time pattern list  */ 
//STmplist *Curvelist;            /* Temporary list of curves     */
Spattern *Pattern;              /* Time patterns                */
Scurve   *Curve;                /* Curve data                   */
//Scoord   *Coord;                /* Coordinate data              */
Snode    *Node;                 /* Node data                    */
Slink    *Link;                 /* Link data                    */
Stank    *Tank;                 /* Tank data                    */
Spump    *Pump;                 /* Pump data                    */
Svalve   *Valve;                /* Valve data                   */
Scontrol *Control;              /* Control data                 */
//ENHashTable  *NodeHashTable, *LinkHashTable;            /* Hash tables for ID labels    */
Padjlist *Adjlist;              /* Node adjacency lists         */
double _relativeError;
int _iterations; /* Info about hydraulic solution */


double   *Aii,        /* Diagonal coeffs. of A               */
         *Aij,        /* Non-zero, off-diagonal coeffs. of A */
         *F;          /* Right hand side coeffs.             */
double   *P,          /* Inverse headloss derivatives        */
         *Y;          /* Flow correction factors             */
int      *Order,      /* Node-to-row of A                    */
         *Row,        /* Row-to-node of A                    */
         *Ndx;        /* Index of link's coeff. in Aij       */
int      *XLNZ,       /* Start position of each column in NZSUB  */
         *NZSUB,      /* Row index of each coeff. in each column */
         *LNZ;        /* Position of each coeff. in Aij array    */

