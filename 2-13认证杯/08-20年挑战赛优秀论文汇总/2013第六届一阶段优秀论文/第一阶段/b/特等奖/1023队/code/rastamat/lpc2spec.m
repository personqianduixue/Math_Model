function [features,F,M] = lpc2spec(lpcas, nout)
% [features,F,M] = lpc2spec(lpcas,nout)
%    Convert LPC coeffs back into spectra
%    nout is number of freq channels, default 17 (i.e. for 8 kHz)
% 2003-04-11 dpwe@ee.columbia.edu  part of rastamat

if nargin < 2
  nout = 17;
end

[rows, cols] = size(lpcas);
order = rows - 1;

gg = lpcas(1,:);
aa = lpcas./repmat(gg,rows,1);

% Calculate the actual z-plane polyvals: nout points around unit circle
zz = exp((-j*[0:(nout-1)]'*pi/(nout-1))*[0:order]);

% Actual polyvals, in power (mag^2)
features =  ((1./abs(zz*aa)).^2)./repmat(gg,nout,1);

F = zeros(cols, floor(rows/2));
M = F;

for c = 1:cols;
  aaa = aa(:,c);
  rr = roots(aaa');
  ff = angle(rr');
%  size(ff)
%  size(aaa)
  zz = exp(j*ff'*[0:(length(aaa)-1)]);
  mags = sqrt(((1./abs(zz*aaa)).^2)/gg(c))';
  
  [dummy, ix] = sort(ff);
  keep = ff(ix) > 0;
  ix = ix(keep);
  F(c,1:length(ix)) = ff(ix);
  M(c,1:length(ix)) = mags(ix);
end
