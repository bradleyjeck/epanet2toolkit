#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Bradley J Eck
#
#  
#****************************************/

context("ENclose")


test_that("func exists",{
  expect_true( is.loaded("enClose"))
})

test_that("func works",{
    ENopen("Net1.inp","n1.rpt","")
    ENclose() 
    # if you got here it's OK 
    expect_true(TRUE) 
    # clean-up
    file.remove("n1.rpt")
})
test_that("warns not crashes when already closed",{

    expect_warning(ENclose())

}) 

test_that("returns NULL invisibly on Success",{
    ENopen("Net1.inp","n1.rpt","")
    x <- withVisible( ENclose() ) 
    expect_null( x$value)
    expect_false( x$visible)
    # clean-up
    file.remove("n1.rpt")
})

