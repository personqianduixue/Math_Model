function plotroute(city, route, current_distance, temperature)
% PLOTROUTE
% PLOTROUTE(city, route, current_distance, temperature) plots the route and
% display current temperautre and distance.

global h;
cycle = route([1:end, 1]);
% update route
set(h,'Xdata',[city(cycle).long],'Ydata',[city(cycle).lat]);

% display current temperature and total distance
xlabel(sprintf('T = %6.1f        Total Distance = %6.1f', ...
                    temperature,                  current_distance));
drawnow

