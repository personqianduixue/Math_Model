function [mu, N, pick] = parzen_fit_select_unif(data, labels, max_proto, varargin)
% PARZEN_FIT_SELECT_UNIF Fit a parzen density estimator by selecting prototypes uniformly from data
% [mu, N, pick] = parzen_fit_select_unif(data, max_proto, labels, ...)
%
% We partition the data into different subsets based on the labels.
% We then choose up to max_proto columns from each subset, chosen uniformly.
%
% INPUTS
% data(:,t)
% labels(t) - should be in {1,2,..,Q}
% max_proto - max number of prototypes per partition
%
% Optional args
% partition_names{m} - for debugging
% boundary - do not choose prototypes which are within 'boundary' of the label transition
%
% OUTPUTS
% mu(:, m, q) for label q, prototype m for 1 <= m <= N(q)
% N(q) = number of prototypes for label q
% pick{q} = identity of the prototypes

nclasses = max(labels);
[boundary, partition_names] = process_options(...
    varargin, 'boundary', 0, 'partition_names', []);

[D T] = size(data);
mu = zeros(D, 1, nclasses); % dynamically determine num prototypes (may be less than K)
mean_feat = mean(data,2);
pick = cell(1,nclasses);
for c=1:nclasses
  ndx = find(labels==c);
  if isempty(ndx)
    %fprintf('no training images have label %d (%s)\n', c, partition_names{c})
    fprintf('no training images have label %d\n', c);
    nviews = 1;
    mu(:,1,c) = mean_feat;
  else
    foo = linspace(boundary+1, length(ndx-boundary), max_proto);
    pick{c} = ndx(unique(floor(foo)));
    nviews = length(pick{c});
    %fprintf('picking %d views for class %d=%s\n', nviews, c, class_names{c});
    mu(:,1:nviews,c) = data(:, pick{c});
  end
  N(c) = nviews;
end
