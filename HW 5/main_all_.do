sysuse lalonde1986, clear
local outcome "re78"
local treatment "treat"
local controls "married age black hispanic education re74 re75 re74pos re75pos"
teffects ipw (`outcome') (`treatment' `controls') if sample1
teffects ipw (`outcome') (`treatment' `controls') if sample3
tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample1, ate
tesensitivity cpiplot, name(g1)
tesensitivity cscale
tesensitivity cscale education, density
tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample1, ate cref
tesensitivity cpiplot, creflines name(g2)
qui tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample1, ate
estimates store ate1
estimates replay ate1
tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample3, ate
estimates store ate3
tesensitivity cpitable ate1 ate3
tesensitivity cpiplot ate1 ate3
qui tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample1, atet
qui estimates store atet1
qui tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample3, atet
qui estimates store atet3
tesensitivity cpiplot atet1 atet3
qui tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample1, qte
qui estimates store qte1_50
tesensitivity cpitable ate1 qte1_50
tesensitivity cpiplot ate1 qte1_50
matrix cov = (1)
matrix colnames cov = married
qui tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample1, cate median cov(cov)
qui estimates store cate1_50
matrix cov[1,1] = 0
matrix qcov = (.9)
matrix colnames qcov = re74
qui tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample1, cate median qcov(qcov) cov(cov)
qui estimates store cate1_90
tesensitivity cpiplot cate1_50 cate1_90
qui estimates store cate1_90
tesensitivity cpiplot cate1_50 cate1_90
estimates restore cate1_50
matrix list e(covsupp)
estimates restore cate1_90
matrix list e(covsupp)
matrix cov = (1)
matrix colnames cov = married
qui tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample1, cqte median cov(cov)
qui estimates store cqte1_50
matrix cov[1,1] = 0
matrix qcov = (.9)
matrix colnames qcov = re74
qui tesensitivity cpi (`outcome' `controls') (`treatment' `controls') if sample1, cqte median qcov(qcov) cov(cov)
qui estimates store cqte1_90
tesensitivity cpiplot cqte1_50 cqte1_90
gen re78pos = re78 > 0
tesensitivity cpi (re78pos `controls') (`treatment' `controls') if sample1, ate
tesensitivity cpi (re78pos `controls') (`treatment' `controls') if sample1, ate verbose
qui tesensitivity cpiplot cqte1_50 cqte1_90, xtitle(c-dependence) ytitle(conditional quantile treatment effect) graphregion(color(%8) margin(vsmall)) title(CQTE at 90th and 50th percentiles of income)
qui tesensitivity cpiplot cqte1_50 cqte1_90, xtitle(c-dependence) ytitle(conditional quantile treatment effect) graphregion(color(%8) margin(vsmall)) title(CQTE at 20th and 50th percentiles of income) boundcolors(navy ltblue) boundpatterns(solid) boundoptions(lwidth(vthick)) breakdownoptions(lcolor(orange))
qui tesensitivity cpiplot cqte1_50 cqte1_90, xtitle(c-dependence) ytitle(conditional quantile treatment effect) graphregion(color(%8) margin(vsmall)) title(CQTE at 20th and 50th percentiles of income) boundcolors(navy ltblue) boundpatterns(solid) boundoptions(lwidth(vthick)) breakdownoptions(lcolor(orange)) nolegend
qui tesensitivity cpiplot cqte1_50 cqte1_90, xtitle(c-dependence) ytitle(conditional quantile treatment effect) graphregion(color(%8) margin(vsmall)) title(CQTE at 20th and 50th percentiles of income) boundcolors(navy ltblue) boundpatterns(solid) boundoptions(lwidth(vthick)) breakdownoptions(lcolor(orange)) legoptions(region(fcolor(%8)))


