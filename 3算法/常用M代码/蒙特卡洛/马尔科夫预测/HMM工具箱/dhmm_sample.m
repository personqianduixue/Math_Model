function [obs, hidden] = dhmm_sample(initial_prob, transmat, obsmat, numex, len)
% SAMPLE_DHMM Generate random sequences from a Hidden Markov Model with discrete outputs.
%
% [obs, hidden] = sample_dhmm(initial_prob, transmat, obsmat, numex, len)
% Each row of obs is an observation sequence of length len.

hidden = mc_sample(initial_prob, transmat, len, numex);
obs = multinomial_sample(hidden, obsmat);


