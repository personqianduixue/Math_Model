function y=max_mult(A,x)
% MAX_MULT Like matrix multiplication, but sum gets replaced by max
% function y=max_mult(A,x) y(i) = max_j A(i,j) x(j)

%X=ones(size(A,1),1) * x(:)'; % X(j,i) = x(i)
%y=max(A.*X, [], 2);

% This is faster
if size(x,2)==1
  X=x*ones(1,size(A,1)); % X(i,j) = x(i)
  y=max(A'.*X)';
else
%this works for arbitrarily sized A and x (but is ugly, and slower than above)
  X=repmat(x, [1 1 size(A,1)]);
  B=repmat(A, [1 1 size(x,2)]);
  C=permute(B,[2 3 1]);
  y=permute(max(C.*X),[3 2 1]);
%  this is even slower, as is using squeeze instead of permute
%  Y=permute(X, [3 1 2]);
%  y=permute(max(Y.*B, [], 2), [1 3 2]);
end
