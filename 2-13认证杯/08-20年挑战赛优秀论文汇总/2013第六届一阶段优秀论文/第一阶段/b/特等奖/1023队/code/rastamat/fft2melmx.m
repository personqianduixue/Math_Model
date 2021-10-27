function [wts,binfrqs] = fft2melmx(nfft, sr, nfilts, width, minfrq, maxfrq, htkmel, constamp)
% [wts,frqs] = fft2melmx(nfft, sr, nfilts, width, minfrq, maxfrq, htkmel, constamp)
%      Generate a matrix of weights to combine FFT bins into Mel
%      bins.  nfft defines the source FFT size at sampling rate sr.
%      Optional nfilts specifies the number of output bands required 
%      (else one per "mel/width"), and width is the constant width of each 
%      band relative to standard Mel (default 1).
%      While wts has nfft columns, the second half are all zero. 
%      Hence, Mel spectrum is fft2melmx(nfft,sr)*abs(fft(xincols,nfft));
%      minfrq is the frequency (in Hz) of the lowest band edge;
%      default is 0, but 133.33 is a common standard (to skip LF).
%      maxfrq is frequency in Hz of upper edge; default sr/2.
%      You can exactly duplicate the mel matrix in Slaney's mfcc.m
%      as fft2melmx(512, 8000, 40, 1, 133.33, 6855.5, 0);
%      htkmel=1 means use HTK's version of the mel curve, not Slaney's.
%      constamp=1 means make integration windows peak at 1, not sum to 1.
%      frqs returns bin center frqs.
% 2004-09-05  dpwe@ee.columbia.edu  based on fft2barkmx

if nargin < 2;     sr = 8000;      end
if nargin < 3;     nfilts = 0;     end
if nargin < 4;     width = 1.0;    end
if nargin < 5;     minfrq = 0;     end  % default bottom edge at 0
if nargin < 6;     maxfrq = sr/2;  end  % default top edge at nyquist
if nargin < 7;     htkmel = 0;     end
if nargin < 8;     constamp = 0;   end

if nfilts == 0
  nfilts = ceil(hz2mel(maxfrq, htkmel)/2);
end

wts = zeros(nfilts, nfft);

% Center freqs of each FFT bin
fftfrqs = [0:(nfft/2)]/nfft*sr;

% 'Center freqs' of mel bands - uniformly spaced between limits
minmel = hz2mel(minfrq, htkmel);
maxmel = hz2mel(maxfrq, htkmel);
binfrqs = mel2hz(minmel+[0:(nfilts+1)]/(nfilts+1)*(maxmel-minmel), htkmel);

binbin = round(binfrqs/sr*(nfft-1));

for i = 1:nfilts
%  fs = mel2hz(i + [-1 0 1], htkmel);
  fs = binfrqs(i+[0 1 2]);
  % scale by width
  fs = fs(2)+width*(fs - fs(2));
  % lower and upper slopes for all bins
  loslope = (fftfrqs - fs(1))/(fs(2) - fs(1));
  hislope = (fs(3) - fftfrqs)/(fs(3) - fs(2));
  % .. then intersect them with each other and zero
%  wts(i,:) = 2/(fs(3)-fs(1))*max(0,min(loslope, hislope));
  wts(i,1+[0:(nfft/2)]) = max(0,min(loslope, hislope));

  % actual algo and weighting in feacalc (more or less)
%  wts(i,:) = 0;
%  ww = binbin(i+2)-binbin(i);
%  usl = binbin(i+1)-binbin(i);
%  wts(i,1+binbin(i)+[1:usl]) = 2/ww * [1:usl]/usl;
%  dsl = binbin(i+2)-binbin(i+1);
%  wts(i,1+binbin(i+1)+[1:(dsl-1)]) = 2/ww * [(dsl-1):-1:1]/dsl;
% need to disable weighting below if you use this one

end

if (constamp == 0)
  % Slaney-style mel is scaled to be approx constant E per channel
  wts = diag(2./(binfrqs(2+[1:nfilts])-binfrqs(1:nfilts)))*wts;
end

% Make sure 2nd half of FFT is zero
wts(:,(nfft/2+2):nfft) = 0;
% seems like a good idea to avoid aliasing


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = mel2hz(z, htk)
%   f = mel2hz(z, htk)
%   Convert 'mel scale' frequencies into Hz
%   Optional htk = 1 means use the HTK formula
%   else use the formula from Slaney's mfcc.m
% 2005-04-19 dpwe@ee.columbia.edu

if nargin < 2
  htk = 0;
end

if htk == 1
  f = 700*(10.^(z/2595)-1);
else
  
  f_0 = 0; % 133.33333;
  f_sp = 200/3; % 66.66667;
  brkfrq = 1000;
  brkpt  = (brkfrq - f_0)/f_sp;  % starting mel value for log region
  logstep = exp(log(6.4)/27); % the magic 1.0711703 which is the ratio needed to get from 1000 Hz to 6400 Hz in 27 steps, and is *almost* the ratio between 1000 Hz and the preceding linear filter center at 933.33333 Hz (actually 1000/933.33333 = 1.07142857142857 and  exp(log(6.4)/27) = 1.07117028749447)

  linpts = (z < brkpt);

  f = 0*z;

  % fill in parts separately
  f(linpts) = f_0 + f_sp*z(linpts);
  f(~linpts) = brkfrq*exp(log(logstep)*(z(~linpts)-brkpt));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z = hz2mel(f,htk)
%  z = hz2mel(f,htk)
%  Convert frequencies f (in Hz) to mel 'scale'.
%  Optional htk = 1 uses the mel axis defined in the HTKBook
%  otherwise use Slaney's formula
% 2005-04-19 dpwe@ee.columbia.edu

if nargin < 2
  htk = 0;
end

if htk == 1
  z = 2595 * log10(1+f/700);
else
  % Mel fn to match Slaney's Auditory Toolbox mfcc.m

  f_0 = 0; % 133.33333;
  f_sp = 200/3; % 66.66667;
  brkfrq = 1000;
  brkpt  = (brkfrq - f_0)/f_sp;  % starting mel value for log region
  logstep = exp(log(6.4)/27); % the magic 1.0711703 which is the ratio needed to get from 1000 Hz to 6400 Hz in 27 steps, and is *almost* the ratio between 1000 Hz and the preceding linear filter center at 933.33333 Hz (actually 1000/933.33333 = 1.07142857142857 and  exp(log(6.4)/27) = 1.07117028749447)

  linpts = (f < brkfrq);

  z = 0*f;

  % fill in parts separately
  z(linpts) = (f(linpts) - f_0)/f_sp;
  z(~linpts) = brkpt+(log(f(~linpts)/brkfrq))./log(logstep);

end
