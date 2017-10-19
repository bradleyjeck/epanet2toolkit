# epanet2toolkit
epanet2toolkit is an R package for simulating water networks using Epanet. The
package provides functions from the Epanet programmer's toolkit as R functions so
that basic or customized simulations can be carried out from R.  The package
uses [Epanet version 2.1 from Open Water Analytics](https://github.com/OpenWaterAnalytics/EPANET/releases/tag/v2.1).  


## Installation
Install the latest release from CRAN
```
install.packages("epanet2toolkit")
```
Or, install the development version from github.com
```
devtools::install_github("bradleyjeck\epanet2toolkit")
```

## Getting Started
After installation, the package needs to be loaded for use.
```
library(epanet2toolkit)
```
A brief introduction is available in the package help and each function has its
own help page.  Functions provided by the package map directly to functions in
Epanet's API and integrate with the R system for handling exceptions. Thus the
function ENgetnodeindex( nodeID ) provides the index corresponding to a node
ID, or raises an error if such a node ID does not exist. 

```
?epanet2toolkit
?ENgetnodeindex
```

### Running a Full Simulation
The function ENepanet() runs a full simulation and writes the results to a file.
A file of simulation results can be analyzed using the package [epanetReader](https://github.com/bradleyjeck/epanetReader). 
```
ENepanet("Net1.inp", "Net1.rpt")
```

### Querying Network Properties
Characteristics of a network can be examined using package functions.
Note that Epanet needs to be opened for use and should be closed when the analysis finishes. 
```
ENopen("Net1.inp", "Net1.rpt")
ENgetflowunits()
ENgetqualtype()
ENgetcount("EN_NODECOUNT") 
ENgetcount("EN_LINKCOUNT")
ENgetnodeid(1)
ENgetlinkid(1)
ENclose()
```
### Example Programs 

The US EPA website for Epanet includes example programs for a hydrant rating curve 
and chlorine dosage analysis.  An implementation of those programs using R and epanet2toolkit
are included with the package as tests:
- [Hydrant Rating Example](https://github.com/bradleyjeck/epanet2toolkit/blob/master/tests/testthat/test_epanet_example_2.r)   
- [Chlorine Dosage Example](https://github.com/bradleyjeck/epanet2toolkit/blob/master/tests/testthat/test_epanet_example_3.r)   



## Programming Notes for Package Developers
Epanet provides a collection of functions known as the programmer's toolkit or
API for building customized simulations.  epanet2toolkit makes these functions
callable from R. 

Functions in the Epanet API return an integer error code and provide requested
values by reference. 
```
int ENgetnodeindex(char *nodeID, int *nodeindex); 
``` 
A C toolkit function such as ENgetnodeindex takes two arguments: the node
ID, and a pointer to an integer variable where the requested nodeindex is
stored. The function returns an integer error code.  Using the C function
requires allocating an integer for storing the requested node index and passing
a pointer to the storage location to the function. Checking
the returned error code is optional, but is good practice. 

epanet2toolkit integrates Epanet into R by providing two layers of
wrapping.  First, the existing functions of Epanet's C API are wrapped by new C
functions with return type 'void' or 'SEXP' so that they can be called from R.
Second, new R functions are provided to call these new C functions. The R
functions provide some argument checking and also check the error codes returned
by Epanet. 

