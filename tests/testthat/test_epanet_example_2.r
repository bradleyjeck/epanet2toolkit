#*****************************************
#
# (C) Copyright IBM Corp. 2017
#
# Author: Bradley J Eck & Ernesto Arandia
#  
#*****************************************

context("Hydrant Rating Example")

test_that("verify example 2",{
			
		MyNode <- "11"	
		Demand <- seq(from = 2, to = 50, by = 2)
		N <- length(Demand)
		Pressure <- rep(NA, N)
			
		# Open the toolkit and hydraulics solver 
		ENopen("Net2.inp", "Net2.rpt")
		ENopenH()
		
		# Get the node index of interest
		index <- ENgetnodeindex(MyNode)	
		
		# iterate over all demands
		
		for( i in 1:N){
			
			ENsetnodevalue(index, 'EN_BASEDEMAND', Demand[i])
			ENinitH(0)
			ENrunH()
			Pressure[i] <- ENgetnodevalue(index, 'EN_PRESSURE')
		}
		
		# close hydraulics solver and toolkit
		ENcloseH()
		ENclose()
		
		# Visualize the result
		#plot( Pressure ~ Demand, las=1, 
		#	  main = "Example 2 - Hydrant Rating Curve",
		#	  sub  = paste("Net 2, node", MyNode))
		
                # test succeeds if you got here
                expect_true( TRUE )	
})
