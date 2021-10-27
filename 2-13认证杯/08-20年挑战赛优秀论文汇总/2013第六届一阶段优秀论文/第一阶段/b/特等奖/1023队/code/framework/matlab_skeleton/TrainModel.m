function TrainModel(classlist)

% first get the classes from file
[ classes_names, nb_elem_in_class, classes ] = ReadClassData(classlist);

% do all the processing here...


% write results
modelname = [ classlist, '.model' ];
f = fopen(modelname, 'w');

for i = 1:length(classes_names)
	% write a model
	%......
end

fclose(f);
