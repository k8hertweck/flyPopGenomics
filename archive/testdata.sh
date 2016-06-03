# Grab 50 random lines from a named data file
# Spaces are field delimiters
# 1. print random number at the front of each line
# 2. sort by random number
# 3. grab first 50 lines
# 4. remove random number
# 5. print to out

awk '{print rand(),$0}' $1 | sort -k1,1 | head -50 | cut -d' ' -f2- > $1.test.out
