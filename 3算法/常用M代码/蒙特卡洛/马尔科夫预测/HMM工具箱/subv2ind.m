function ndx = subv2ind(siz, subv)
% SUBV2IND Like the built-in sub2ind, but the subscripts are given as row vectors.
% ind = subv2ind(siz,subv)
%
% siz can be a row or column vector of size d.
% subv should be a collection of N row vectors of size d.
% ind will be of size N * 1.
%
% Example:
% subv = [1 1 1;
%         2 1 1;
%         ...
%         2 2 2];
% subv2ind([2 2 2], subv) returns [1 2 ... 8]'
% i.e., the leftmost digit toggles fastest.
%
% See also IND2SUBV.


if isempty(subv)
  ndx = [];
  return;
end

if isempty(siz)
  ndx = 1;
  return;
end

[ncases ndims] = size(subv);

%if length(siz) ~= ndims
%  error('length of subscript vector and sizes must be equal');
%end

if all(siz==2)
  %rbits = subv(:,end:-1:1)-1; % read from right to left, convert to 0s/1s
  %ndx = bitv2dec(rbits)+1; 
  twos = pow2(0:ndims-1);
  ndx = ((subv-1) * twos(:)) + 1;
  %ndx = sum((subv-1) .* twos(ones(ncases,1), :), 2) + 1; % equivalent to matrix * vector
  %ndx = sum((subv-1) .* repmat(twos, ncases, 1), 2) + 1; % much slower than ones
  %ndx = ndx(:)';
else
  %siz = siz(:)';
  cp = [1 cumprod(siz(1:end-1))]';
  %ndx = ones(ncases, 1);
  %for i = 1:ndims
  %  ndx = ndx + (subv(:,i)-1)*cp(i);
  %end
  ndx = (subv-1)*cp + 1;
end

%%%%%%%%%%%

function d = bitv2dec(bits)
% BITV2DEC Convert a bit vector to a decimal integer
% d = butv2dec(bits)
%
% This is just like the built-in bin2dec, except the argument is a vector, not a string.
% If bits is an array, each row will be converted.

[m n] = size(bits);
twos = pow2(n-1:-1:0);
d = sum(bits .* twos(ones(m,1),:),2);

