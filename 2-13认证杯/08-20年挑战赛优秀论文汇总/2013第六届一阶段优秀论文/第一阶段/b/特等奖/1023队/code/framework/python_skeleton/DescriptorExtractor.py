#!/usr/bin/python

import wave
import sys
from numarray import *

if len(sys.argv) != 3:
    print 'usage: ', sys.argv(0), ' filename resultfile'
    print 'where filename is the name of the audio file to analyse'
    sys.exit(1)

# get arguments from command line
filename = sys.argv[1]
resultfile = sys.argv[2]

# read the audio
audio_file = wave.open(filename, 'r')
n = audio_file.getnframes()
audio = array(audio_file.readframes(n), Int16).astype(Float32) / 32768.0

# the processing goes here...






# writing results to file
out = open(resultfile, 'w')

# replace this line with your code...
out.write('12 34 56\n')

# we are done, closing file
out.close()
