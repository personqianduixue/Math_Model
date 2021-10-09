function h = draw_ellipse_axes(x, c, linespec)
% DRAW_ELLIPSE_AXES(x, c, linespec)
%   Draws the major and minor axes of ellipses.
%   Ellipses are centered at x with covariance matrix c.
%   x is a matrix of columns.  c is a positive definite matrix.
%   linespec is optional.

[v,e] = eig(c);
v = v*sqrt(e);

h = [];
for j = 1:cols(v)
  x1 = repmat(x(1,:),2,1) + repmat([-1;1]*v(1,j),1,cols(x));
  x2 = repmat(x(2,:),2,1) + repmat([-1;1]*v(2,j),1,cols(x));
  h = [h line(x1,x2)];
end
if nargin > 2
  set_linespec(h,linespec);
end
