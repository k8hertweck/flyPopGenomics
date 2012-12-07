# script to filter out paired population frequency data from tlex .csv file which is comma delimited

#count number of original records
wc -l $1

#remove lines with NA from a given input file
grep -v "\"no_data\"" $1 > $1tempNA
wc -l $1tempNA
#pull out lines with 0, 0
grep -v "0,0" $1tempNA > $1temp0
wc -l $1temp0
#pull out lines with 100, 100 and replace commas with tabs
grep -v "100,100" $1temp0 | awk 'BEGIN {FS=","; OFS=" "} 
{print $0}' > $1.filter
wc -l $1.filter

#remove intermediate files
rm $1tempNA $1temp0

#replace commas with tabs

