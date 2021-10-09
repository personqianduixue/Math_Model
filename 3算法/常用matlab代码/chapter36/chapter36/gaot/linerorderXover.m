function [c1,c2]=lox(p1,p2,bounds,genInfo,ops)
% Linearorder crossover takes two parents P1,P2 and performs linear order
% crossover for permutation strings.  
%
% function [c1,c2] = linearOrderXover(p1,p2,bounds,Ops)
% p1      - the first parent ( [solution string function value] )
% p2      - the second parent ( [solution string function value] )
% bounds  - the bounds matrix for the solution space
% Ops     - Options matrix for simple crossover [gen #SimpXovers].

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
sz=size(p1,2)-1;
c1=p1(1:sz);%zeros(1,sz);
c2=p2(1:sz);%zeros(1,sz);
cut1=round(rand*(sz-1)+1.5);
cut2=round(rand*(sz-1)+1.5);
while cut2 == cut1
   cut2 = round(rand*sz + 0.5);
end
if cut1 > cut2
   t = cut1; cut1 = cut2; cut2 = t;
end
for i=cut1:cut2
  c1=strrep(c1,p2(i),-1);
  c2=strrep(c2,p1(i),-1);
end
g1=find(c1>-1);
g2=find(c2>-1);
c1=[c1(g1(1:(cut1-1))) p2(cut1:cut2) c1(g1(cut1:end)) p1(end)];
c2=[c2(g2(1:(cut1-1))) p1(cut1:cut2) c2(g2(cut1:end)) p2(end)];

