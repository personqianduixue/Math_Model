function T = myreshape(T, sizes)
% MYRESHAPE Like the built-in reshape, except myreshape(T,n) == reshape(T,[n 1])
% T = myreshape(T, sizes)

if length(sizes)==0
  return;
elseif length(sizes)==1
  T = reshape(T, [sizes 1]);
else
  T = reshape(T, sizes(:)');
end
