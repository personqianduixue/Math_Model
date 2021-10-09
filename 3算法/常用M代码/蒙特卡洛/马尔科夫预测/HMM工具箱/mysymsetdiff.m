function C = mysymsetdiff(A,B)
% MYSYMSETDIFF Symmetric set difference of two sets of positive integers (much faster than built-in setdiff)
% C = mysetdiff(A,B)
% C = (A\B) union (B\A) = { things that A and B don't have in common }

if isempty(A)
  ma = 0;
else
  ma = max(A);
end

if isempty(B)
  mb = 0;
else
  mb = max(B);
end

if ma==0 
  C = B;
elseif mb==0
  C = A;
else % both non-empty
  m = max(ma,mb);
  bitsA = sparse(1, m);
  bitsA(A) = 1;
  bitsB = sparse(1, m);
  bitsB(B) = 1;
  C = find(xor(bitsA, bitsB));
end
