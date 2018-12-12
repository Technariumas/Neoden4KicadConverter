#!/bin/bash

#Delete lines until Ref,Val,Package,PosX,PosY,Rot,Side
#Replace top with T
#delete ""
#Rename Ref to Designator
#Replace 270 in Rot column with -90 --> i.e. transform the coordinates
#Rename Package to Footprint 
#Move Footprint to second column
#Copy  PosX, PosY to 3rd column
#Rename 3,4 columns to Mid X, Mid Y
#Copy PosX, PosY to 5th, 6th column
#Rename 5th, 6th columns to Ref X, Ref Y
#Copy PosX, PosY to 7th, 8th column
#Rename 5th, 6th columns to Pad X, Pad Y
#Rename Side to Layer
#Rename Rot to Rotation
#Move Rotation column to 9th column
#Move Layer to 10th column
#Rename Val to Comment
#Move Comment to 11th column

#Designator 	Footprint 	Mid X 	Mid Y 	Ref X 	Ref Y 	Pad X 	Pad Y 	Layer 	Rotation 	Comment
#C1 	CAP - (5x3) 	53.5 	20.5 	53.5 	20.5 	53.5 	20.5 	Top 	90 	1uF/100V

#Ref,Val,Package,PosX,PosY,Rot,Side
#"D1","LED","LED5730",13.571428,-27.749998,90.000000,top


[ $# -ne 2 ] && { echo "Usage: $0 <input file> <output file>"; exit 999; }

sed '1d;s/top/T/g' $1 | awk ' BEGIN { print "Designator,Footprint,Mid X,Mid Y,Ref X,Ref Y,Pad X,Pad Y,Layer,Rotation,Comment" } {print $0}' | awk ' { FS=","; OFS=","}
 {print $1, $3, $4, $5, $4, $5, $4, $5, $7, ($6>180)? -1*(360-$6) : $6, $2 }' #> $outputFile

# awk -f ./kicad_neoden4.sh Kicad_out.csv | sed '2d;s/top/T/g' > Neoden_IN.csv



