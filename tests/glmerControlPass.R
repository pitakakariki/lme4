if (.Platform$OS.type != "windows") {
    ## test redirection from lmer to glmer (correct options passed,
    ##   specifically glmerControl -> tolPwrss

    library("lme4")
    library("testthat")
    ## data("trees513", package = "multcomp")
    load(system.file("testdata","trees513.RData",package="lme4"))


    expect_is(mmod1 <- glmer(damage ~ species - 1 + (1 | lattice / plot),
                             data = trees513B, family = binomial()),"glmerMod")
    if(FALSE) { ## Now (2019-05) defunct; was deprecated since 2013-06:
        expect_warning(mmod2 <- lmer(damage ~ species - 1 + (1 | lattice / plot),
                                     data = trees513B, family = binomial()),
                       "calling lmer with .* is deprecated")
        mmod2@call <- mmod1@call ## hack calls to equality
        expect_equal(mmod1,mmod2)
    }
} ## skip on windows (for speed)
