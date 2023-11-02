
context("pumps")


test_that("Net 1 pump type",{

    suffix <- paste0( sample(letters, 4), collapse="")
    rptFile <- paste0("pump-tests-", suffix,".rpt")

    ENopen("Net1.inp", rptFile)

    pidx <- ENgetlinkindex("9")

    type <- ENgetpumptype(pidx)
    expect_true(is.character(type))

    ENclose()

    file.remove(rptFile)
})

test_that("Net 3 pump type",{

    suffix <- paste0( sample(letters, 4), collapse="")
    rptFile <- paste0("pump-tests-", suffix,".rpt")
    ENopen("Net3.inp", rptFile)

    pidx <- ENgetlinkindex("10")
    type <- ENgetpumptype(pidx)
    expect_true(is.character(type))

    pidx <- ENgetlinkindex("335")
    type <- ENgetpumptype(pidx)
    expect_true(is.character(type))

    ENclose()

    file.remove(rptFile)
})

test_that("net 1 get head curve index",{

    suffix <- paste0( sample(letters, 4), collapse="")
    rptFile <- paste0("pump-tests-", suffix,".rpt")
    ENopen("Net1.inp", rptFile)

    hcidx <- ENgetheadcurveindex(13)

    expect_equal(hcidx, 1)

    ENclose()
    file.remove(rptFile)

})


test_that("net 3 set head curve index",{

    suffix <- paste0( sample(letters, 4), collapse="")
    rptFile <- paste0("pump-tests-", suffix,".rpt")
    ENopen("Net3.inp", rptFile)

    p335idx <- ENgetlinkindex("335") 
    p335_old_hcidx <- ENgetheadcurveindex(p335idx)
    expect_equal(p335_old_hcidx, 2) 

    ENsetheadcurveindex(p335idx, 1)
    p335_new_hcidx <- ENgetheadcurveindex(p335idx)
    expect_equal(p335_new_hcidx, 1)


    ENclose()
    file.remove(rptFile)

})