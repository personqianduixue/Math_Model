function [spec,idctm] = cep2spec(cep, nfreq, type)
% spec = cep2spec(cep, nfreq, type)
%   Reverse the cepstrum to recover a spectrum.
%   i.e. converse of spec2cep
%   nfreq is how many points to reconstruct in spec
% 2005-05-15 dpwe@ee.columbia.edu

if nargin < 2;   nfreq = 21;   end
if nargin < 3;   type = 2;   end   % type of DCT

[ncep,ncol] = size(cep);

% Make the DCT matrix
dctm = zeros(ncep, nfreq);
idctm = zeros(nfreq, ncep);
if type == 2 || type == 3
  % this is the orthogonal one, so inv matrix is same as fwd matrix
  for i = 1:ncep
    dctm(i,:) = cos((i-1)*[1:2:(2*nfreq-1)]/(2*nfreq)*pi) * sqrt(2/nfreq);
  end
  if type == 2 
    % make it unitary! (but not for HTK type 3)
    dctm(1,:) = dctm(1,:)/sqrt(2);
  else
    dctm(1,:) = dctm(1,:)/2;    
  end
  idctm = dctm';
elseif type == 4 % type 1 with implicit repetition of first, last bins
  % so all we do is reconstruct the middle nfreq rows of an nfreq+2 row idctm
  for i = 1:ncep
    % 2x to compensate for fact that only getting +ve freq half
    idctm(:,i) = 2*cos((i-1)*[1:nfreq]'/(nfreq+1)*pi);
  end
  % fixup 'non-repeated' basis fns 
  idctm(:, [1 ncep]) = idctm(:, [1 ncep])/2;
else % dpwe type 1 - idft of cosine terms
  for i = 1:ncep
    % 2x to compensate for fact that only getting +ve freq half
    idctm(:,i) = 2*cos((i-1)*[0:(nfreq-1)]'/(nfreq-1)*pi);
  end
  % fixup 'non-repeated' basis fns 
  idctm(:, [1 ncep]) = 0.5* idctm(:, [1 ncep]);
end  

spec = exp(idctm*cep);
