function [a,ass] = bipartiteMatchingIntProg(dst, nmatches)
% BIPARTITEMATCHINGINTPROG Use binary integer programming (linear objective) to solve for optimal linear assignment
% function a = bipartiteMatchingIntProg(dst)
% a(i) = best matching column for row i
% 
% This gives the same result as bipartiteMatchingHungarian.
%
% function a = bibpartiteMatchingIntProg(dst, nmatches)
% only matches the specified number (must be <= min(size(dst))).
% This can be used to allow outliers in both source and target.
%
% For details, see Marciel & Costeira, "A global solution to sparse correspondence
% problems", PAMI 25(2), 2003

if nargin < 2, nmatches = []; end

[p1 p2] = size(dst);
p1orig = p1; p2orig = p2;
dstorig = dst;

if isempty(nmatches) % no outliers allowed  (modulo size difference)
  % ensure matrix is square
  m = max(dst(:));
  if p1<p2
    dst = [dst; m*ones(p2-p1, p2)];
  elseif p1>p2
    dst = [dst  m*ones(p1, p1-p2)];
  end
end
[p1 p2] = size(dst);


c = dst(:); % vectorize cost matrix

% row-sum: ensure each column sums to 1
A2 = kron(eye(p2), ones(1,p1));
b2 = ones(p2,1);

% col-sum: ensure each row sums to 1
A3 = kron(ones(1,p2), eye(p1));
b3 = ones(p1,1);

if isempty(nmatches)
  % enforce doubly  stochastic
  A = [A2; A3];
  b = [b2; b3];
  Aineq = zeros(1, p1*p2);
  bineq = 0;
else
  nmatches = min([nmatches, p1, p2]);
  Aineq = [A2; A3];
  bineq = [b2; b3]; % row and col sums <= 1
  A = ones(1,p1*p2);
  b = nmatches; % total num matches = b (otherwise get degenerate soln)
end


ass = bintprog(c, Aineq, bineq, A, b);
ass = reshape(ass, p1, p2);

a = zeros(1, p1orig);
for i=1:p1orig
  ndx = find(ass(i,:)==1);
  if ~isempty(ndx) & (ndx <= p2orig)
    a(i) = ndx;
  end
end


