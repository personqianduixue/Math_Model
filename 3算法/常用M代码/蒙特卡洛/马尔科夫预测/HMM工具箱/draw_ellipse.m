function h = draw_ellipse(x, c, outline_color, fill_color)
% DRAW_ELLIPSE(x, c, outline_color, fill_color)
%   Draws ellipses at centers x with covariance matrix c.
%   x is a matrix of columns.  c is a positive definite matrix.
%   outline_color and fill_color are optional.

n = 40;					% resolution
radians = [0:(2*pi)/(n-1):2*pi];
unitC = [sin(radians); cos(radians)];
r = chol(c)';

if nargin < 3
  outline_color = 'g';
end

h = [];
for i=1:cols(x)
  y = r*unitC + repmat(x(:, i), 1, n);
  if nargin < 4
    h = [h line(y(1,:), y(2,:), 'Color', outline_color)];
  else
    h = [h fill(y(1,:), y(2,:), fill_color, 'EdgeColor', outline_color)];
  end
end
