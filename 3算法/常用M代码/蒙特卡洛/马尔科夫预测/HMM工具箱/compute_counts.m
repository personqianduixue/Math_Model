function count = compute_counts(data, sz)
% COMPUTE_COUNTS Count the number of times each combination of discrete assignments occurs
% count = compute_counts(data, sz)
%
% data(i,t) is the value of variable i in case t
% sz(i) : values for variable i are assumed to be in [1:sz(i)]
%
% Example: to compute a transition matrix for an HMM from a sequence of labeled states:
% transmat = mk_stochastic(compute_counts([seq(1:end-1); seq(2:end)], [nstates nstates]));

assert(length(sz) == size(data, 1));
P = prod(sz);
indices = subv2ind(sz, data'); % each row of data' is a case 
%count = histc(indices, 1:P);
count = hist(indices, 1:P);
count = myreshape(count, sz);

