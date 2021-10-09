function r = unif_discrete_sample(n, nrows, ncols)
% UNIF_DISCRETE_SAMPLE Generate random numbers uniformly from {1,2,..,n}
% function r = unif_discrete_sample(n, nrows, ncols)
% Same as unidrnd in the stats toolbox.

r = ceil(n .* rand(nrows,ncols));
