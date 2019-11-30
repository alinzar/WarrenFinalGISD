clear all //clears existing data
set more off //to auto-continue code
capture log close //produces a log file that captures commands that have been run.

* at the beginning of the line
// in any place in the text
/* Comment out sections */

** Set working directory and establish the log file **
cd "C:\Users\warren.651\Box\Strat"
log using "Cleaning", text replace //saves as txt file, replaces previous log file (USE CAUTION)

** Open Data and Building working Data
use "ColorismRaw.dta", clear
save "ColorismWorking.dta", replace

//examine and clean the data
codebook region
describe region
tab region, m

//region is already cleaned! leave as is

codebook health
describe health
tab health, m

gen healthcl=health
replace healthcl=. if health==8|health==9|health==0
label variable healthcl "Cleaned General Health of R"
label define healthqual 4"Poor" 3"Fair" 2"Good" 1"Excellent"
label values healthcl healthqual

codebook healthcl
describe healthcl
tab healthcl, m

codebook health1
describe health1
tab health1, m

gen health1cl=health1
replace health1cl=. if health1==8|health1==9|health1==0
label variable health1cl "Cleaned SECONDARY General Health of R"
label define health1qual 5"Poor" 4"Fair" 3"Good" 2"Very Good" 1"Excellent"
label values health1cl health1qual

codebook health1cl
describe health1cl
tab health1cl, m

recode health1cl 1=2
label define health1qualcollapsed 5"Poor" 4"Fair" 3"Good" 2"Excellent"
label values health1cl health1qualcollapsed

codebook health1cl
describe health1cl
tab health1cl, m

codebook mntlhlth
describe mntlhlth
tab mntlhlth

gen mentalcl=mntlhlth
replace mentalcl=. if mentalcl==-1|mentalcl==8|mentalcl==9
label variable mentalcl "Cleaned days of poor mental health"

codebook mentalcl
describe mentalcl
tab mentalcl, m

codebook hlthdays
describe hlthdays
tab hlthdays, m

gen healthdayscl=hlthdays
replace healthdayscl=. if hlthdays==-1|hlthdays==8|hlthdays==9
label variable healthdayscl "Cleaned days of activity limitation"

codebook healthdayscl
describe healthdayscl
tab healthdayscl, m

codebook ratetone
describe ratetone
tab ratetone, m

gen ratetonecl=ratetone
replace ratetonecl=. if ratetone==99
label variable ratetonecl "Cleaned Interviewer Assessed Skin Tone of R"

codebook ratetonecl
describe ratetonecl
tab ratetonecl, m

//Restrict the analytic sample to only those who have a response for skin tone

keep if ratetonecl!=.
keep id year id_ region ballot healthcl health1cl mentalcl healthdayscl ratetonecl

save "ColorismCleaned.dta", replace
