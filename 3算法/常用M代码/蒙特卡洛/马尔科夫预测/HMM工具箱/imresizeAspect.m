function img = imresizeAspect(img, maxSize)
% function img = imresizeAspect(img, maxSize)
% If image is larger than max size, reduce size, preserving aspect ratio of input.
%
% If size(input) = [y x] and maxSize = [yy xx],
% then size(output) is given by the following (where a=y/x)
%  if y<yy & x<xx  then [y x] 
%  else if a<1 then [a*xx xx] 
%  else [yy yy/a] 

% For why we use bilinear,
% See http://nickyguides.digital-digest.com/bilinear-vs-bicubic.htm

if isempty(maxSize), return; end

[y x c] = size(img);
a= y/x;
yy = maxSize(1); xx = maxSize(2); 
if y <= yy & x <= xx
  % no-op
else
  if a < 1
    img = imresize(img, ceil([a*xx xx]), 'bilinear');
  else
    img = imresize(img, ceil([yy yy/a]), 'bilinear');
  end
  fprintf('resizing from %dx%d to %dx%d\n', y, x, size(img,1), size(img,2));
end


%test
if 0
  maxSize = [240 320];
  %img = imread('C:\Images\Wearables\web_static_office\8.jpg'); 
  %img = imread('C:\Images\Wearables\web_static_office\billandkirsten.jpg'); 
  %img = imread('C:\Images\Wearables\web_static_street_april\p5.jpg'); 
  img = imread('C:\Images\Wearables\Database_static_street\art11.jpg'); 
  img2 = imresizeAspect(img, maxSize);
  figure(1); clf; imshow(img)
  figure(2); clf; imshow(img2)
  fprintf('%dx%d (%5.3f) to %dx%d (%5.3f)\n', ...
	  size(img,1), size(img,2), size(img,1)/size(img,2), ...
	  size(img2,1), size(img2,2), size(img2,1)/size(img2,2));
end
