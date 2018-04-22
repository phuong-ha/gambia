/* This dofile prepares DM for KINGSMEN KTSP (1400 stores)
	
Author: Le Dang Trung
Email: trungle@rta.v
Last update: December 2, 2017 at 5:19:50 PM GMT+7
*************************************************************************************************/

clear *
set more off
sysdir set PLUS "/Applications/Stata14/ado/plus/"

*************************************************************************************************
*****    CHANGE DIRECTORIES BELOW                                                           *****
*************************************************************************************************
global datafrom "/Users/ledangtrung/Desktop/UIfactories"
global datasave "/Users/ledangtrung/Desktop/UIfactories"
global datatemp "/Volumes/WORK/Temp"

*************************************************************************************************
*****    IMPORT  QUANTITY                                                                   *****
*************************************************************************************************
*import excel using "$datafrom/Indonesia_Company_List.xlsx", sheet("Sheet1") cellrange(A1) firstrow clear
import excel using "$datafrom/Company list.xlsx", sheet("Sheet1") cellrange(A1) firstrow clear
duplicates drop NamaPerusahaan, force
egen province_id = group(Provinsi)
egen city_id = group(Kota)
gen bw_id = Sumberdata=="BWI"
gen factory_id = _n
rename NamaPerusahaan factory_lb 
rename Sumberdata bw_lb 
rename Kelas size_group 
rename Kota city_lb 
rename Provinsi province_lb

replace bw_lb = "nonBWI" if bw_lb!="BWI"
drop F
save "$datasave/UIfactories.dta", replace

export excel * using "$datasave/UIfactories.xlsx", sheet("UIfactory") sheetreplace firstrow(var)