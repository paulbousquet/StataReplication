clear
set obs 1000
foreach var in u z1 z2 v w {
	generate `var'=rnormal()
}
generate x = -0.6*z1 - 0.40*z2 + 0.33*u + v
generate y1 = 3.0*x + 0.10*z1 + 0.20*z2 + u
plausexog uci y1 (x = z1 z2), gmin(0 0) gmax(0.2 0.4)
plausexog ltz y1 (x = z1 z2), mu(0.1 0.2) omega(0.01 0.02)
imperfectiv y1 (x=z1 z2), noassumption4
imperfectiv y1 (x=z1 z2)