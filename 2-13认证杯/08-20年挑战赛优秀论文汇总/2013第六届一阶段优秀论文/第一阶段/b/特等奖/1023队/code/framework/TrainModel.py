#!/usr/bin/python

# script that reads a file containing a list of wav files
# and asks the chosen DescriptorExtractor to do its job

import os
import sys

if len(sys.argv) != 2:
    print 'usage: ', sys.argv[0], ' classdefinitionfile'
    sys.exit(1)

configfile = open('config', 'r')
config = configfile.readline().strip()
audiopath = configfile.readline().strip()
featuresext = configfile.readline().strip()


# convert model into a model with .features files instead

modelname = sys.argv[1]
modelfile = open(modelname, 'r')
newmodelfile = open(modelname + featuresext, 'w')
model = [ s.strip() for s in modelfile.readlines() ]
for l in model:
    ls = l.split()
    newmodelfile.write(ls[0])
    for f in ls[1:]:
        newmodelfile.write(' ' + os.path.join(audiopath, f) + featuresext)
    newmodelfile.write('\n')
    
modelfile.close()
newmodelfile.close()

# specific processing

os.chdir('bin')
newmodelname = os.path.join('..', modelname) + featuresext

if config != 'matlab':
    trainer = ''
    if config == 'shell':
        trainer = './TrainModel.sh'

    elif config == 'python':
        trainer = './TrainModel.py'

    os.system(trainer + ' ' + newmodelname)

else: # config == matlab
    cmd = 'echo "TrainModel(\'' + newmodelname + '\')" | matlab -nosplash -nodesktop'
    os.system(cmd)
    
