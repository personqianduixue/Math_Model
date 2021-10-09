function [T, bitv] = subsets(S, U, L, sorted, N)
% SUBSETS Create a set of all the subsets of S which have cardinality <= U and >= L
% T = subsets(S, U, L)
% U defaults to length(S), L defaults to 0.
% So subsets(S) generates the powerset of S.
%
% Example:
% T = subsets(1:4, 2, 1) 
% T{:} = 1, 2, [1 2], 3, [1 3], [2 3], 4, [1 4], [2 4], [3 4]
%
% T = subsets(S, U, L, sorted)
% If sorted=1, return the subsets in increasing size
%
% Example:
% T = subsets(1:4, 2, 1, 1) 
% T{:} = 1, 2, 3, 4, [1 2], [1 3], [2 3], [1 4], [2 4], [3 4]
%
% [T, bitv] = subsets(S, U, L, sorted, N)
% Row i of bitv is a bit vector representation of T{i},
% where bitv has N columns (representing 1:N).
% N defaults to max(S).
%
% Example:
% [T,bitv] = subsets(2:4, 2^3, 0, 0, 5)
% T{:} = [], 2, 3, [2 3], 4, [2 4], [3 4], [2 3 4]
% bitv=
%     0     0     0     0     0
%     0     1     0     0     0
%     0     0     1     0     0
%     0     1     1     0     0
%     0     0     0     1     0
%     0     1     0     1     0
%     0     0     1     1     0
%     0     1     1     1     0

n = length(S);

if nargin < 2, U = n; end
if nargin < 3, L = 0; end
if nargin < 4, sorted = 0; end
if nargin < 5, N = max(S); end

bits = ind2subv(2*ones(1,n), 1:2^n)-1;
sm = sum(bits,2);
masks = bits((sm <= U) & (sm >= L), :);
m = size(masks, 1);
T = cell(1, m);
for i=1:m
  s = S(find(masks(i,:)));
  T{i} = s;
end

if sorted 
  T = sortcell(T);
end

bitv = zeros(m, N);
bitv(:, S) = masks;
