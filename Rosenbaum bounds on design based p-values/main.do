clear
set obs 719
gen s = 1
gen d = _n<=38
gen out = _n<=5
replace out = 1 if _n>38 & _n<75
save s1.dta, replace
clear
set obs 605
gen s = 2
gen d = _n<=29
gen out = _n<=10
replace out = 1 if _n>29&_n<88
save s2.dta, replace
append using s1.dta
gen myweight = 1
gen mysupport = 1
by s, sort: tabulate out d
mhbounds out, gamma(1 (1) 8) treated(d) weight(myweight) support(mysupport) stratum(s)
use nsw, clear 
drop if treat==0
save nsw.dta, replace
use lalonde, clear
append using nsw
gen employment = .
replace employment = 1 if re78>0 & re78~=.
replace employment = 0 if re78==0
tabulate employment treat
gen age2 = age^2
gen educ2 = education^2
gen re742 = re74^2
gen re752 = re75^2
gen blacku74 = black*re74
psmatch2 treat age age2 education educ2 married black hispanic re74 re75 re742 re752 blacku74, logit out(employment) noreplacement
mhbounds employment, gamma(1 (0.05) 1.5)
