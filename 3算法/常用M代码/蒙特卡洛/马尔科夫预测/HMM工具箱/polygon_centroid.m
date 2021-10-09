function [x0,y0] = centroid(x,y)
% CENTROID Center of mass of a polygon.
%	[X0,Y0] = CENTROID(X,Y) Calculates centroid 
%	(center of mass) of planar polygon with vertices 
%	coordinates X, Y.
%	Z0 = CENTROID(X+i*Y) returns Z0=X0+i*Y0 the same
%	as CENTROID(X,Y).

%  Copyright (c) 1995 by Kirill K. Pankratov,
%       kirill@plume.mit.edu.
%       06/01/95, 06/07/95

% Algorithm:
%  X0 = Int{x*ds}/Int{ds}, where ds - area element
%  so that Int{ds} is total area of a polygon.
%    Using Green's theorem the area integral can be 
%  reduced to a contour integral:
%  Int{x*ds} = -Int{x^2*dy}, Int{ds} = Int{x*dy} along
%  the perimeter of a polygon.
%    For a polygon as a sequence of line segments
%  this can be reduced exactly to a sum:
%  Int{x^2*dy} = Sum{ (x_{i}^2+x_{i+1}^2+x_{i}*x_{i+1})*
%  (y_{i+1}-y_{i})}/3;
%  Int{x*dy} = Sum{(x_{i}+x_{i+1})(y_{i+1}-y_{i})}/2.
%    Similarly
%  Y0 = Int{y*ds}/Int{ds}, where
%  Int{y*ds} = Int{y^2*dx} = 
%  = Sum{ (y_{i}^2+y_{i+1}^2+y_{i}*y_{i+1})*
%  (x_{i+1}-x_{i})}/3.

 % Handle input ......................
if nargin==0, help centroid, return, end
if nargin==1
  sz = size(x);
  if sz(1)==2      % Matrix 2 by n
    y = x(2,:); x = x(1,:);
  elseif sz(2)==2  % Matrix n by 2
    y = x(:,2); x = x(:,1);
  else
    y = imag(x);
    x = real(x);
  end
end 

 % Make a polygon closed ..............
x = [x(:); x(1)];
y = [y(:); y(1)];

 % Check length .......................
l = length(x);
if length(y)~=l
  error(' Vectors x and y must have the same length')
end

 % X-mean: Int{x^2*dy} ................
del = y(2:l)-y(1:l-1);
v = x(1:l-1).^2+x(2:l).^2+x(1:l-1).*x(2:l);
x0 = v'*del;

 % Y-mean: Int{y^2*dx} ................
del = x(2:l)-x(1:l-1);
v = y(1:l-1).^2+y(2:l).^2+y(1:l-1).*y(2:l);
y0 = v'*del;

 % Calculate area: Int{y*dx} ..........
a = (y(1:l-1)+y(2:l))'*del;
tol= 2*eps;
if abs(a)<tol
  disp(' Warning: area of polygon is close to 0')
  a = a+sign(a)*tol+(~a)*tol;
end
 % Multiplier
a = 1/3/a;

 % Divide by area .....................
x0 = -x0*a;
y0 =  y0*a;

if nargout < 2, x0 = x0+i*y0; end
