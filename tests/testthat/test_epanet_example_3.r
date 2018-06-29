#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************

context("Epanet Example 3")

test_that("ex3",{

  # determine lowest dose of chlorine applied at entrace to
  # a distribution system needed to ensure a minimum residual
  # throughought the system.
  # Inputs: SourceID & Ctarget
  # only check target after startup duration of 432000 seconds

  # inputs 
  SourceID = "Lake" # chlorine source 
  Ctarget  = 0.3    # target min concentration

  #open toolkit and obtain hydraulic solution
  ENopen("Net3.inp", "Net3.rpt")
  ENsolveH()

  # get the nunber of nodes and the source node's index
  nnodes <- ENgetcount("EN_NODECOUNT")
  sourceindex <- ENgetnodeindex(SourceID)

  # Setup system to analyze for chlorine
  # (in case it was not done in the input file)
  ENsetqualtype("EN_CHEM", "Chlorine", "mg/L", "")
  
  # Open water quality solver 
  ENopenQ()

  # Begin search for the source concentration
  csource = seq( from = 0, to = 4, by = 0.1) 
  N = length(csource)
  for( i in 1:N){
     # update source concentration
     ENsetnodevalue( sourceindex, "EN_SOURCEQUAL", csource[i])

     # Run WQ simulation & check for target violations
     ENinitQ(0)
     t <- ENrunQ()
     if( t > 432000){
       for( i in 1:nnodes){
          conc <- ENgetnodevalue(i, "EN_QUALITY")
          if( conc < Ctarget) break
        }
     }
     tstep <- ENnextQ()
     if( tstep == 0 ) break
   }

   Cdose <- csource[i]
   expect_true( Cdose <= 4 ) 
   expect_true( Cdose > 0 ) 

   ENclose()
})
 

