function smallT = marginalize_table(bigT, bigdom, bigsz, onto, maximize)
% MARG_TABLE Marginalize a table
% function smallT = marginalize_table(bigT, bigdom, bigsz, onto, maximize)

% Like marg_table in BNT, except we do not assume the domains are sorted

if nargin < 5, maximize = 0; end


smallT = myreshape(bigT, bigsz); % make sure it is a multi-dim array
sum_over = mysetdiff(bigdom, onto);
ndx = find_equiv_posns(sum_over, bigdom);
if maximize
  for i=1:length(ndx)
    smallT = max(smallT, [], ndx(i));
  end
else
  for i=1:length(ndx)
    smallT = sum(smallT, ndx(i));
  end
end


ns = zeros(1, max(bigdom));
%ns(bigdom) = mysize(bigT); % ignores trailing dimensions of size 1
ns(bigdom) = bigsz;

% If onto has a different ordering than bigdom, the following
% will produce the wrong results

%smallT = squeeze(smallT); % remove all dimensions of size 1
%smallT = myreshape(smallT, ns(onto)); % put back relevant dims of size 1

% so permute dimensions to match desired ordering (as specified by onto)


% like find_equiv_posns, but keeps ordering
outdom = [onto sum_over];
for i=1:length(outdom)
  j = find(bigdom==outdom(i));
  match(i) = j;
end
outdom = [onto sum_over];
for i=1:length(outdom)
  j = find(bigdom==outdom(i));
  match(i) = j;
end
if match ~= 1
  smallT = permute(smallT, match);
end
