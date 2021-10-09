% MATCH - Solves the weighted bipartite matching (or assignment)
%         problem.
%
% Usage:  a = match(C);
%
% Arguments:   
%         C     - an m x n cost matrix; the sets are taken to be
%                 1:m and 1:n; C(i, j) gives the cost of matching
%                 items i (of the first set) and j (of the second set)
%
% Returns:
%
%         a     - an m x 1 assignment vector, which gives the
%                 minimum cost assignment.  a(i) is the index of
%                 the item of 1:n that was matched to item i of
%                 1:m.  If item i (of 1:m) was not matched to any 
%                 item of 1:n, then a(i) is zero.

% Copyright (C) 2002 Mark A. Paskin
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
% USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [a] = optimalMatching(C)

% Trivial cases:
[p, q] = size(C);
if (p == 0)
  a = []; 
  return;
elseif (q == 0)
  a = zeros(p, 1);
  return;
end


if  0
% First, reduce the problem by making easy optimal matches.  If two
% elements agree that they are the best match, then match them up.
[x, a] = min(C, [], 2);
[y, b] = min(C, [], 1);
u = find(1:p ~= b(a(:)));
a(u) = 0;
v = find(1:q ~= a(b(:))');
C = C(u, v);
if (isempty(C)) return; end
end

% Get the (new) size of the two sets, u and v.
[m, n] = size(C);

%mx = realmax;
mx = 2*max(C(:));
mn = -2*min(C(:));
% Pad the affinity matrix to be square
if (m < n)
  C = [C; mx * ones(n - m, n)];
elseif (n < m)
  C = [C, mx * ones(m, m - n)];
end

% Run the Hungarian method.  First replace infinite values by the
% largest (or smallest) finite values.
C(find(isinf(C) & (C > 0))) = mx;
C(find(isinf(C) & (C < 0))) = mn;
%fprintf('running hungarian\n');
[b, cost] = hungarian(C');

% Extract only the real assignments
ap = b(1:m)';
ap(find(ap > n)) = 0;

a = ap; 
%% Incorporate this sub-assignment into the complete assignment
%  k = find(ap);
%  a(u(k)) = v(ap(k));

