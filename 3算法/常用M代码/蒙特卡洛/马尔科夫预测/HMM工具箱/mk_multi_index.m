function index = mk_multi_index(n, dims, vals)
% MK_MULTI_INDEX Compute the indices of the submatrix where dims(i)=vals(i).
% index = mk_multi_index(n, dims, vals)
% 
% Example:
% index = mk_multi_index(3, [1 3], [3 2])
% gives index = {3, ':', 2}, which will select out dim 1 = 3 and dim 3 = 2
% So if A(:,:,1)=[1 2;3 4; 5 6]; A(:,:,2)=[7 8; 9 10; 11 12]
% then A(index{:}) = [11 12]: 

if n==0
  index = { 1 };
  return;
end

index = cell(1,n);
for i=1:n
  index{i} = ':';
end
for i=1:length(dims)
  index{dims(i)} = vals(i);
end

