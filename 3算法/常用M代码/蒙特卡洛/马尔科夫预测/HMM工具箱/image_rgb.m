function image_rgb(M)
% Show a matrix of integers as a color image.
% This is like imagesc, except we know what the mapping is from integer to color.
% If entries of M contain integers in {1,2,3}, we map
% this to red/green/blue 

cmap = [1 0 0; % red
	0 1 0; % green
	0 0 1; % blue
	127/255 1 212/255]; % aquamarine
image(M)
set(gcf,'colormap', cmap);

if 1
  % make dummy handles, one per object type, for the legend
  str = {};
  for i=1:size(cmap,1)
    dummy_handle(i) = line([0 0.1], [0 0.1]);
    set(dummy_handle(i), 'color', cmap(i,:));
    set(dummy_handle(i), 'linewidth', 2);
    str{i} = num2str(i);
  end
  legend(dummy_handle, str, -1);
end

if 0
[nrows ncols] = size(M);
img = zeros(nrows, ncols, 3);
for r=1:nrows
  for c=1:ncols
    q = M(r,c);
    img(r,c,q) = 1;
  end
end
image(img)
end
