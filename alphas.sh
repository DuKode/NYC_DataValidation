#!/bin/bash

#Merge the alphas of the area of the metropolitan area

str_urb_HL=" "
str_urb_LL=" "
str_veg_HL=" "
str_veg_LL=" "

for f in 601/ 602/ 603/ 604/ 605/
do 
	cd $f
	newf=${f%/}
	for f2 in 1277/ 1278/ 1279/ 1280/
	do
		cd $f2
		newf2=${f2%/}
		str_urb_HL="$newf2/urb_HL_alpha.png ${str_urb_HL}"
		str_urb_LL="$newf2/urb_LL_alpha.png ${str_urb_LL}"
		str_veg_HL="$newf2/veg_HL_alpha.png ${str_veg_HL}"
		str_veg_LL="$newf2/veg_LL_alpha.png ${str_veg_LL}"
		cd ..
	done
	convert $str_urb_HL -append ../urb_HL/$newf.png
	convert $str_urb_LL -append ../urb_LL/$newf.png
	convert $str_veg_HL -append ../veg_HL/$newf.png
	convert $str_veg_LL -append ../veg_LL/$newf.png
	unset str_urb_HL
	unset str_urb_LL
	unset str_veg_HL
	unset str_veg_LL
	cd ..
done

####

#now in flood_risk_index_intermediates
string=" "
for f3 in urb_HL/ urb_LL/ veg_HL/ veg_LL/
do 
	cd $f3
	newf3=${f3%/}
	inf="*.png"
	for i in $inf
	do
		string="$string $i"
	done
	convert $string +append $newf3.tiff
	unset string
	cd ..
done
