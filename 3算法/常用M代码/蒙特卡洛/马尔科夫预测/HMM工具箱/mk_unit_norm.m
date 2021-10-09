function B = mk_unit_norm(A)
% MK_UNIT_NORM Make each column be a unit norm vector
% function B = mk_unit_norm(A)
% 
% We divide each column by its magnitude


[nrows ncols] = size(A);
s = sum(A.^2);
ndx = find(s==0);
s(ndx)=1; 
B = A ./ repmat(sqrt(s), [nrows 1]);

