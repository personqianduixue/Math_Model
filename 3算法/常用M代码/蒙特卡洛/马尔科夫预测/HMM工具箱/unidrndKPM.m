function R = unidrndKPM(min, max, nr, nc)

if nargin < 3
  nr = 1; nc = 1;
end

R = unidrnd(max-min+1, nr, nc) + (min-1);
