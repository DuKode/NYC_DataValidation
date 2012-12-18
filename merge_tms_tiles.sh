#!/bin/bash

#run from the NewYork/flood_risk_index

inf='*png'
string=" "

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
		inf="*png"
		for i in $inf
		do 
			echo "$i"
			string="$i ${string}"
		done
		convert $string -append ../../../data_validation/$f$newf2.png
		
		echo "making directories in data_validation"
		cd ../../../data_validation
		mkdir $f
		cd ../flood_risk_index/$f
		unset string
	done
	cd ..
done

########
echo "STARTING SECOND LOOPINESS"
string2=" "
cd ../data_validation
filess="*/"
for fs in $filess
do 
	newfs=${fs%/}
	echo $fs
	cd $fs
	infs="*png"
	for i2 in $infs
	do 
		echo "$i2"
		string2="${string2} $i2"
	done
	convert $string2 +append $newfs.png
	unset string2
	cd ..
done


