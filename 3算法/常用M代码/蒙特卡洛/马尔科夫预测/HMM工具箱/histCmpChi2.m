function d = histCmpChi2(h1, h2)
% Compare two histograms using chi-squared
% function d = histCmpChi2(h1, h2)
%
% d(i,j) = chi^2(h1(i,:), h2(j,:)) = sum_b  (h1(i,b)-h2(j,b)^2 / (h1(i,b) + h2(j,b))

[N B] = size(h1);
d = zeros(N,N);
for i=1:N
  h1i = repmat(h1(i,:), N, 1);
  numer = (h1i - h2).^2;
  denom = h1i + h2 + eps; % if denom=0, then numer=0
  d(i,:) = sum(numer ./ denom, 2);
end
  
