function montageKPM2(data)
% data(y,x,b,f) or data(y,x,f)
% can be double - uses imagesc to display, not imshow
% based on imaqmontage

if ndims(data)==3
  nr = size(data,1); nc = size(data,2); Npatches = size(data,3);
  data = reshape(data, [nr nc 1 Npatches]);
else
  nr = size(data,1); nc = size(data,2); nbands = size(data,3); Npatches = size(data,4);
end
nativeVal = data(1, 1);
dataOrig = data;

%put a black border around them for display purposes
border = 5;
bgColor = min(data(:));
data = bgColor*ones(nr+2*border, nc+2*border, 1, Npatches, class(data));
data(border+1:end-border, border+1:end-border, :, :) = dataOrig;

[width, height, bands, nFrames] = size(data);

% Determine the number of axis rows and columns.
axCols = sqrt(nFrames);
if (axCols<1)
    % In case we have a slim image.
    axCols = 1;
end
axRows = nFrames/axCols;
if (ceil(axCols)-axCols) < (ceil(axRows)-axRows),
    axCols = ceil(axCols);
    axRows = ceil(nFrames/axCols);
else
    axRows = ceil(axRows); 
    axCols = ceil(nFrames/axRows);
end

% Size the storage to hold all frames.
storage = repmat(nativeVal, [axRows*width, axCols*height, bands, 1]);

% Fill the storage up with data pixels.
rows = 1:width; 
cols = 1:height;
for i=0:axRows-1,
  for j=0:axCols-1,
    k = j+i*axCols+1;
    if k<=nFrames,
      storage(rows+i*width, cols+j*height, :) = data(:,:,:,k);
    else
      break;
    end
  end
end


% Display the tiled frames nicely and 
% pop the window forward.
im = imagesc(storage);

ax = get(im, 'Parent');
fig = get(ax, 'Parent');
set(ax, 'XTick', [], 'YTick', [])
figure(fig)

% If working with single band images, update the colormap.
if 0 % bands==1,
    colormap(gray);
end
