function indices = argmin(v)
% ARGMIN Return as a subscript vector the location of the smallest element of a multidimensional array v.
% indices = argmin(v)
%
% Returns the first minimum in the case of ties.
% Example:
% X = [2 8 4; 7 3 9];
% argmin(X) = [1 1], i.e., row 1 column 1

[m i] = min(v(:));
indices = ind2subv(mysize(v), i);
%indices = ind2subv(size(v), i);
