% NONMAXSUP - Non-maximal Suppression
%
% Usage:  cim = nonmaxsup(im, radius)
%
% Arguments:   
%            im     - image to be processed.
%            radius - radius of region considered in non-maximal
%                     suppression (optional). Typical values to use might
%                     be 1-3.  Default is 1.
%
% Returns:
%            cim    - image with pixels that are not maximal within a 
%                     square neighborhood zeroed out.

% Copyright (C) 2002 Mark A. Paskin
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
% USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cim = nonmaxsup(m, radius)
  if (nargin == 1) radius = 1; end
  % Extract local maxima by performing a grey scale morphological
  % dilation and then finding points in the corner strength image that
  % match the dilated image and are also greater than the threshold.
  sze = 2 * radius + 1;                   % Size of mask.
  mx = ordfilt2(m, sze^2, ones(sze));   % Grey-scale dilate.
  cim = sparse(m .* (m == mx));


