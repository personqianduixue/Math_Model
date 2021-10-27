#!/usr/bin/python

# ask which bindings to use

print 'Which bindings do you want to use for the framework?'
print '1) Shell (most probably)'
print '2) MatLab'
print '3) Python'
print
b = raw_input('-> ')

bindings = ''

if b == '1':
    bindings = 'shell'
elif b == '2':
    bindings = 'matlab'
elif b == '3':
    bindings = 'python'
else:
    # error: unknown binding
    print 'error: binding unknown...'
    print 'please reconfigure the framework...'


# where are audio files stored?

print
print 'What is the base path to your audio library?'
print
path = raw_input('-> ')


print
print 'What extension do you want to use for your feature files? (dot included)'
print
featuresext = raw_input('-> ')

print
print 'Number of queries being returned in the similarity contest?'
print
nb_queries = raw_input('-> ')


# write config file
f = open('config', 'w')
f.write(bindings + '\n')
f.write(path + '\n')
f.write(featuresext + '\n')
f.write(nb_queries + '\n')
f.close()
