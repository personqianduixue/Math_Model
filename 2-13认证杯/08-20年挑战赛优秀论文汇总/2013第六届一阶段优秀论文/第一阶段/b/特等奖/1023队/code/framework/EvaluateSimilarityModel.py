#!/usr/bin/python

import distances
import glob
import os
import ranking
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
    evaluator = './EvaluateSimilarityModel.sh'

elif config == 'python':
    extractor = './DescriptorExtractor.py'
    evaluator = './EvaluateSimilarityModel.py'

os.chdir('bin')

# compute all queries first (extract descriptors + evaluate model)
print 'Computing queries first...'
total = len(glob.glob1(querydir, '*.query'))
current = 0
for f in glob.glob1(querydir, '*.query'):
    current += 1
    print '\r[' + str(current) + '/' + str(total) + ']',
    sys.stdout.flush()
    queryfilename = os.path.join(querydir, f)
    queryfile = open(queryfilename, 'r')
    wavfilelist = [ os.path.join(audiopath, wavfile) for wavfile in queryfile.readline().strip().split() ]
    queryfile.close()
    
    # compute descriptors and evaluate model
    if config == 'matlab':
        for wavfile in wavfilelist:
            os.system('echo "DescriptorExtractor(\'' + wavfile + '\')" | matlab -nosplash -nodesktop')

        cmd = 'echo "EvaluateSimilarityModel({\''
        for wavfile in wavfilelist:
            cmd += wavfile + featuresext + '\',\''
        cmd[-2:] = '\'},\'' + model + '\',\'' + queryfilename + '\')" | matlab -nosplash -nodesktop'
        # os.system(cmd)
    else:
        for wavfile in wavfilelist:
            os.system(extractor + ' ' + wavfile)

        cmd = evaluator + ' ' + model + ' ' + queryfilename + '.result'
        for wavfile in wavfilelist:
            cmd += ' ' + wavfile + featuresext
        os.system(cmd)
    

print
print 'Computing ranking...'
os.chdir('..')

ranking.compute(sys.argv[2])

