function sub = ind2subv(siz, ndx)
% IND2SUBV Like the built-in ind2sub, but returns the answer as a row vector.
% sub = ind2subv(siz, ndx)
%
% siz and ndx can be row or column vectors.
% sub will be of size length(ndx) * length(siz).
%
% Example
% ind2subv([2 2 2], 1:8) returns
%  [1 1 1
%   2 1 1
%   ...
%   2 2 2]
% That is, the leftmost digit toggle fastest.
%
% See also SUBV2IND

n = length(siz);

if n==0
  sub = ndx;
  return;
end  

if all(siz==2)
  sub = dec2bitv(ndx-1, n);
  sub = sub(:,n:-1:1)+1;
  return;
end

cp = [1 cumprod(siz(:)')];
ndx = ndx(:) - 1;
sub = zeros(length(ndx), n);
for i = n:-1:1 % i'th digit
  sub(:,i) = floor(ndx/cp(i))+1;
  ndx = rem(ndx,cp(i));
end

%%%%%%%%%%

function bits = dec2bitv(d,n)
% DEC2BITV Convert a decimal integer to a bit vector.
% bits = dec2bitv(d,n) is just like the built-in dec2bin, except the answer is a vector, not a string.
% n is an optional minimum length on the bit vector.
% If d is a vector,  each row of the output array will be a bit vector.


if (nargin<2)
  n=1; % Need at least one digit even for 0.
end
d = d(:);

[f,e]=log2(max(d)); % How many digits do we need to represent the numbers?
bits=rem(floor(d*pow2(1-max(n,e):0)),2);
