function [x, y] = minperpoly(B, cellsize)
%MINPERPOLY Computes the minimum perimeter polygon.
%   [X, Y] = MINPERPOLY(F, CELLSIZE) computes the vertices in [X, Y]
%   of the minimum perimeter polygon of a single binary region or
%   boundary in image B. The procedure is based on Slansky's
%   shrinking rubber band approach. Parameter CELLSIZE determines the
%   size of the square cells that enclose the boundary of the region
%   in B. CELLSIZE must be a nonzero integer greater than 1.
%   
%   The algorithm is applicable only to boundaries that are not
%   self-intersecting and that do not have one-pixel-thick
%   protrusions. 

%   Copyright 2002-2004 R. C. Gonzalez, R. E. Woods, & S. L. Eddins
%   Digital Image Processing Using MATLAB, Prentice-Hall, 2004
%   $Revision: 1.6 $  $Date: 2003/11/21 14:41:39 $

if cellsize <= 1
   error('CELLSIZE must be an integer > 1.'); 
end

% Fill B in case the input was provided as a boundary. Later 
% the boundary will be extracted with 4-connectivity, which 
% is required by the algorithm. The use of bwperim assures 
% that 4-connectivity is preserved at this point.               
B = imfill(B, 'holes');
B = bwperim(B);               
[M, N] = size(B);

% Increase image size so that the image is of size K-by-K
% with (a) K >= max(M,N) and (b)  K/cellsize = a power of 2.
K = nextpow2(max(M, N)/cellsize);
K = (2^K)*cellsize;
    
% Increase image size to nearest integer power of 2, by 
% appending zeros to the end of the image. This will allow 
% quadtree  decompositions as small as cells of size 2-by-2, 
% which is the smallest allowed value of cellsize.
M = K - M;
N = K - N;
B = padarray(B, [M N], 'post'); % f is now of size K-by-K

% Quadtree decomposition.
Q = qtdecomp(B, 0, cellsize); 

% Get all the subimages of size cellsize-by-cellsize.
[vals, r, c] = qtgetblk(B, Q, cellsize);

% Get all the subimages that contain at least one black 
% pixel. These are the cells of the wall enclosing the boundary.
I = find(sum(sum(vals(:, :, :)) >= 1));
x = r(I);
y = c(I);

% [x', y'] is a length(I)-by-2 array.  Each member of this array is
% the left, top corner of a black cell of size cellsize-by-cellsize.
% Fill the cells with black to form a closed border of black cells
% around interior points. These cells are the cellular complex.
for k = 1:length(I)
   B(x(k):x(k) + cellsize-1, y(k):y(k) + cellsize-1) = 1;
end
    
BF = imfill(B, 'holes');

% Extract the points interior to the black border. This is the region
% of interest around which the MPP will be found. 
B = BF & (~B);
    
% Extract the 4-connected boundary.
B = boundaries(B, 4, 'cw');
% Find the largest one in case of parasitic regions.
J = cellfun('length', B);
I = find(J == max(J));
B = B{I(1)};

% Function boundaries outputs the last coordinate pair equal to the
% first.  Delete it. 
B = B(1:end-1,:);
                  
% Obtain the xy coordinates of the boundary.
x = B(:, 1);
y = B(:, 2);

% Find the smallest x-coordinate and corresponding
% smallest y-coordinate.  
cx = find(x == min(x));
cy = find(y == min(y(cx)));

% The cell with top leftmost corner at (x1, y1) below is the first
% point considered by the algorithm.  The remaining points are
% visited in the clockwise direction starting at (x1, y1). 
x1 = x(cx(1));
y1 = y(cy(1));

% Scroll data so that the first point is (x1, y1).
I = find(x == x1 & y == y1);
x = circshift(x, [-(I - 1), 0]);
y = circshift(y, [-(I - 1), 0]);

% The same shift applies to B.
B = circshift(B, [-(I - 1), 0]);

% Get the Freeman chain code.  The first row of B is the required
% starting point. The first element of the code is the transition
% between the 1st and 2nd element of B, the second element of 
% the code is the transition between the 2nd and 3rd elements of B,
% and so on.  The last element of the code is the transition between
% the last and 1st elements of B. The elements of B form a cw
% sequence (see above), so we use 'same' for the direction in
% function fchcode. 
code = fchcode(B, 4, 'same'); 
code = code.fcc;

% Follow the code sequence to extract the Black Dots, BD, (convex
% corners) and White Dots, WD, (concave corners). The transitions are
% as follows: 0-to-1=WD; 0-to-3=BD; 1-to-0=BD; 1-to-2=WD; 2-to-1=BD;
% 2-to-3=WD; 3-to-0=WD; 3-to-2=dot.  The formula t = 2*first - second
% gives the following unique values for these transitions: -1, -3, 2,
% 0, 3, 1, 6, 4.  These are applicable to travel in the cw direction. 
% The WD's are displaced one-half a diagonal from the BD's to form
% the half-cell expansion required in the algorithm. 

% Vertices will be computed as array "vertices" of dimension nv-by-3,
% where nv is the number of vertices. The first two elements of any
% row of array vertices are the (x,y) coordinates of the vertex
% corresponding to that row, and the third element is 1 if the
% vertex is convex (BD) or 2 if it is concave (WD). The first vertex
% is known to be convex, so it is black. 
vertices = [x1, y1, 1];
n = 1;
k = 1;
for k = 2:length(code)
   if code(k - 1) ~= code(k)
      n = n + 1;
      t = 2*code(k-1) - code(k); % t = value of formula.
      if t == -3 | t == 2 | t == 3 | t == 4 % Convex: Black Dots.
         vertices(n, 1:3) = [x(k), y(k), 1];
      elseif t == -1 | t == 0 | t == 1 | t == 6 % Concave: White Dots.
         if t == -1
            vertices(n, 1:3) = [x(k) - cellsize, y(k) - cellsize,2];
         elseif t==0
            vertices(n, 1:3) = [x(k) + cellsize, y(k) - cellsize,2];
         elseif t==1
            vertices(n, 1:3) = [x(k) + cellsize, y(k) + cellsize,2];
         else
            vertices(n, 1:3) = [x(k) - cellsize, y(k) + cellsize,2];
         end
      else
         % Nothing to do here.
      end
   end
end

% The rest of minperpoly.m processes the vertices to
% arrive at the MPP.

flag = 1;
while flag
   % Determine which vertices lie on or inside the
   % polygon whose vertices are the Black Dots. Delete all 
   % other points.
   I = find(vertices(:, 3) == 1);
   xv = vertices(I, 1); % Coordinates of the Black Dots.
   yv = vertices(I, 2);
   X = vertices(:, 1); % Coordinates of all vertices.
   Y = vertices(:, 2);
   IN = inpolygon(X, Y, xv, yv);
   I = find(IN ~= 0);        
   vertices = vertices(I, :);
   
   % Now check for any Black Dots that may have been turned into
   % concave vertices after the previous deletion step. Delete
   % any such Black Dots and recompute the polygon as in the
   % previous section of code. When no more changes occur, set
   % flag to 0, which causes the loop to terminate. 
   x = vertices(:, 1);
   y = vertices(:, 2);
   angles = polyangles(x, y); % Find all the interior angles.
   I = find(angles > 180 & vertices(:, 3) == 1);  
   if isempty(I)
      flag = 0;
   else
      J = 1:length(vertices);
      for k = 1:length(I)
         K = find(J ~= I(k));
         J = J(K);
      end
      vertices = vertices(J, :);
   end
end

% Final pass to delete the vertices with angles of 180 degrees.
x = vertices(:, 1);
y = vertices(:, 2);
angles = polyangles(x, y);
I = find(angles ~= 180);

% Vertices of the MPP:
x = vertices(I, 1);
y = vertices(I, 2);
