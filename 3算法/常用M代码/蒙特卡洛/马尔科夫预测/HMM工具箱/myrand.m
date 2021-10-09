function T = myrand(sizes)
% MYRAND Like the built-in rand, except myrand(k) produces a k*1 vector instead of a k*k matrix,
% T = myrand(sizes)

if length(sizes)==0
  warning('myrand[]');
  T = rand(1,1);
elseif length(sizes)==1
  T = rand(sizes, 1);
else
  T = rand(sizes);
end
