function p = isscalar(v)
% ISSCALAR Returns 1 if all dimensions have size 1.
% p = isscalar(v)

p = (prod(size(v))==1);
