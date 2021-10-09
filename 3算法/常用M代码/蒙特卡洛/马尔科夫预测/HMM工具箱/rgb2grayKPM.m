function g = rgb2grayKPM(rgb)
% function g = rgb2grayKPM(rgb)
% rgb2grayKPM Like the built-in function, but if r is already gray, does not cause an error

[nr nc ncolors] = size(rgb);
if ncolors > 1
  g = rgb2gray(rgb);
else
  g = rgb;
end

