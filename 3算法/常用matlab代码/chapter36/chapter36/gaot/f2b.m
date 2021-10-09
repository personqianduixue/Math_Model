function [bval] = f2b(fval,bounds,bits)
% function [bval] = f2b(fval,bounds,bits)
%
% Return the binary representation of the float number fval.
%
% fval   - the float representation of the number
% bval   - the binary representation of the number
% bounds - the bounds on the variables
% bits   - the number of bits to represent each variable

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

scale=(2.^bits-1)./ (bounds(:,2)-bounds(:,1))'; %The range of the variables
numV=size(bounds,1);
cs=[0 cumsum(bits)];
bval=[];
for i=1:numV
  fval(i)=(fval(i)-bounds(i,1)) * scale(i);
  bval=[bval rem(floor(fval(i)*pow2(1-bits(i):0)),2)];
end