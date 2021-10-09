function [model, partition_size] = fit_partitioned_model(...
    inputs, outputs, selectors, sel_sizes, min_size, partition_names, fn_name, varargin)
%function [models, partition_sizes] = fit_partitioned_model(...
%    inputs, outputs, selectors, sel_sizes, min_size, partition_names, fn_name, varargin)
%
% Fit models to different subsets (columns)  of the input/output data, 
% as chosen by the selectors matrix. If there is only output data, set input=[].
% If there is less than min_size data in partition i, 
% we set model{i} = []
%
% Example:
% selectors = [1 2 1 1 1
%              1 2 2 1 2]
% sel_sizes = [2 2] so there are 4 models: (1,1), (2,1), (1,2), (2,2)
% We fit model{1} to data from columns 1,4
% We fit model{2} to no data
% We fit model{3} to data from column 3,5
% We fit model{4} to data from column 2 (assuming min_size <= 1)
%
% For each partition, we call the specified function with the specified arguments
% as follows:
%  model{i}  = fn(input(:,cols{i}), output(:,cols{i}), args)
% (We omit input if [])
% partition_size(i) is the amount of data in the i'th partition.
%
% Example use: row 1 of selectors is whether an object is present/absent
% and row 2 is the location.
%
% Demo:
% inputs = 1:5; outputs = 6:10; selectors = as above
% fn = 'fit_partitioned_model_testfn';
% [model, partition_size] = fit_partitioned_model(inputs, outputs, selectors, [2 2], fn)
% should produce
% model{1}.input = [1 4], model{1}.output = [6 9]
% model{2} = []
% model{3}.input = [3 5], model{3}.output = [8 10], 
% model{4}.input = [2], model{3}.output = [7], 
% partition_size = [2 0 2 1]


sel_ndx = subv2ind(sel_sizes, selectors');
Nmodels = prod(sel_sizes);
model = cell(1, Nmodels);
partition_size = zeros(1, Nmodels);
for m=1:Nmodels
  ndx = find(sel_ndx==m);
  partition_size(m) = length(ndx);
  if ~isempty(partition_names) % & (partition_size(m) < min_size)
    fprintf('partition %s has size %d, min size = %d\n', ...
	    partition_names{m}, partition_size(m), min_size);
  end
  if partition_size(m) >= min_size
    if isempty(inputs)
      model{m} = feval(fn_name, outputs(:, ndx), varargin{:});
    else
      model{m} = feval(fn_name, inputs(:,ndx), outputs(:, ndx), varargin{:});
    end
  end
end
