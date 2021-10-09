function s = logsumexp(a, dim)
% Returns log(sum(exp(a),dim)) while avoiding numerical underflow.
% Default is dim = 1 (rows) or dim=2 for a row vector
% logsumexp(a, 2) will sum across columns instead of rows

% Written by Tom Minka, modified by Kevin Murphy

if nargin < 2
  dim = 1;
  if ndims(a) <= 2 & size(a,1)==1
    dim = 2;
  end
end

% subtract the largest in each column
[y, i] = max(a,[],dim);
dims = ones(1,ndims(a));
dims(dim) = size(a,dim);
a = a - repmat(y, dims);
s = y + log(sum(exp(a),dim));
%i = find(~finite(y));
%if ~isempty(i)
%  s(i) = y(i);
%end
