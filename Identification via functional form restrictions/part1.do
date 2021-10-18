infile using millimettchernissbpdictionary.dct, clear
global XVARS gender age white black hispanic city suburb neast mwest south wicearly wicearlymiss momafb momafbmiss momft mompt momnw momeda momedb momedc momedd momede ses sesmiss bweight bweightmiss hfoodb hfoodbmiss books booksmiss momafb2 ses2 bweight2 books2 age2 z1-z22
global HVARS ses age south city
bmte clbmi $XVARS if grade==3, g(break1) t(5 25) ee psv($XVARS) bs reps(250) kv($HVARS)