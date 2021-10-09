function [val] = coranaEval(sol)
% function [val] = coranaEval(sol)
%
% Determines the value of the Corana function at point sol.
% This function is used in gademo2.
% 
% val - the value of the Corana function at point sol
% sol - the location to evaluate the Corana function

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

numv = size(sol,2);
x=sol(1:numv);
d0=[1 1000 10 100 1 10 100 1000 1 10];
d=d0(1:numv);
c=0.15;
s=.2*ones(1,numv);
t=0.05*ones(1,numv);
bk = s.*(round(x./s));
dev= (abs(bk-x)<t) & (bk~=0);
% z=c*((bk+sign(bk).*t).^2).*d;
% y=x.^2.*d;
% val = sum((dev.*z) + ((~dev).*y));
if all(dev)
  val = sum(c*((bk+sign(bk).*t).^2).*d);
else
  val=sum(x.^2.*d);
end