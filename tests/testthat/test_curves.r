
context("curves")

test_that("Net 3 curve gets",{

    suffix <- paste0( sample(letters, 4), collapse="")
    rptFile <- paste0("curve-tests-", suffix,".rpt")
    ENopen("Net3.inp", rptFile)

    cid <- ENgetcurveid(1)
    idx <- ENgetcurveindex(cid)
    expect_equal(1, idx)

    len <- ENgetcurvelen(idx)
    expect_true(len > 0)

    type <- ENgetcurvetype(idx)
    expect_false(is.null(type))
    expect_equal(type,"EN_PUMP_CURVE")

    val <- ENgetcurvevalue(idx, 3)
    expect_equal(as.integer(val$x), 4000)
    expect_equal(as.integer(val$y), 63)

    ENclose() 
    file.remove(rptFile)
})

test_that("Net 3 curve CRUD",{

    suffix <- paste0( sample(letters, 4), collapse="")
    rptFile <- paste0("curve-tests-", suffix,".rpt")
    ENopen("Net3.inp", rptFile)

    ENaddcurve(suffix)
    idx <- ENgetcurveindex(suffix)
    expect_equal(idx, 3)

    len <- ENgetcurvelen(idx)
    expect_equal(len, 1)

    ENsetcurvevalue(idx, 2, 2, 2)
    val <- ENgetcurvevalue(idx, 2)
    expect_equal(as.integer(val$x), 2)
    expect_equal(as.integer(val$y), 2)

    len <- ENgetcurvelen(idx)
    expect_equal(len, 2)
    

    suff2 <- paste0( sample(letters, 4), collapse="")
    ENsetcurveid(idx,suff2)
    idx2 <- ENgetcurveindex(suff2)
    expect_equal(idx, idx2)


    
    ENdeletecurve(idx)


   
    ENclose() 
    file.remove(rptFile)
})
