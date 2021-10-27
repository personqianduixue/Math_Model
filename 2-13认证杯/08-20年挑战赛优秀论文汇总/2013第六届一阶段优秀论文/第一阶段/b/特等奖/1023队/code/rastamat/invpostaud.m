function [x,eql] = invpostaud(y,fmax,fbtype,broaden)
%x = postaud(y,fmax,fbtype)
%
% invert the effects of postaud (loudness equalization and cube
% root compression)
% y = postaud output
% x = reconstructed critical band filters
% rows = critical bands
% cols = frames

if nargin < 3
  fbtype = 'bark';
end
if nargin < 4
  % By default, don't add extra flanking bands
  broaden = 0;
end

[nbands,nframes] = size(y);

% equal loundness weights stolen from rasta code
%eql = [0.000479 0.005949 0.021117 0.044806 0.073345 0.104417 0.137717 ...
%      0.174255 0.215590 0.263260 0.318302 0.380844 0.449798 0.522813 0.596597];

if strcmp(fbtype, 'bark')
  bandcfhz = bark2hz(linspace(0, hz2bark(fmax), nbands));
elseif strcmp(fbtype, 'mel')
  bandcfhz = mel2hz(linspace(0, hz2mel(fmax), nbands));
elseif strcmp(fbtype, 'htkmel') || strcmp(fbtype, 'fcmel')
  bandcfhz = mel2hz(linspace(0, hz2mel(fmax,1), nbands),1);
else
  disp(['unknown fbtype', fbtype]);
  error;
end

% Remove extremal bands (the ones that got duplicated)
bandcfhz = bandcfhz((1+broaden):(nbands-broaden));

% Hynek's magic equal-loudness-curve formula
fsq = bandcfhz.^2;
ftmp = fsq + 1.6e5;
eql = ((fsq./ftmp).^2) .* ((fsq + 1.44e6)./(fsq + 9.61e6));


% cube expand
x = y .^ (1/.33);

%% squash the zero in the eql curve
if eql(1) == 0  % or maybe always
  eql(1) = eql(2);
  eql(end) = eql(end-1);
end

% weight the critical bands
x = x((1+broaden):(nbands-broaden),:)./repmat(eql',1,nframes);

