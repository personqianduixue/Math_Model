% GADEMO2 Use of the Genetic Optimization Toolbox

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

clf;
figure(gcf);
echo on
clc
% This demonstration show the use of the genetic toolbox to optimize a
% multi-dimensional non-convex function.
% The function is coded in the coranaEval.m file

pause %Strike any key to examine coranaEval
clc

type coranaEval.m

pause %Strike any key to continue
clc
%This function is basically a n dimensional parabola with rectangular
%pockets removed. Let's take a look at the function in 2-dimensions
%This may take a couple of minutes...
echo off    
i=0;
a=-0.5:0.02:0.5;
for x=a
  i=i+1; j=0;
  for y=a
    j=j+1;
    z(i,j)=coranaEval([x y]);
  end
end
echo on
%Done!

%First let's look at it in each dimension independently
clf
plot(z(:,1)) %Plot a slice of the function in x max 250.25
%Notice the range is [250.0-250.25]
pause %Strike any key to continue
clf
plot(z(1,:)) %Plot a slice of the function in y 
%Notice the range is [0-250]
pause %Strike any key to continue
mesh(a,a,z);
view(30,60);
grid;
%Remember the deviation in y is 1000 times that of x.
pause %Strike any key to continue
clc
%Lets minimize this function in 4 dimensions between [-10,000 10,000].
%The ga is set up to maximize only.  Minimization of f(x) is equivalent to
%maximizing -f(x), so we use the negative of the Corana function.
type coranaMin.m

pause %Any key to continue
clc

%First set up the bounds
bounds = ones(4,1)*[-10000 10000];

%Now lets optimize
%This may take some time...
[x,endPop,bestSols,trace]=ga(bounds,'coranaMin');
%Done!

pause %Any key to continue
clc
%The first return is the optimal [x1 x2 x3 x4 val]
x

%Lets take a look at the performance of the ga during the run
plot(trace(:,1),trace(:,3),'y-')
hold on
plot(trace(:,1),trace(:,2),'r-')
xlabel('Generation'); ylabel('Fittness');
%The red line is a track of the best solution, the yellow is a track of the
%average of the population

pause %Any key to continue
clc

%End of gademo2
