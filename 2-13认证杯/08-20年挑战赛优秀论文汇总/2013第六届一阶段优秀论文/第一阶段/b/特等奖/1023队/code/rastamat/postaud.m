function [y,eql] = postaud(x,fmax,fbtype,broaden)
%y = postaud(x, fmax, fbtype)
%
% do loudness equalization and cube root compression
% x = critical band filters
% rows = critical bands
% cols = frames

if nargin < 3
  fbtype = 'bark';
end
if nargin < 4
  % By default, don't add extra flanking bands
  broaden = 0;
end


[nbands,nframes] = size(x);

% equal loundness weights stolen from rasta code
%eql = [0.000479 0.005949 0.021117 0.044806 0.073345 0.104417 0.137717 ...
%      0.174255 0.215590 0.263260 0.318302 0.380844 0.449798 0.522813
%      0.596597];

% Include frequency points at extremes, discard later
nfpts = nbands+2*broaden;

if strcmp(fbtype, 'bark')
  bandcfhz = bark2hz(linspace(0, hz2bark(fmax), nfpts));
elseif strcmp(fbtype, 'mel')
  bandcfhz = mel2hz(linspace(0, hz2mel(fmax), nfpts));
elseif strcmp(fbtype, 'htkmel') || strcmp(fbtype, 'fcmel')
  bandcfhz = mel2hz(linspace(0, hz2mel(fmax,1), nfpts),1);
else
  disp(['unknown fbtype', fbtype]);
  error;
end

% Remove extremal bands (the ones that will be duplicated)
bandcfhz = bandcfhz((1+broaden):(nfpts-broaden));

% Hynek's magic equal-loudness-curve formula
fsq = bandcfhz.^2;
ftmp = fsq + 1.6e5;
eql = ((fsq./ftmp).^2) .* ((fsq + 1.44e6)./(fsq + 9.61e6));

% weight the critical bands
z = repmat(eql',1,nframes).*x;

% cube root compress
z = z .^ (.33);

% replicate first and last band (because they are unreliable as calculated)
if (broaden)
  y = z([1,1:nbands,nbands],:);
else
  y = z([2,2:(nbands-1),nbands-1],:);
end
%y = z([1,1:nbands-2,nbands-2],:);

