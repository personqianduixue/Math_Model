function x = invpowspec(y, sr, wintime, steptime, excit)
%x = invpowspec(y, sr, wintime, steptime, excit)
%
% Attempt to go back from specgram-like powerspec to audio waveform
% by scaling specgram of white noise
%
% default values:
% sr = 8000Hz
% wintime = 25ms (200 samps)
% steptime = 10ms (80 samps)
% which means use 256 point fft
% hamming window
%
% excit is input excitation; white noise is used if not specified

% for sr = 8000
%NFFT = 256;
%NOVERLAP = 120;
%SAMPRATE = 8000;
%WINDOW = hamming(200);

[nrow, ncol] = size(y);

if nargin < 2
  sr = 8000;
end
if nargin < 3
  wintime = 0.025;
end
if nargin < 4
  steptime = 0.010;
end
if nargin < 5
  r = [];
else
  r = excit;
end

winpts = round(wintime*sr);
steppts = round(steptime*sr);

NFFT = 2^(ceil(log(winpts)/log(2)));

if NFFT ~= 2*(nrow-1)
  disp('Inferred FFT size doesn''t match specgram');
end

NOVERLAP = winpts - steppts;
SAMPRATE = sr;

% Values coming out of rasta treat samples as integers, 
% not range -1..1, hence scale up here to match (approx)
%y = abs(specgram(x*32768,NFFT,SAMPRATE,WINDOW,NOVERLAP)).^2;

xlen = winpts + steppts*(ncol - 1);

if length(r) == 0
  r = randn(xlen,1);
end
r = r(1:xlen);

R = specgram(r/32768/12, NFFT, SAMPRATE, winpts, NOVERLAP);
R = R .* sqrt(y);;
x = ispecgram(R, NFFT, SAMPRATE, winpts, NOVERLAP);
