function s = logsumexpv(a)
% Returns log(sum(exp(a)))  while avoiding numerical underflow.
%
% e.g., log(e^a1 + e^a2) = a1 + log(1 + e^(a2-a1)) if a1>a2
% If a1 ~ a2, and a1>a2, then e^(a2-a1) is exp(small negative number),
% which can be computed without underflow.

% Same as logsumexp, except we assume a is a vector.
% This avoids a call to repmat, which takes 50% of the time!

a = a(:)'; % make row vector
m = max(a);
b = a - m*ones(1,length(a));
s = m + log(sum(exp(b)));

