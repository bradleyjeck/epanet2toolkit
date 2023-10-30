context("rule based controls")

test_that("rule create and delete",{

    R1 <- "RULE 1 \n IF NODE 2 LEVEL < 100 \n THEN LINK 9 STATUS = OPEN"

    ENopen("Net1.inp", "Net1-rules.rpt")
    ct_before <- ENgetcount("EN_RULECOUNT")

    ENaddrule(R1)
    ct_afteradd <- ENgetcount("EN_RULECOUNT")
    expect_true(ct_afteradd>ct_before)

    rid <- ENgetruleID(1)

    rule1 <- ENgetrule(1)

    prem1 <- ENgetpremise(ruleIndex = 1, premiseIndex = 1)

    # now let's update prem1
    ENsetpremise(ruleIndex = 1, premiseIndex = 1, 
                 logop = 1, # changed this to 1 instead of 2
                 object=6,
                 objIndex=11, variable=3, relop=4, status=0, value=100)
    prem <- ENgetpremise(1,1)
    expect_equal(prem$logop, 1)

    # change object index to 10
    ENsetpremiseindex(1,1,objIndex = 10)
    prem <- ENgetpremise(1,1)
    expect_equal(prem$objIndex, 10)

    # change status to 1
    ENsetpremisestatus(1,1,1)
    prem <- ENgetpremise(1,1)
    expect_equal(prem$status, 1)

    # change value to 99
    ENsetpremisevalue(1,1,99)
    prem <- ENgetpremise(1,1)
    expect_equal(prem$value, 99)

    ENdeleterule(1)
    ct_afterdel <- ENgetcount("EN_RULECOUNT")
    expect_equal(ct_before, ct_afterdel)

    ENclose()

    file.remove(("Net1-rules.rpt"))
})

test_that("rule actions",{
    rptFile <- "Net1-rule-actions.rpt"
    ENopen("Net1.inp", rptFile)
    R3 <-  paste("RULE 3",
                 "IF NODE 23 PRESSURE ABOVE 140",
                 "AND NODE 2 LEVEL > 120",
                 "THEN LINK 113 STATUS = CLOSED",
                 "ELSE LINK 22 STATUS = CLOSED",
                 sep = "\n")
    ENaddrule(R3)
    rule <- ENgetrule(1)

    act <- ENgetthenaction(1,1)

    ENsetthenaction(ruleIndex=1, actionIndex=1,linkIndex = 11, status=1, setting=-1e10)
    act <- ENgetthenaction(1,1)
    expect_equal(act$linkIndex, 11)
    expect_equal(act$status,1)

    act <- ENgetelseaction(1,1)
    lk22idx <- ENgetlinkindex("22")
    expect_equal(act$linkIndex, lk22idx)

    ENsetelseaction(1,1,linkIndex = 6, status = 1, setting = -1e10)
    act <- ENgetelseaction(1,1)
    expect_equal(act$linkIndex, 6)
    expect_equal(act$status, 1)

    ENsetrulepriority(index = 1, priority = 0.5)
    rule <- ENgetrule(1)
    expect_equal(rule$priority, 0.5)

    ENclose()
    file.remove(rptFile)
})