#!/bin/bash

#start in the NewYork/composite.hgt.color_relief_2f

files="*/"
for f in $files
do 
	echo $f
	cd $f
	files2="*/"
	for f2 in $files2
	do 
		echo $f2
		cd $f2
		newf2=${f2%/}
		#should be where pngs are now. 
		inf="*png"
		for i in $inf
		do 
			echo $i
			newi=${i%.*}
			if [ -a "../../../543/$f$f2$i" ] #543 urban, 432 veg
				then 
					echo "yes"
					echo "making directories"
					echo "in flood_risk_index_intermediates"
					cd ../../../flood_risk_index_intermediates
					mkdir $f
					cd $f
					mkdir $f2
					cd $f2
					mkdir $newi
					echo "in flood_risk_index"
					cd ../../../flood_risk_index
					mkdir $f
					cd $f
					mkdir $f2
					echo "in elevation"
					cd ../../elevation
					mkdir $f
					cd $f
					mkdir $f2
					echo in "veg_HL_red1"
					cd ../../veg_HL_red1
					mkdir $f
					cd $f
					mkdir $f2
					echo in "veg_LL_red2"
					cd ../../veg_LL_red2
					mkdir $f
					cd $f
					mkdir $f2
					echo in "urb_HL_red3"
					cd ../../urb_HL_red3
					mkdir $f
					cd $f
					mkdir $f2
					echo in "urb_LL_red4"
					cd ../../urb_LL_red4
					mkdir $f
					cd $f
					mkdir $f2
					
					
					echo "returning to color topography directory"
					cd ../../composite.hgt.color_relief_2f/$f$f2
					
					echo "begin processing the tiles Muhaha"
					
					#1- isolate the veg, and urb
					#Urban
					convert ../../../543/$f$f2$i -matte \( +clone -fuzz 10% -transparent "#573561" \) -compose DstOut -composite ../../../flood_risk_index_intermediates/$f$f2$newi/urb_iso.png
					
					#Veg
					convert ../../../432/$f$f2$i -matte \( +clone -fuzz 10% -transparent "#652f39" \) -compose DstOut -composite ../../../flood_risk_index_intermediates/$f$f2$newi/veg_iso.png
					
					#2- Obtain an elevation map that matches veg, and urb 
					convert ../../../flood_risk_index_intermediates/$f$f2$newi/urb_iso.png -alpha extract ../../../flood_risk_index_intermediates/$f$f2$newi/urb_alpha.png
					
					convert ../../../flood_risk_index_intermediates/$f$f2$newi/veg_iso.png -alpha extract ../../../flood_risk_index_intermediates/$f$f2$newi/veg_alpha.png
					
					#Convert color topography into grayscale and put into new folder
					
					convert $i -colorspace Gray ../../../elevation/$f$f2$i
					
					convert ../../../elevation/$f$f2$i ../../../flood_risk_index_intermediates/$f$f2$newi/veg_alpha.png -alpha off -compose CopyOpacity -composite ../../../flood_risk_index_intermediates/$f$f2$newi/veg_elv.png
					
					convert ../../../elevation/$f$f2$i ../../../flood_risk_index_intermediates/$f$f2$newi/urb_alpha.png -alpha off -compose CopyOpacity -composite ../../../flood_risk_index_intermediates/$f$f2$newi/urb_elv.png
					
					#3- Divide the two maps 
					composite ../../../flood_risk_index_intermediates/$f$f2$newi/veg_iso.png -compose Divide ../../../flood_risk_index_intermediates/$f$f2$newi/veg_elv.png ../../../flood_risk_index_intermediates/$f$f2$newi/Divide_veg.png
					
					composite ../../../flood_risk_index_intermediates/$f$f2$newi/urb_iso.png -compose Divide ../../../flood_risk_index_intermediates/$f$f2$newi/urb_elv.png ../../../flood_risk_index_intermediates/$f$f2$newi/Divide_urb.png
					
					#4- isolate HL veg and HL urb
					convert ../../../flood_risk_index_intermediates/$f$f2$newi/Divide_veg.png -matte \( +clone -fuzz 25% -transparent "#ff71ab" \) -compose DstOut -composite ../../../flood_risk_index_intermediates/$f$f2$newi/veg_HL.png
					
					##the color below might need to be changed ###
					convert ../../../flood_risk_index_intermediates/$f$f2$newi/Divide_urb.png -matte \( +clone -fuzz 25% -transparent "#ff71ab" \) -compose DstOut -composite ../../../flood_risk_index_intermediates/$f$f2$newi/urb_HL.png
					
					#5- use the HL veg Mask to generate LL veg Mask (the same for urb)
					convert ../../../flood_risk_index_intermediates/$f$f2$newi/veg_HL.png -alpha extract ../../../flood_risk_index_intermediates/$f$f2$newi/veg_HL_alpha.png
					
					convert ../../../flood_risk_index_intermediates/$f$f2$newi/veg_HL_alpha.png -negate ../../../flood_risk_index_intermediates/$f$f2$newi/veg_HL_alpha_n.png
					
					composite ../../../flood_risk_index_intermediates/$f$f2$newi/veg_HL_alpha_n.png -compose Multiply ../../../flood_risk_index_intermediates/$f$f2$newi/veg_alpha.png ../../../flood_risk_index_intermediates/$f$f2$newi/veg_LL_alpha.png
					
					convert ../../../flood_risk_index_intermediates/$f$f2$newi/urb_HL.png -alpha extract ../../../flood_risk_index_intermediates/$f$f2$newi/urb_HL_alpha.png
					
					convert ../../../flood_risk_index_intermediates/$f$f2$newi/urb_HL_alpha.png -negate ../../../flood_risk_index_intermediates/$f$f2$newi/urb_HL_alpha_n.png
					
					composite ../../../flood_risk_index_intermediates/$f$f2$newi/urb_HL_alpha_n.png -compose Multiply ../../../flood_risk_index_intermediates/$f$f2$newi/urb_alpha.png ../../../flood_risk_index_intermediates/$f$f2$newi/urb_LL_alpha.png
					
					#7- color each level with a color corresponding to risk level
					
					convert ../../../flood_risk_index_intermediates/red1.png ../../../flood_risk_index_intermediates/$f$f2$newi/veg_HL_alpha.png -alpha Off -compose Copy_Opacity -composite ../../../flood_risk_index_intermediates/$f$f2$newi/veg_HL_red1.png
					
					convert ../../../flood_risk_index_intermediates/red2.png ../../../flood_risk_index_intermediates/$f$f2$newi/veg_LL_alpha.png -alpha off -compose CopyOpacity -composite ../../../flood_risk_index_intermediates/$f$f2$newi/veg_LL_red2.png
					
					convert ../../../flood_risk_index_intermediates/red3.png ../../../flood_risk_index_intermediates/$f$f2$newi/urb_HL_alpha.png -alpha off -compose CopyOpacity -composite ../../../flood_risk_index_intermediates/$f$f2$newi/urb_HL_red3.png
					
					convert ../../../flood_risk_index_intermediates/red4.png ../../../flood_risk_index_intermediates/$f$f2$newi/urb_LL_alpha.png -alpha off -compose CopyOpacity -composite ../../../flood_risk_index_intermediates/$f$f2$newi/urb_LL_red4.png
					
					#Put a copy of the individual layers in a separate directory
					convert ../../../flood_risk_index_intermediates/red1.png ../../../flood_risk_index_intermediates/$f$f2$newi/veg_HL_alpha.png -alpha Off -compose Copy_Opacity -composite ../../../veg_HL_red1/$f$f2$i
					
					convert ../../../flood_risk_index_intermediates/red2.png ../../../flood_risk_index_intermediates/$f$f2$newi/veg_LL_alpha.png -alpha off -compose CopyOpacity -composite ../../../veg_LL_red2/$f$f2$i
					
					convert ../../../flood_risk_index_intermediates/red3.png ../../../flood_risk_index_intermediates/$f$f2$newi/urb_HL_alpha.png -alpha off -compose CopyOpacity -composite ../../../urb_HL_red3/$f$f2$i
					
					convert ../../../flood_risk_index_intermediates/red4.png ../../../flood_risk_index_intermediates/$f$f2$newi/urb_LL_alpha.png -alpha off -compose CopyOpacity -composite ../../../urb_LL_red4/$f$f2$i
					
					#8- add the layers together to create the color coded risk map
					composite ../../../flood_risk_index_intermediates/$f$f2$newi/veg_HL_red1.png -compose Plus ../../../flood_risk_index_intermediates/$f$f2$newi/veg_LL_red2.png ../../../flood_risk_index_intermediates/$f$f2$newi/veg_LLPlusHL.png
					
					composite ../../../flood_risk_index_intermediates/$f$f2$newi/urb_HL_red3.png -compose Plus ../../../flood_risk_index_intermediates/$f$f2$newi/urb_LL_red4.png ../../../flood_risk_index_intermediates/$f$f2$newi/urb_LLPlusHL.png
					
					#plus not minus
					composite ../../../flood_risk_index_intermediates/$f$f2$newi/veg_LLPlusHL.png -compose plus ../../../flood_risk_index_intermediates/$f$f2$newi/urb_LLPlusHL.png ../../../flood_risk_index/$f$f2$i
			else
				echo "no corresponding urb tile, too bad :P" #don't process this particular tile
			fi
			unset newi
		done
		cd ..
	done
	cd ..
done