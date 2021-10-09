function [a, b, error] = weightedRegression(x, z, w)
% [a , b, error] = fitRegression(x, z, w);
% % Weighted scalar linear regression
%
% Find a,b to minimize
% error = sum(w * |z - (a*x + b)|^2) 
% and x(i) is a scalar

if nargin < 3, w = ones(1,length(x)); end

w = w(:)';
x = x(:)';
z = z(:)';

W = sum(w);
Y = sum(w .* z);
YY = sum(w .* z .* z);
YTY = sum(w .* z .* z);
X = sum(w .* x);
XX = sum(w .* x .* x);
XY = sum(w .* x .* z);

[b, a] = clg_Mstep_simple(W, Y, YY, YTY, X, XX, XY);
error = sum(w .* (z - (a*x + b)).^2 );

if 0
  % demo
  seed = 1;
  rand('state', seed);   randn('state', seed);
  x = -10:10;
  N = length(x);
  noise = randn(1,N);
  aTrue = rand(1,1);
  bTrue = rand(1,1);
  z = aTrue*x + bTrue + noise;
  
  w = ones(1,N);
  [a, b, err] = weightedRegression(x, z, w);
  
  b2=regress(z(:), [x(:) ones(N,1)]);
  assert(approxeq(b,b2(2)))
  assert(approxeq(a,b2(1)))

  % Make sure we go through x(15) perfectly
  w(15) = 1000;
  [aW, bW, errW] = weightedRegression(x, z, w);

  figure;
  plot(x, z, 'ro')
  hold on
  plot(x, a*x+b, 'bx-')
  plot(x, aW*x+bW, 'gs-')
  title(sprintf('a=%5.2f, aHat=%5.2f, aWHat=%5.3f, b=%5.2f, bHat=%5.2f, bWHat=%5.3f, err=%5.3f, errW=%5.3f', ...
		aTrue, a, aW, bTrue, b, bW, err, errW))
  legend('truth', 'ls', 'wls')
  
end

