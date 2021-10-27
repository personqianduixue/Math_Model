#!/bin/sh

# wrapper script for the model trainer.
# just call your application here, the arguments on
# the command line being forwarded with $1, $2, etc...
# $1 being the name of the file containing the classes.
# the elements inside the classes are the full paths to
# the features files

cat $1 | cut -d\  -f1 > $1.model
