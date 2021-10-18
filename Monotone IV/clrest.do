
sjlog using clrbound1, replace
use nlsy.dta, clear
egen vl_afqt = fill("-2 -1.98") 
replace vl_afqt = . if vl_afqt > 0 
egen vu_afqt = fill("0 0.02") 
replace vu_afqt = . if vu_afqt > 2
sjlog close, replace
sjlog using clrbound2, replace
generate yl = (lnwage > log(16)) * (eduyr <= 13)
generate yu = (lnwage > log(16)) * (eduyr >= 13) + (eduyr < 13) 
sjlog close, replace
sjlog using clrbound3, replace
clr2bound ((yl afqt vl_afqt)) ((yu afqt vu_afqt)), notest
clr2bound ((yl afqt vl_afqt)) ((yu afqt vu_afqt)), notest met("local")   
clr2bound ((yl afqt vl_afqt)) ((yu afqt vu_afqt)), notest met("series")
sjlog close, replace
sjlog using clrbound4, replace
clrbound (yl afqt vl_afqt), lower  
sjlog close, replace
sjlog using clrbound5, replace
generate yl_test = yl - 0.59
generate yu_test = 0.59 - yu
clrtest (yl_test afqt vl_afqt) (yu_test afqt vu_afqt), level(0.95) 
sjlog close, replace 
sjlog using clrbound6, replace
clr3bound ((yl afqt vl_afqt)) ((yu afqt vu_afqt))
sjlog close, replace

      
