context('ENgettitle')

test_that("func exists",{
  expect_true( is.loaded("RENgettitle"))
})

test_that("func works",{

    ENopen("Net1.inp", "Net1.rpt")
    title <- ENgettitle()
    expect_equal(length(title), 3)
    expect_true( grepl("EPANET", title[1]))
    expect_true( grepl("chlorine", title[2]))
    expect_true( grepl("wall", title[3]))
    ENclose()
})