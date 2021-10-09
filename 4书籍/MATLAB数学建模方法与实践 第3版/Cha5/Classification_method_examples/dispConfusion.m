function cPct = dispConfusion(c, modelname, labels)
% Display Confusion Matrix
%
% cPct = dispConfusion(c, modelname, labels)
%

% Copyright 2014 The MathWorks, Inc.

if nargin < 3, labels = {'No', 'Yes'}; end

cPct = bsxfun(@rdivide, c, sum(c,2))*100;
cStr = cell(size(cPct));
cStr(:) = arrayfun(@(i){sprintf('%5.2f%% (%d)', cPct(i), c(i))}, 1:numel(cPct));

data = [strcat({'Predicted '}, labels); cStr];
separator = repmat('    ',length(labels)+1,1);
report = char([{' '};strcat({'Actual '}, labels)']);
for i = 1:size(data,2)
    report = [report separator char(data(:,i))]; %#ok<AGROW>
end
report = [separator report];

fprintf('Performance of %s:\n', modelname);
disp(report)



% %disp(array2table(c,'VariableNames',strcat({'Predicted_'}, labels), 'RowNames', strcat({'Actual_'}, labels)))
% ds = dataset([{cStr} strcat({'Predicted_'}, labels)], 'ObsNames', strcat({'Actual_'}, labels));
% % names = ds.Properties.VarNames;
% % for i = 1:length(names)
% %     ds.(names{i}) = char(ds.(names{i}));
% % end
% disp(ds)
