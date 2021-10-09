function x = removequotes( x )
% REMOVEQUOTES This function removes any double quotes from strings in a
% table
%   This function is written to remove
%   unnecessary double quotes from the bank dataset.

% Copyright 2014 The MathWorks, Inc.

varnames = x.Properties.VariableNames;
for i = 1:length(varnames)
    if iscellstr(x.(varnames{i}))
        x.(varnames{i}) = strrep(x.(varnames{i}),'"','');
    end
end
