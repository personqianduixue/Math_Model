function T2 = sumv(T1, sum_over)
%
% Like the built in sum, but will sum over several dimensions and then squeeze the result.

T2 = T1;
for i=1:length(sum_over)
  if sum_over(i) <= ndims(T2) % prevent summing over non-existent dimensions
    T2=sum(T2, sum_over(i));
  end
end
T2 = squeeze(T2);
