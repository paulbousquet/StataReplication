clear
use http://www.stata-press.com/data/r13/systolic2
twoway (scatter systolic weight if xy1==1, mcolor(red)) (scatter systolic weight if xy1==0, mcolor(blue)), legend(label(1 "Treated") label(2 "Untreated"))
teffects ipw (systolic) (xy1 weight), pstolerance(1e-8)
teffects overlap