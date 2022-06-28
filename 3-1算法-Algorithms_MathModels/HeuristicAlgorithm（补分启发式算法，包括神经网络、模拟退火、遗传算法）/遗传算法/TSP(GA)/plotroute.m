function plotroute(city, route, distance, generation)
% PLOTROUTE
% PLOTROUTE(city, route, distance, generation) plots the route and
% display current generation and distance.

global h;
cycle = route([1:end, 1]);
% update route
set(h,'Xdata',[city(cycle).long],'Ydata',[city(cycle).lat]);

% display current generation and total distance
xlabel(sprintf('generation = %5i        Total Distance = %6.1f', ...
                       generation,                  distance));
drawnow

