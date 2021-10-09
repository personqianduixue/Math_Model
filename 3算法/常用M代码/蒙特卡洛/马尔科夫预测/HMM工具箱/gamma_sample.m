function r = gamrnd(a,b,m,n);
%GAMRND Random matrices from gamma distribution.
%   R = GAMRND(A,B) returns a matrix of random numbers chosen   
%   from the gamma distribution with parameters A and B.
%   The size of R is the common size of A and B if both are matrices.
%   If either parameter is a scalar, the size of R is the size of the other
%   parameter. Alternatively, R = GAMRND(A,B,M,N) returns an M by N matrix. 
%
%   Some references refer to the gamma distribution
%   with a single parameter. This corresponds to GAMRND
%   with B = 1. (See Devroye, pages 401-402.)

%   GAMRND uses a rejection or an inversion method depending on the
%   value of A. 

%   References:
%      [1]  L. Devroye, "Non-Uniform Random Variate Generation", 
%      Springer-Verlag, 1986

%   B.A. Jones 2-1-93
%   Copyright (c) 1993-98 by The MathWorks, Inc.
%   $Revision: 1.1 $  $Date: 2005/04/26 02:29:18 $

if nargin < 2, 
   error('Requires at least two input arguments.'); 
end


if nargin == 2
   [errorcode rows columns] = rndcheck(2,2,a,b);
end

if nargin == 3
   [errorcode rows columns] = rndcheck(3,2,a,b,m);
end

if nargin == 4
   [errorcode rows columns] = rndcheck(4,2,a,b,m,n);
end

if errorcode > 0
   error('Size information is inconsistent.');
end

% Initialize r to zero.
lth = rows*columns;
r = zeros(lth,1);
a = a(:); b = b(:);

scalara = (length(a) == 1);
if scalara 
   a = a*ones(lth,1);
end

scalarb = (length(b) == 1);
if scalarb 
   b = b*ones(lth,1);
end

% If a == 1, then gamma is exponential. (Devroye, page 405).
k = find(a == 1);
if any(k)
   r(k) = -b(k) .* log(rand(size(k)));
end 


k = find(a < 1 & a > 0);
% (Devroye, page 418 Johnk's generator)
if any(k)
  c = zeros(lth,1);
  d = zeros(lth,1);
  c(k) = 1 ./ a(k);
  d(k) = 1 ./ (1 - a(k));
  accept = k;
  while ~isempty(accept)
    u = rand(size(accept));
    v = rand(size(accept));
    x = u .^ c(accept);
    y = v .^ d(accept);
    k1 = find((x + y) <= 1); 
    if ~isempty(k1)
      e = -log(rand(size(k1))); 
      r(accept(k1)) = e .* x(k1) ./ (x(k1) + y(k1));
      accept(k1) = [];
    end
  end
  r(k) = r(k) .* b(k);
end

% Use a rejection method for a > 1.
k = find(a > 1);
% (Devroye, page 410 Best's algorithm)
bb = zeros(size(a));
c  = bb;
if any(k)
  bb(k) = a(k) - 1;
  c(k) = 3 * a(k) - 3/4;
  accept = k; 
  count = 1;
  while ~isempty(accept)
    m = length(accept);
    u = rand(m,1);
    v = rand(m,1);
    w = u .* (1 - u);
    y = sqrt(c(accept) ./ w) .* (u - 0.5);
    x = bb(accept) + y;
    k1 = find(x >= 0);
    if ~isempty(k1)
      z = 64 * (w .^ 3) .* (v .^ 2);
      k2 = (z(k1) <= (1 - 2 * (y(k1) .^2) ./ x(k1)));
      k3 = k1(find(k2));
      r(accept(k3)) = x(k3); 
      k4 = k1(find(~k2));
      k5 = k4(find(log(z(k4)) <= (2*(bb(accept(k4)).*log(x(k4)./bb(accept(k4)))-y(k4)))));
      r(accept(k5)) = x(k5);
      omit = [k3; k5];
      accept(omit) = [];
    end
  end
  r(k) = r(k) .* b(k);
end

% Return NaN if a or b is not positive.
r(b <= 0 | a <= 0) = NaN;

r = reshape(r,rows,columns);
