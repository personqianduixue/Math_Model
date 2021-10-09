function [is,S] = isintpl(x1,y1,x2,y2)
% ISINTPL Check for intersection of polygons.
%	[IS,S] = ISINTPL(X1,Y1,X2,Y2) Accepts coordinates
%	X1,Y1 and X2, Y2 of two polygons. Returns scalar
%	IS equal to 1 if these polygons intersect each other
%	and 0 if they do not.
%	Also returns Boolean matrix S of the size length(X1)
%	by length(X2) so that {ij} element of which is 1 if 
%	line segments i to i+1 of the first polygon and 
%	j to j+1 of the second polygon intersect each other,
%	0 if they don't and .5 if they "touch" each other.

%  Copyright (c) 1995 by Kirill K. Pankratov,
%       kirill@plume.mit.edu.
%       06/20/95, 08/25/95


 % Handle input ...................................
if nargin==0, help isintpl, return, end
if nargin<4
  error(' Not enough input arguments ')
end

 % Make column vectors and check sizes ............
x1 = x1(:); y1 = y1(:);
x2 = x2(:); y2 = y2(:);
l1 = length(x1);
l2 = length(x2);
if length(y1)~=l1 | length(y2)~=l2
  error('(X1,Y1) and (X2,Y2) must pair-wise have the same length.')
end

 % Quick exit if empty
if l1<1 | l2<1, is = []; S = []; return, end

 % Check if their ranges are intersecting .........
lim1 = [min(x1) max(x1)]';
lim2 = [min(x2) max(x2)]';
isx = interval(lim1,lim2);  % X-ranges
lim1 = [min(y1) max(y1)]';
lim2 = [min(y2) max(y2)]';
isy = interval(lim1,lim2);  % Y-ranges
is = isx & isy;
S = zeros(l2,l1);

if ~is, return, end  % Early exit if disparate limits

 % Indexing .......................................
[i11,i12] = meshgrid(1:l1,1:l2);
[i21,i22] = meshgrid([2:l1 1],[2:l2 1]);
i11 = i11(:); i12 = i12(:);
i21 = i21(:); i22 = i22(:);

 % Calculate matrix of intersections ..............
S(:) = iscross([x1(i11) x1(i21)]',[y1(i11) y1(i21)]',...
               [x2(i12) x2(i22)]',[y2(i12) y2(i22)]')';

S = S';
is  = any(any(S));

