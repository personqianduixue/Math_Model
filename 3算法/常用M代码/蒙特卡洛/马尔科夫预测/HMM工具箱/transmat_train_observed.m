function [transmat, initState] = transmat_train_observed(labels,  nstates, varargin)
% transmat_train_observed ML estimation from fully observed data
% function [transmat, initState] = transmat_train_observed(labels,  nstates, varargin)
%
% If all sequences have the same length
% labels(ex,t)
% If sequences have different lengths, we use cell arrays
% labels{ex}(t)

[dirichletPriorWeight, mkSymmetric, other] = process_options(...
    varargin, 'dirichletPriorWeight', 0, 'mkSymmetric', 0);

if ~iscell(labels)
  [numex T] = size(labels);
  if T==1
    labels = labels';
  end
  %fprintf('T=%d, numex=%d\n', T, numex);
  labels = num2cell(labels,2); % each row gets its own cell
end
numex = length(labels);

counts = zeros(nstates, nstates);
counts1 = zeros(nstates,1);
for s=1:numex
  labs = labels{s}; labs = labs(:)';
  dat = [labs(1:end-1); labs(2:end)];
  counts = counts + compute_counts(dat, [nstates nstates]);
  q = labs(1);
  counts1(q) = counts1(q) + 1;
end
pseudo_counts = dirichletPriorWeight*ones(nstates, nstates);
if mkSymmetric
  counts = counts + counts';
end
transmat = mk_stochastic(counts + pseudo_counts);
initState = normalize(counts1 + dirichletPriorWeight*ones(nstates,1));

  
