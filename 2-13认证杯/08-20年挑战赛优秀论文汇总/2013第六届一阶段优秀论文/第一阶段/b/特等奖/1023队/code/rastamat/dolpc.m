function y = dolpc(x,modelorder)
%y = dolpc(x,modelorder)
%
% compute autoregressive model from spectral magnitude samples
%
% rows(x) = critical band
% col(x) = frame
%
% row(y) = lpc a_i coeffs, scaled by gain
% col(y) = frame
%
% modelorder is order of model, defaults to 8
% 2003-04-12 dpwe@ee.columbia.edu after shire@icsi.berkeley.edu

[nbands,nframes] = size(x);

if nargin < 2
  modelorder = 8;
end

% Calculate autocorrelation 
r = real(ifft([x;x([(nbands-1):-1:2],:)]));
% First half only
r = r(1:nbands,:);

% Find LPC coeffs by durbin
[y,e] = levinson(r, modelorder);

% Normalize each poly by gain
y = y'./repmat(e',(modelorder+1),1);
