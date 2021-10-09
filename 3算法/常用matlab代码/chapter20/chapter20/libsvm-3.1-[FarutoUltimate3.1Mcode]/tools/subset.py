#!/usr/bin/env python
from sys import argv, exit, stdout, stderr
from random import randint

method = 0
global n
global dataset_filename
subset_filename = ""
rest_filename = ""

def exit_with_help():
	print("""\
Usage: {0} [options] dataset number [output1] [output2]

This script selects a subset of the given dataset.

options:
-s method : method of selection (default 0)
     0 -- stratified selection (classification only)
     1 -- random selection

output1 : the subset (optional)
output2 : rest of the data (optional)
If output1 is omitted, the subset will be printed on the screen.""".format(argv[0]))
	exit(1)

def process_options():
	global method, n
	global dataset_filename, subset_filename, rest_filename
	
	argc = len(argv)
	if argc < 3:
		exit_with_help()

	i = 1
	while i < len(argv):
		if argv[i][0] != "-":
			break
		if argv[i] == "-s":
			i = i + 1
			method = int(argv[i])
			if method < 0 or method > 1:
				print("Unknown selection method {0}".format(method))
				exit_with_help()
		i = i + 1

	dataset_filename = argv[i]
	n = int(argv[i+1])
	if i+2 < argc:
		subset_filename = argv[i+2]
	if i+3 < argc:
		rest_filename = argv[i+3]

def main():
	class Label:
		def __init__(self, label, index, selected):
			self.label = label
			self.index = index
			self.selected = selected

	process_options()
	
	# get labels
	i = 0
	labels = []
	f = open(dataset_filename, 'r')
	for line in f:
		labels.append(Label(float((line.split())[0]), i, 0))
		i = i + 1
	f.close()
	l = i
	
	# determine where to output
	if subset_filename != "":
		file1 = open(subset_filename, 'w')
	else:
		file1 = stdout
	split = 0
	if rest_filename != "":
		split = 1	
		file2 = open(rest_filename, 'w')
	
	# select the subset
	warning = 0
	if method == 0: # stratified
		labels.sort(key = lambda x: x.label)
		
		label_end = labels[l-1].label + 1
		labels.append(Label(label_end, l, 0))

		begin = 0
		label = labels[begin].label
		for i in range(l+1):
			new_label = labels[i].label
			if new_label != label:
				nr_class = i - begin
				k = i*n//l - begin*n//l
				# at least one instance per class
				if k == 0:
					k = 1
					warning = warning + 1
				for j in range(nr_class):
					if randint(0, nr_class-j-1) < k:
						labels[begin+j].selected = 1
						k = k - 1
				begin = i
				label = new_label
	elif method == 1: # random
		k = n
		for i in range(l):
			if randint(0,l-i-1) < k:
				labels[i].selected = 1
				k = k - 1
			i = i + 1

	# output
	i = 0
	if method == 0:
		labels.sort(key = lambda x: int(x.index))
	
	f = open(dataset_filename, 'r')
	for line in f:
		if labels[i].selected == 1:
			file1.write(line)
		else:
			if split == 1:
				file2.write(line)
		i = i + 1

	if warning > 0:
		stderr.write("""\
Warning:
1. You may have regression data. Please use -s 1.
2. Classification data unbalanced or too small. We select at least 1 per class.
   The subset thus contains {0} instances.
""".format(n+warning))

	# cleanup
	f.close()
	
	file1.close()
	
	if split == 1:
		file2.close()

main()
