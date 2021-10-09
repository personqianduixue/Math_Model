function T = myones(sizes)
% MYONES Like the built-in ones, except myones(k) produces a k*1 vector instead of a k*k matrix,
% T = myones(sizes)

if length(sizes)==0
  T = 1;
elseif length(sizes)==1
  T = ones(sizes, 1);
else
  T = ones(sizes(:)');
end
