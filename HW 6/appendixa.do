use nevorosen2012, clear
replace addv=addv/10
local w addv bd1 bd2 bd3 bd4 bd5 bd6 bd7 bd8 bd9 bd10 bd11 bd12 bd13 bd14 bd15 bd16 bd17 bd18 bd19 bd20 bd21 bd22 bd23 bd24 dd2 dd3 dd4 dd5 dd6 dd7 dd8 dd9 dd10 dd11 dd12 dd13 dd14 dd15 dd16 dd17 dd18 dd19 dd20 sfdum
generate qavgpo=p_bs
replace qavgpo=p_sf if city==7
imperfectiv y `w' (price=qavgp qavgpo), prop5 noassumption exogvars(`w')
use conleyetal2012, clear 
local xvar i2 i3 i4 i5 i6 i7 age age2 fsize hs smcol col marr twoearn db pira hown
plausexog ltz net_tfa `xvar' (p401 = e401), omega(25000) mu(0) level(.99) vce(robust) graph(p401) graphmu(0 1000 2000 3000 4000 5000) graphomega(0 333333.33 1333333.3 3000000 5333333.3 8333333.3) graphdelta(0 2000 4000 6000 8000 10000) 