clear
set obs 1000
set seed 1716
foreach var in u z v w {
	generate `var' = rnormal() 
	}
generate x = -0.6*z + 0.33*u + v
generate y1 = 3.0*x + 0.10*z + u
plausexog uci y1 (x=z), gmin(0) gmax(0.2)
plausexog ltz y1 (x=z), mu(0.1) omega(0.01)
imperfectiv y1 (x=z), noassumption4
generate x1 = 0.33*u + 0.6*z + v
generate Beta = 3
generate y3 = Beta*x + 0.3*z + u
quietly plausexog ltz y3 (x1=z), omega(0.01) mu(0.3) graph(x1) graphomega(0 0.0225 0.09 0.2025 0.36 0.5625) graphmu(0 0.15 0.3 0.45 0.6 0.75) graphdelta(0 0.15 0.3 0.45 0.6 0.75) scheme(sj) ytitle(Estimated {&beta}) xtitle({&delta}) xlabel(0 "0" 0.2 "0.20" 0.4 "0.40" 0.6 "0.60" 0.8 "0.80") legend(order(1 "Point Estimate (LTZ)" 2 "CI (LTZ)")) ylabel(0(1)5)
///quietly plausexog ltz y3 (x=z), distribution(uniform, 0,.6) graph(x) graphomega(0 0.0225 0.09 0.2025 0.36 0.5625) graphmu(0 0.15 0.3 0.45 0.6 0.75) graphdelta(0 0.15 0.3 0.45 0.6 0.75) scheme(sj) ytitle(Estimated {&beta}) xtitle({&delta}) xlabel(0 "0" 0.2 "0.20" 0.4 "0.40" 0.6 "0.60" 0.8 "0.80") legend(order(1 "Point Estimate (LTZ)" 2 "CI (LTZ)")) ylabel(0(1)5)