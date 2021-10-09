function h = draw_circle(x, r, outline_color, fill_color)
% draw filled circles at centers x with radii r.
% x is a matrix of columns.  r is a row vector.

n = 40;					% resolution
radians = [0:(2*pi)/(n-1):2*pi];
unitC = [sin(radians); cos(radians)];

% extend r if necessary
if length(r) < cols(x)
  r = [r repmat(r(length(r)), 1, cols(x)-length(r))];
end

h = [];
% hold is needed for fill()
held = ishold;
hold on
for i=1:cols(x)
  y = unitC*r(i) + repmat(x(:, i), 1, n);
  if nargin < 4
    h = [h line(y(1,:), y(2,:), 'Color', outline_color)];
  else
    h = [h fill(y(1,:), y(2,:), fill_color, 'EdgeColor', outline_color)];
  end
end
if ~held
  hold off
end
