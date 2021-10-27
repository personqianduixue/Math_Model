function EvaluateModel(queryfile, modelfile, resultfile)

% read model
% ... (depends on the format used for writing it)

% read query file (feature file)
% ... (depends on the format used for writing it)

% do the processing
% ...


% write results to file
f = fopen(resultfile, 'w');

% write results...

fclose(f)
