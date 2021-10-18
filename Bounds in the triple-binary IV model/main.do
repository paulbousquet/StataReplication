clear
input z x y count
0 0 0 74
0 0 1 11514
1 0 0 34
1 0 1 2385
1 1 0 12
1 1 1 9665
end 
bpbounds y (x = z) [fw=count]
by z, sort: tabulate x y [fw=count], cell
* input frequencies
bpboundsi 74 11514 0 0 34 2385 12 9665
* input conditional probabilities
bpboundsi .0064 .9936 0 0 .0028 .1972 .001 .799
quietly correlate y z [fw=count], covariance
scalar covyz = r(cov_12)
quietly correlate x z [fw=count], covariance
scalar covxz = r(cov_12)
display "ACE:", %5.4f covyz/covxz
tabulate z y [fw=count], row matcell(zy)
tabulate z x [fw=count], row matcell(zx)
bpboundsi, matrices(zy zx) bivariate

mata 
p = .065
controls = (341, 47, 297, 17, 63, 18)
cases = (272, 41, 269, 38, 56, 35)
py0 = controls:*(1 - p)/sum(controls)
py1 = cases:*p/sum(cases)
z0 = sum(py0[1::2]) + sum(py1[1::2])
z1 = sum(py0[3::4]) + sum(py1[3::4])
z2 = sum(py0[5::6]) + sum(py1[5::6])
pyxz0 = ((py0[1::2])/z0 \ py1[1::2]/z0)'
pyxz1 = ((py0[3::4])/z1 \ py1[3::4]/z1)'
pyxz2 = ((py0[5::6])/z2 \ py1[5::6]/z2)'
st_matrix("pyxz0",pyxz0)
st_matrix("pyxz1",pyxz1)
st_matrix("pyxz2",pyxz2)
end
bpboundsi, matrices(pyxz0 pyxz1 pyxz2)
clear
set seed 2232011
set obs 10000
generate z = rbinomial(1,.5)
generate u = rbinomial(1,.5)
generate px = .05 + .1*z + .1*u
generate x = rbinomial(1,px)
generate p1 = .1 + .2*z + .05*x + .1*u
generate y1 = rbinomial(1,p1)
generate p2 = .1 + .05*z + .05*x + .1*u
generate y2 = rbinomial(1,p2)
bpbounds y1 (x = z)
 bpbounds y2 (x = z)