function indices = argmax(v)
% ARGMAX Return as a subscript vector the location of the largest element of a multidimensional array v.
% indices = argmax(v)
%
% Returns the first maximum in the case of ties.
% Example:
% X = [2 8 4; 7 3 9];
% argmax(X) = [2 3], i.e., row 2 column 3

[m i] = max(v(:));
indices = ind2subv(mysize(v), i);
