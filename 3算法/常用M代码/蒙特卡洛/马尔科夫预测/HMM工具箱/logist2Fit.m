function [beta, p] = logist2Fit(y, x, addOne, w)
% LOGIST2FIT 2 class logsitic classification
% function beta = logist2Fit(y,x, addOne)
%
% y(i) = 0/1
% x(:,i) = i'th input - we optionally append 1s to last dimension
% w(i) = optional weight
%
% beta(j)- regression coefficient

if nargin < 3, addOne = 1; end
if nargin < 4, w = 1; end

Ncases = size(x,2);
if Ncases ~= length(y)
  error(sprintf('size of data = %dx%d, size of labels=%d', size(x,1), size(x,2), length(y)))
end
if addOne
  x = [x; ones(1,Ncases)];
end
[beta, p] = logist2(y(:), x', w(:));
beta = beta(:);
