function B = extend_domain_table(A, smalldom, smallsz, bigdom, bigsz)
% EXTEND_DOMAIN_TABLE Expand an array so it has the desired size.
% B = extend_domain_table(A, smalldom, smallsz, bigdom, bigsz)
%
% A is the array with domain smalldom and sizes smallsz.
% bigdom is the desired domain, with sizes bigsz.
%
% Example:
% smalldom = [1 3], smallsz = [2 4], bigdom = [1 2 3 4], bigsz = [2 1 4 5],
% so B(i,j,k,l) = A(i,k) for i in 1:2, j in 1:1, k in 1:4, l in 1:5

if isequal(size(A), [1 1]) % a scalar
  B = A; % * myones(bigsz);
  return;
end

map = find_equiv_posns(smalldom, bigdom);
sz = ones(1, length(bigdom));
sz(map) = smallsz;
B = myreshape(A, sz); % add dimensions for the stuff not in A
sz = bigsz;
sz(map) = 1; % don't replicate along A's dimensions
B = myrepmat(B, sz(:)');
                           
