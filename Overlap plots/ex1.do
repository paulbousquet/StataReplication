use http://www.stata-press.com/data/r13/cattaneo2
teffects ipw (bweight) (mbsmoke mmarried c.mage##c.mage fbaby medu, probit)
teffects ipw (bweight) (mbsmoke mmarried c.mage##c.mage fbaby medu, probit),atet
