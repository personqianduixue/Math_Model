function T = myrepmat(T, sizes)
% MYREPMAT Like the built-in repmat, except myrepmat(T,n) == repmat(T,[n 1])
% T = myrepmat(T, sizes)

if length(sizes)==1
  T = repmat(T, [sizes 1]);
else
  T = repmat(T, sizes(:)');
end
