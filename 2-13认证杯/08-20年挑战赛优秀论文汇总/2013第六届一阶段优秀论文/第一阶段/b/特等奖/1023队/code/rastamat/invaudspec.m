function [spec,wts,iwts] = invaudspec(aspectrum, sr, nfft, fbtype, minfreq, maxfreq, sumpower, bwidth)
%pspectrum = invaudspec(aspectrum, sr, nfft, fbtype, minfreq, maxfreq, sumpower, bwidth)
%
% Invert (as best we can) the effects of audspec()
%
% 2004-02-04 dpwe@ee.columbia.edu

if nargin < 2;  sr = 16000;     end 
if nargin < 3;  nfft = 512;     end
if nargin < 4;  fbtype = 'bark';  end
if nargin < 5;  minfreq = 0;    end
if nargin < 6;  maxfreq = sr/2; end
if nargin < 7;  sumpower = 1;   end
if nargin < 8;  bwidth = 1.0;   end

[nfilts,nframes] = size(aspectrum);

if strcmp(fbtype, 'bark')
  wts = fft2barkmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq);
elseif strcmp(fbtype, 'mel')
  wts = fft2melmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq);
elseif strcmp(fbtype, 'htkmel')
  wts = fft2melmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq, 1, 1);
elseif strcmp(fbtype, 'fcmel')
  wts = fft2melmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq, 1);
else
  disp(['fbtype ', fbtype, ' not recognized']);
  error;
end

% Cut off 2nd half
wts = wts(:,1:((nfft/2)+1));

% Just transpose, fix up 
ww = wts'*wts;
iwts = wts'./(repmat(max(mean(diag(ww))/100, sum(ww))',1,nfilts));
% Apply weights
if (sumpower)
  spec = iwts * aspectrum;
else
  spec = (iwts * sqrt(aspectrum)).^2;
end

