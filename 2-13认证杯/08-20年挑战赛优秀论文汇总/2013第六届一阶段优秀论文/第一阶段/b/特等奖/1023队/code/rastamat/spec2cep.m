function [cep,dctm] = spec2cep(spec, ncep, type)
% [cep,dctm] = spec2cep(spec, ncep, type)
%     Calculate cepstra from spectral samples (in columns of spec)
%     Return ncep cepstral rows (defaults to 9)
%     This one does type II dct, or type I if type is specified as 1
%     dctm returns the DCT matrix that spec was multiplied by to give cep.
% 2005-04-19 dpwe@ee.columbia.edu  for mfcc_dpwe

if nargin < 2;   ncep = 13;   end
if nargin < 3;   type = 2;   end   % type of DCT

[nrow, ncol] = size(spec);

% Make the DCT matrix
dctm = zeros(ncep, nrow);
if type == 2 || type == 3
  % this is the orthogonal one, the one you want
  for i = 1:ncep
    dctm(i,:) = cos((i-1)*[1:2:(2*nrow-1)]/(2*nrow)*pi) * sqrt(2/nrow);
  end
  if type == 2
    % make it unitary! (but not for HTK type 3)
    dctm(1,:) = dctm(1,:)/sqrt(2);
  end
elseif type == 4 % type 1 with implicit repeating of first, last bins
  % Deep in the heart of the rasta/feacalc code, there is the logic 
  % that the first and last auditory bands extend beyond the edge of 
  % the actual spectra, and they are thus copied from their neighbors.
  % Normally, we just ignore those bands and take the 19 in the middle, 
  % but when feacalc calculates mfccs, it actually takes the cepstrum 
  % over the spectrum *including* the repeated bins at each end.
  % Here, we simulate 'repeating' the bins and an nrow+2-length 
  % spectrum by adding in extra DCT weight to the first and last
  % bins.
  for i = 1:ncep
    dctm(i,:) = cos((i-1)*[1:nrow]/(nrow+1)*pi) * 2;
    % Add in edge points at ends (includes fixup scale)
    dctm(i,1) = dctm(i,1) + 1;
    dctm(i,nrow) = dctm(i,nrow) + ((-1)^(i-1));
  end
  dctm = dctm / (2*(nrow+1));
else % dpwe type 1 - same as old spec2cep that expanded & used fft
  for i = 1:ncep
    dctm(i,:) = cos((i-1)*[0:(nrow-1)]/(nrow-1)*pi) * 2 / (2*(nrow-1));
  end
  % fixup 'non-repeated' points
  dctm(:,[1 nrow]) = dctm(:, [1 nrow])/2;
end  

cep = dctm*log(spec);
  
