function p = isvector(v)
% ISVECTOR Returns 1 if all but one dimension have size 1.
% p = isvector(v)
%
% Example: isvector(rand(1,2,1)) = 1, isvector(rand(2,2)) = 0.

s=size(v);
p = (ndims(v)<=2) & (s(1) == 1 | s(2) == 1);
%p = sum( size(v) > 1) <= 1; % Peter Acklam's solution
