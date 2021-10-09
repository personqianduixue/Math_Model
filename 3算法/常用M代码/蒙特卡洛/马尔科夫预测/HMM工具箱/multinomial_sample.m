function Y = sample_cond_multinomial(X, M)
% SAMPLE_MULTINOMIAL Sample Y(i) ~ M(X(i), :)
% function Y = sample_multinomial(X, M)
%
% X(i) = i'th sample
% M(i,j) = P(Y=j | X=i) = noisy channel model
%
% e.g., if X is a binary image,
% Y = sample_multinomial(softeye(2, 0.9), X)
% will create a noisy version of X, where bits are flipped with probability 0.1

if any(X(:)==0)
  error('data must only contain positive integers')
end

Y = zeros(size(X));
for i=min(X(:)):max(X(:))
  ndx = find(X==i);
  Y(ndx) = sample_discrete(M(i,:), length(ndx), 1);
end


