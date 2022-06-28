function B = boundaries(BW, conn, dir)
%BOUNDARIES Trace object boundaries.  
%   B = BOUNDARIES(BW) traces the exterior boundaries of objects in
%   the binary image BW.  B is a P-by-1 cell array, where P is the
%   number of objects in the image. Each cell contains a Q-by-2
%   matrix, each row of which contains the row and column coordinates
%   of a boundary pixel.  Q is the number of boundary pixels for the
%   corresponding object.  Object boundaries are traced in the
%   clockwise direction.
%
%   B = BOUNDARIES(BW, CONN) specifies the connectivity to use when
%   tracing boundaries.  CONN may be either 8 or 4.  The default
%   value for CONN is 8.
%
%   B = BOUNDARIES(BW, CONN, DIR) specifies the direction used for
%   tracing boundaries.  DIR should be either 'cw' (trace boundaries
%   clockwise) or 'ccw' (trace boundaries counterclockwise).  If DIR
%   is omitted BOUNDARIES traces in the clockwise direction.

%   Copyright 2002-2004 R. C. Gonzalez, R. E. Woods, & S. L. Eddins
%   Digital Image Processing Using MATLAB, Prentice-Hall, 2004
%   $Revision: 1.6 $  $Date: 2003/11/21 14:22:07 $

if nargin < 3
   dir = 'cw';
end

if nargin < 2
   conn = 8;
end

L = bwlabel(BW, conn);

% The number of objects is the maximum value of L.  Initialize the
% cell array B so that each cell initially contains a 0-by-2 matrix.
numObjects = max(L(:));
if numObjects > 0
   B = {zeros(0, 2)};
   B = repmat(B, numObjects, 1);
else
   B = {};
end

% Pad label matrix with zeros.  This lets us write the
% boundary-following loop without worrying about going off the edge
% of the image. 
Lp = padarray(L, [1 1], 0, 'both');

% Compute the linear indexing offsets to take us from a pixel to its
% neighbors.  
M = size(Lp, 1);
if conn == 8
   % Order is N NE E SE S SW W NW.
   offsets = [-1, M - 1, M, M + 1, 1, -M + 1, -M, -M-1];
else
   % Order is N E S W.
   offsets = [-1, M, 1, -M];
end

% next_search_direction_lut is a lookup table.  Given the direction
% from pixel k to pixel k+1, what is the direction to start with when
% examining the neighborhood of pixel k+1?
if conn == 8
   next_search_direction_lut = [8 8 2 2 4 4 6 6];
else
   next_search_direction_lut = [4 1 2 3];
end

% next_direction_lut is a lookup table.  Given that we just looked at
% neighbor in a given direction, which neighbor do we look at next? 
if conn == 8
   next_direction_lut = [2 3 4 5 6 7 8 1];
else
   next_direction_lut = [2 3 4 1];
end

% Values used for marking the starting and boundary pixels.
START    = -1;
BOUNDARY = -2;

% Initialize scratch space in which to record the boundary pixels as
% well as follow the boundary.
scratch = zeros(100, 1);

% Find candidate starting locations for boundaries.
[rr, cc] = find((Lp(2:end-1, :) > 0) & (Lp(1:end-2, :) == 0));
rr = rr + 1;

for k = 1:length(rr)
   r = rr(k);
   c = cc(k);
   if (Lp(r,c) > 0) & (Lp(r - 1, c) == 0) & isempty(B{Lp(r, c)})
      % We've found the start of the next boundary.  Compute its
      % linear offset, record which boundary it is, mark it, and
      % initialize the counter for the number of boundary pixels.
      idx = (c-1)*size(Lp, 1) + r;
      which = Lp(idx);
      
      scratch(1) = idx;
      Lp(idx) = START;
      numPixels = 1;
      currentPixel = idx;
      initial_departure_direction = [];
      
      done = 0;
      next_search_direction = 2;
      while ~done
         % Find the next boundary pixel.
         direction = next_search_direction;
         found_next_pixel = 0;
         for k = 1:length(offsets)
            neighbor = currentPixel + offsets(direction);
            if Lp(neighbor) ~= 0
               % Found the next boundary pixel.
               
               if (Lp(currentPixel) == START) & ...
                      isempty(initial_departure_direction)
                  % We are making the initial departure from
                  % the starting pixel.
                  initial_departure_direction = direction;
                  
               elseif (Lp(currentPixel) == START) & ...
                      (initial_departure_direction == direction)
                  % We are about to retrace our path.
                  % That means we're done.
                  done = 1;
                  found_next_pixel = 1;
                  break;
               end
               
               % Take the next step along the boundary.
               next_search_direction = ...
                   next_search_direction_lut(direction);
               found_next_pixel = 1;
               numPixels = numPixels + 1;
               if numPixels > size(scratch, 1)
                  % Double the scratch space.
                  scratch(2*size(scratch, 1)) = 0;
               end
               scratch(numPixels) = neighbor;
               
               if Lp(neighbor) ~= START
                  Lp(neighbor) = BOUNDARY;
               end
               
               currentPixel = neighbor;
               break;
            end
            
            direction = next_direction_lut(direction);
         end
         
         if ~found_next_pixel
            % If there is no next neighbor, the object must just
            % have a single pixel.
            numPixels = 2;
            scratch(2) = scratch(1);
            done = 1;
         end
      end
      
      % Convert linear indices to row-column coordinates and save
      % in the output cell array. 
      [row, col] = ind2sub(size(Lp), scratch(1:numPixels));
      B{which} = [row - 1, col - 1];
   end
end

if strcmp(dir, 'ccw')
   for k = 1:length(B)
      B{k} = B{k}(end:-1:1, :);
   end
end
