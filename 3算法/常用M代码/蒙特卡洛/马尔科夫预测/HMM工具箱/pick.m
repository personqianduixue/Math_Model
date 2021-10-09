function [i,j] = pick(ndx)
% PICK Pick an entry at random from a vector
% function [i,j] = pick(ndx)
%
% i = ndx(j) for j ~ U(1:length(ndx))

dist = normalize(ones(1,length(ndx)));
j = sample_discrete(dist);
i = ndx(j);
