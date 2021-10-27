#!/usr/bin/python

# script that reads a file containing a list of wav files
# and asks the chosen DescriptorExtractor to do its job

import os
import sys

if len(sys.argv) != 2:
    print 'usage: ', sys.argv[0], ' classfile'
    sys.exit(1)

configfile = open('config', 'r')
config = configfile.readline().strip()
audiopath = configfile.readline().strip()
featuresext = configfile.readline().strip()

# construct wavlist first
wavlistfile = open(sys.argv[1], 'r')
wavlisttmp = [ s.strip() for s in wavlistfile.readlines() ]
wavlist = []
for f in wavlisttmp:
    l = f.split()
    for i in l[1:]:
        wavlist.append(os.path.join(audiopath, i))


#######################
# specific processing #
#######################

os.chdir('bin')

cmd = ''

if config != 'matlab':
    if config == 'shell':
        extractor = './DescriptorExtractor.sh'
    
    elif config == 'python':
        extractor = './DescriptorExtractor.py'

    else:
        print 'Invalid config. Please rerun configure.py'
        sys.exit(1)

    # do it!!
    for f in wavlist:
        cmd = extractor + ' "' + f + '" "' + f + featuresext + '"'
        print 'Computing descriptors for file', f
        os.system(cmd)
        
else: # config = 'matlab'
    for f in wavlist:
        cmd = 'echo "DescriptorExtractor(\'' + f + '\',\'' + f + featuresext + '\')" | matlab -nosplash -nodesktop'
        os.system(cmd)

