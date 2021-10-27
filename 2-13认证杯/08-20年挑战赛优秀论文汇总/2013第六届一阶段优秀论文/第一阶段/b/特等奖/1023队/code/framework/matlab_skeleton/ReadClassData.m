function [classes_names, nb_elem_in_class, classes] = ReadClassData(classlist)

classes_names = {};
nb_elem_in_class = [];
classes = {};
nb_classes = 0;

f = fopen(classlist, 'r');

done = 0;
while done == 0
	l = fgetl(f);
	if l ~= -1
		nb_classes = nb_classes + 1;
		nb_elems = 0;
		classes_names(nb_classes) = { sscanf(l, '%s', 1) };
		oldindex = length(classes_names{nb_classes}) + 1;
		while oldindex < length(l)
			[A, count, errmsg, nextindex] = sscanf(l(oldindex:length(l)), '%s', 1);
			nb_elems = nb_elems + 1;
			classes(nb_classes, nb_elems) = { A };
			oldindex = oldindex + nextindex;
		end
		nb_elem_in_class(nb_classes) = nb_elems;
	else
		done = 1;
	end
end

fclose(f);