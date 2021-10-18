/* net install ritest
net get ritest
Download data from AEJ 
*/
clear
use survey_data_AEJ.dta
generate observation_id = _n
foreach i in female age ethn_fon ethn_yoruba speaks_french speaks_fon christian ///
islam primary_schooling secondary_schooling_or_more single monogamous polygamous ///
reg_income has_farm electricity member index index_nocash cash {
summarize `i' if treat==0
areg `i' treat, robust absorb(depcom)
permute treat _b[treat], strata(depcom) reps(1000) seed(0) nodots: ///
regress `i' treat dcom2-dcom12
ritest treat _b[treat], strata(depcom) reps(1000) seed(0) nodots: ///
regress `i' treat dcom2-dcom12
ritest treat _b[treat], samplingprogram(enumerate_permutations) ///
samplingprogramoptions("stratavar(depcom) obsid(observation_id)") ///
r(4096) kdensityplot nodots: regress `i' treat dcom2-dcom12
}
