function p = logist2Apply(beta, x)
% LOGIST2APPLY 2 class logistic regression: compute posterior prob of class 1
% function p = logist2Apply(beta, x)
%
% x(:,i) - each COLUMN is a test case; we append 1s automatically, if appropriate

[D Ncases] = size(x);
if length(beta)==D+1
  F = [x; ones(1,Ncases)];
else
  F = x;
end
p = 1./(1+exp(-beta(:)'*F));
