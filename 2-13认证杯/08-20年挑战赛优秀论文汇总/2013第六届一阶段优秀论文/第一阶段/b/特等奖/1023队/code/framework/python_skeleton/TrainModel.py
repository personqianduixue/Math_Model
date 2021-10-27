#!/usr/bin/python

import ClassData
import sys

if len(sys.argv) != 3:
    print 'usage: ', sys.argv(0), ' classfile type'
    print 'where classfile is the path to the file containing the classes definitions'
    print 'and type is the type of contest (one of \'artist\', \'genre\' or \'similarity\')'
    sys.exit(1)

# get arguments from commandline
classfile = sys.argv(1)
contesttype = sys.argv(2)

# first get the classes from file
classes = read_class_data(classlist)

# train the model here...






# write the results
modelfile = classfile + '.model.' + contesttype
out = open(modelfile, 'w')
for i in range(len(classes)):
    # write a model here...
