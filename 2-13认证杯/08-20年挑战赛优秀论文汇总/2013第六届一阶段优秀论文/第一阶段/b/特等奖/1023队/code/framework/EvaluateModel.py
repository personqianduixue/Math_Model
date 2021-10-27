#!/usr/bin/python

import glob
import os
import sys

if len(sys.argv) != 3:
    print 'usage: ', sys.argv[0], ' modelfile querydirectory' 
    sys.exit(1)

configfile = open('config', 'r')
config = configfile.readline().strip()
audiopath = configfile.readline().strip()
featuresext = configfile.readline().strip()

model = os.path.join('..', sys.argv[1])
querydir = os.path.join('..', sys.argv[2])

# specific processing

extractor = ''
evaluator = ''

if config == 'shell':
    extractor = './DescriptorExtractor.sh'
    evaluator = './EvaluateModel.sh'

elif config == 'python':
    extractor = './DescriptorExtractor.py'
    evaluator = './EvaluateModel.py'

os.chdir('bin')

# compute all queries first (extract descriptors + evaluate model)
total = len(glob.glob1(querydir, '*.query'))
current = 0
for f in glob.glob1(querydir, '*.query'):
    current += 1
    print '\r[' + str(current) + '/' + str(total) + ']',
    sys.stdout.flush()
    queryfilename = os.path.join(querydir, f)
    queryfile = open(queryfilename, 'r')
    wavfile = os.path.join(audiopath, queryfile.readline().strip())
    queryfile.close()
    
    # compute descriptors && evaluate model
    if config == 'matlab':
        os.system('echo "DescriptorExtractor(\'' + f + '\',\'' + f + featuresext + '\')" | matlab -nosplash -nodesktop')
        os.system('echo "EvaluateModel(\'' + f + featuresext + '\',\'' + model + '\',\'' +
                  queryfilename + '\')" | matlab -nosplash -nodesktop')
    else:
        os.system(extractor + ' ' + wavfile + ' ' + wavfile + featuresext)
        os.system(evaluator + ' ' + model + ' ' + queryfilename + '.result ' + wavfile + featuresext)    


# check how many results are correct
queries, good = 0, 0

for f in glob.glob1(querydir, '*.query'):
    queryfilename = os.path.join(querydir, f)
    queryfile = open(queryfilename, 'r')
    queryfile.readline() # skip song name
    expected = queryfile.readline().strip()
    queryfile.close()
    queries += 1
    try:
        resultfile = open(queryfilename + '.result', 'r')
        result = resultfile.readline().strip()
        if result == expected:
            good += 1
    except:
        pass

print
print good, 'good identifications out of', queries, 'queries'
print 'averaging', good * 100 / queries, '% correct answers'

