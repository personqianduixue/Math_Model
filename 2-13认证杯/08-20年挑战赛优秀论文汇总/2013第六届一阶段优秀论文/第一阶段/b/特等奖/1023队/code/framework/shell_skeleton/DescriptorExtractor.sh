#!/bin/sh

# wrapper script for a homebrewn application
# just call your application here, the arguments on
# the command line being forwarded with $1, $2, etc...
# here: $1 is the name of the wav file to analyse.
#       $2 is the name of the file in which to write the results.
# Double quotes around $1 $ $2 should not be mandatory, but
# it is safer to put them anyway in the case you have
# filenames with spaces...
#
# ex: /usr/bin/myprog "$1" "$2"
