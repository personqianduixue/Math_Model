function M = assign_cols(cols, vals, M)
% ASSIGN_COLS Assign values to columns of a matrix
% function M = assign_cols(M, cols, vals, M)
%
% Example:
% M = assign_cols(data, ones(1,N))
% will construct a 1-of-K encoding of the data, where K=ncols=max(data) and N=nrows=length(data)
%
% Example:
% M = zeros(3,2);
% M = assign_cols([1 2 1], [10 20 30], M)
% is equivalent to
% M(1, 1) = 10
% M(2, 2) = 20
% M(3, 1) = 30
%

if nargin < 3
  nr = length(cols);
  nc = max(cols);
  M = zeros(nr, nc);
else
  [nr nc] = size(M);
end

if 0
for r=1:nr
  M(r, cols(r)) = vals(r);
end
end

if 1
rows = 1:nr;
ndx = subv2ind([nr nc], [rows(:) cols(:)]);
M(ndx) = vals;
end
