function h = montageKPM(arg)
% montageKPM is like the built-in montage, but assumes input is MxNxK or filenames
%
% Converts patches (y,x,i) into patches(y,x,1,i)
% Also, adds a black border aroudn them

if iscell(arg)
  h= montageFilenames(arg);
else
  nr = size(arg,1); nc = size(arg,2); Npatches = size(arg,3);
  patchesColor = reshape(arg, [nr nc 1 Npatches]);
  patchesColor = patchesColor ./ max(patchesColor(:));
  
  if 1
    %put a black border around them for display purposes
    border = 5;
    bgColor = ones(1,1,class(patchesColor));
    patchesColorBig = bgColor*ones(nr+2*border, nc+2*border, 1, Npatches, class(patchesColor));
    %patchesColorBig = zeros(nr+2*border, nc+2*border, 1, Npatches, class(patchesColor));
    patchesColorBig(border+1:end-border, border+1:end-border, :, :) = patchesColor;
  else
    patchesColorBig = patchesColor;
  end
  montage(patchesColorBig)

end

%%%%%%%%%%%%%

function h = montageFilenames(filenames)

%[nRows, nCols, nBands, nFrames] = size(a);

% Estimate nMontageColumns and nMontageRows given the desired ratio of
% Columns to Rows to be one (square montage).
aspectRatio = 1; 
nMontageCols = sqrt(aspectRatio * nRows * nFrames / nCols);

% Make sure montage rows and columns are integers. The order in the adjustment
% matters because the montage image is created horizontally across columns.
nMontageCols = ceil(nMontageCols); 
nMontageRows = ceil(nFrames / nMontageCols);

% Create the montage image.
b = a(1,1); % to inherit type 
b(1,1) = 0; % from a
b = repmat(b, [nMontageRows*nRows, nMontageCols*nCols, nBands, 1]);

rows = 1 : nRows; 
cols = 1 : nCols;

for i = 0:nMontageRows-1
  for j = 0:nMontageCols-1,
    k = j + i * nMontageCols + 1;
    if k <= nFrames
      b(rows + i * nRows, cols + j * nCols, :) = a(:,:,:,k);
    else
      break;
    end
  end
end

if isempty(cm)
  hh = imshow(b);
else
  hh = imshow(b,cm);
end

if nargout > 0
    h = hh;
end

%--------------------------------------------------------------
%Parse Inputs Function

function [I,map] = parse_inputs(varargin)

% initialize variables
map = [];

iptchecknargin(1,2,nargin,mfilename);
iptcheckinput(varargin{1},{'uint8' 'double' 'uint16' 'logical' 'single' ...
                    'int16'},{},mfilename, 'I, BW, or RGB',1);
I = varargin{1};

if nargin==2
  if isa(I,'int16')
    eid = sprintf('Images:%s:invalidIndexedImage',mfilename);
    msg1 = 'An indexed image can be uint8, uint16, double, single, or ';
    msg2 = 'logical.';
    error(eid,'%s %s',msg1, msg2);
  end
  map = varargin{2};
  iptcheckinput(map,{'double'},{},mfilename,'MAP',1);
  if ((size(map,1) == 1) && (prod(map) == numel(I)))
    % MONTAGE(D,[M N P]) OBSOLETE
    eid = sprintf('Images:%s:obsoleteSyntax',mfilename);
    msg1 = 'MONTAGE(D,[M N P]) is an obsolete syntax.';
    msg2 = 'Use multidimensional arrays to represent multiframe images.';
    error(eid,'%s\n%s',msg1,msg2);    
  end
end
