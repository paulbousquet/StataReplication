program enumerate_permutations
syntax, resampvar(varname) stratavar(varname) obsid(varname) run(integer) *
local index=`run'-1 //which assignment is picked
sort `stratavar' `obsid', stable
mata: st_strscalar("assignment",(inbase(2,`index')))
local av = string(real(assignment),"%0`: di _N/2'.0f")
/* av is now a string of 0s and 1s where a 1 [0] at position X indicates
that the Xth strata has the first [second] observation treated */
levelsof `stratavar', local(strata)
local counter = 0
foreach statum of local strata {
	by `stratavar': replace `resampvar'=real(substr("`av'",`++counter',1)) ///
		if `stratavar'==`statum' & _n==1
	by `stratavar': replace `resampvar'=1-real(substr("`av'",`counter',1)) ///
		if `stratavar'==`statum' & _n==2
}
end
