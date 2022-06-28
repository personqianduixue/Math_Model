%
% This is the main script to finds a (near) optimal solution to the Traveling
% Salesman Problem (TSP), by setting up a Simulated Annealing (SA) to search 
% for the shortest route (least distance for the salesman to travel to each 
% city exactly once and return to the starting city).
%

clear;clc;

load china; % geographic information
plotcities(province, border, city); % draw the map of China

numberofcities = length(city);      % number of cities
% distance matrix: dis(i,j) is the distance between city i and j.
dis = distancematrix(city);   

global h;
temperature = 1000;                 % Initialize the temperature.
cooling_rate = 0.94;                % cooling rate
iterations = 1;                     % Initialize the iteration number.

% Initialize random number generator with "seed". 
rand('seed',0);                    

% Initialize the route by generate a sequence of random
route = randperm(numberofcities);
% This is objective function, the total distance for the routes.
previous_distance = totaldistance(route,dis);

% This is a flag used to cool the current temperature after 100 iterations
temperature_iterations = 1;
% This is a flag used to plot the current route after 200 iterations
plot_iterations = 1;

% plot the current route
plotroute(city, route, previous_distance, temperature);

while 1.0 < temperature
    % generate randomly a neighbouring solution
    temp_route = perturb(route,'reverse');
    % compute total distance of the temp_route
    current_distance = totaldistance(temp_route, dis);
    % compute change of distance
    diff = current_distance - previous_distance;
    
    % Metropolis Algorithm
    if (diff < 0) || (rand < exp(-diff/(temperature)))
        route = temp_route;         %accept new route
        previous_distance = current_distance;
        
        % update iterations
        temperature_iterations = temperature_iterations + 1;
        plot_iterations = plot_iterations + 1;
        iterations = iterations + 1;
    end
    
    % reduce the temperature every 100 iterations
    if temperature_iterations >= 100
       temperature = cooling_rate*temperature;
       temperature_iterations = 0;
    end
    
    %  plot the current route every 200 iterations
    if plot_iterations >= 200
       plotroute(city, route, previous_distance, temperature);
       plot_iterations = 0;
    end
end

% plot and output final solution
plotroute(city, route, previous_distance, temperature);
% sth. wrong with function fpdfprinter
fpdfprinter('Final Solution')
