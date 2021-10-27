function features = lpc2cep(a,nout)
% features = lpc2cep(lpcas,nout)
%    Convert the LPC 'a' coefficients in each column of lpcas
%    into frames of cepstra.
%    nout is number of cepstra to produce, defaults to size(lpcas,1)
% 2003-04-11 dpwe@ee.columbia.edu

[nin, ncol] = size(a);

order = nin - 1;

if nargin < 2
  nout = order + 1;
end

c = zeros(nout, ncol);

% Code copied from HSigP.c: LPC2Cepstrum

% First cep is log(Error) from Durbin
c(1,:) = -log(a(1,:));

% Renormalize lpc A coeffs
a = a ./ repmat(a(1,:), nin, 1);
  
for n = 2:nout
  sum = 0;
  for m = 2:n
    sum = sum + (n - m) * a(m,:) .* c(n - m + 1, :);
  end
  c(n,:) = -(a(n,:) + sum / (n-1));
end

features = c;

