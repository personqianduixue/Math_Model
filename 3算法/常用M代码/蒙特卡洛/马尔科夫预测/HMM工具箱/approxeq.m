function p = approxeq(a, b, tol, rel)
% APPROXEQ Are a and b approximately equal (to within a specified tolerance)?
% p = approxeq(a, b, thresh)
% 'tol' defaults to 1e-3.
% p(i) = 1 iff abs(a(i) - b(i)) < thresh
%
% p = approxeq(a, b, thresh, 1)
% p(i) = 1 iff abs(a(i)-b(i))/abs(a(i)) < thresh

if nargin < 3, tol = 1e-2; end
if nargin < 4, rel = 0; end

a = a(:);
b = b(:);
d = abs(a-b);
if rel
  p = ~any( (d ./ (abs(a)+eps)) > tol);
else
  p = ~any(d > tol);
end

