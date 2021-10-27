function wts = fft2barkmx(nfft, sr, nfilts, width, minfreq, maxfreq)
% wts = fft2barkmx(nfft, sr, nfilts, width, minfreq, maxfreq)
%      Generate a matrix of weights to combine FFT bins into Bark
%      bins.  nfft defines the source FFT size at sampling rate sr.
%      Optional nfilts specifies the number of output bands required 
%      (else one per bark), and width is the constant width of each 
%      band in Bark (default 1).
%      While wts has nfft columns, the second half are all zero. 
%      Hence, Bark spectrum is fft2barkmx(nfft,sr)*abs(fft(xincols,nfft));
% 2004-09-05  dpwe@ee.columbia.edu  based on rastamat/audspec.m

if nargin < 3;    nfilts = 0;     end
if nargin < 4;    width = 1.0;    end
if nargin < 5;    minfreq = 0;    end
if nargin < 6;    maxfreq = sr/2; end

min_bark = hz2bark(minfreq);
nyqbark = hz2bark(maxfreq) - min_bark;
if nfilts == 0
  nfilts = ceil(nyqbark)+1;
end

wts = zeros(nfilts, nfft);

% bark per filt
step_barks = nyqbark/(nfilts-1);

% Frequency of each FFT bin in Bark
binbarks = hz2bark([0:nfft/2]*sr/nfft);

for i = 1:nfilts
  f_bark_mid = min_bark + (i-1) * step_barks;
  % Linear slopes in log-space (i.e. dB) intersect to trapezoidal window
  lof = (binbarks - f_bark_mid - 0.5);
  hif = (binbarks - f_bark_mid + 0.5);
  wts(i,1:(nfft/2+1)) = 10.^(min(0, min([hif; -2.5*lof])/width));
end

function z = hz2bark(f)
%       HZ2BARK         Converts frequencies Hertz (Hz) to Bark
% taken from rastamat
z = 6 * asinh(f/600);
