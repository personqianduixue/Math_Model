function  a = polygon_area(x,y)
% AREA  Area of a planar polygon.
%	AREA(X,Y) Calculates the area of a 2-dimensional
%	polygon formed by vertices with coordinate vectors
%	X and Y. The result is direction-sensitive: the
%	area is positive if the bounding contour is counter-
%	clockwise and negative if it is clockwise.
%
%	See also TRAPZ.

%  Copyright (c) 1995 by Kirill K. Pankratov,
%	kirill@plume.mit.edu.
%	04/20/94, 05/20/95  

 % Make polygon closed .............
x = [x(:); x(1)];
y = [y(:); y(1)];

 % Calculate contour integral Int -y*dx  (same as Int x*dy).
lx = length(x);
a = -(x(2:lx)-x(1:lx-1))'*(y(1:lx-1)+y(2:lx))/2;
a = abs(a);
