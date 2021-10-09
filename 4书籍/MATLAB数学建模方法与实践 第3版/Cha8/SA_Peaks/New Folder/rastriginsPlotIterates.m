function state = rastriginsPlotIterates(options,state,flag)
% Helper function for rastrigins optimization

%  Copyright (c) 2010, The MathWorks, Inc.
%  All rights reserved.

% Plot each individual using a small black star
plot(state.Population(:,1),state.Population(:,2),'k*');
hold on;
% Plot underlying contour plot of surface
rastriginsfcnCont()
axis([-5,5,-5,5]);
hold off
pause(0.3)