function [bits]=calcbits(bounds,precision)
% function [bits]=calcbits(bounds,precision)
%
% Determine the number of bits to represent a float number to the precision
% provided.
%
% bits      - the number of bits required per variable
% bounds    - the bounds on the variables
% precision - the least difference to distinguish two numbers

% Binary and Real-Valued Simulation Evolution for Matlab 
% Copyright (C) 1996 C.R. Houck, J.A. Joines, M.G. Kay 
%
% C.R. Houck, J.Joines, and M.Kay. A genetic algorithm for function
% optimization: A Matlab implementation. ACM Transactions on Mathmatical
% Software, Submitted 1996.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 1, or (at your option)
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. A copy of the GNU 
% General Public License can be obtained from the 
% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

bits=ceil(log2((bounds(:,2)-bounds(:,1))' ./ precision));
% bits=ceil(log( (bounds(:,2)-bounds(:,1))' .* 10.^precision+1) ./ log(2));