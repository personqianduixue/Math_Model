%
% This is the main script to finds a (near) optimal solution to the Traveling
% Salesman Problem (TSP), by setting up a Genetic Algorithm (GA) to search 
% for the shortest route (least distance for the salesman to travel to each 
% city exactly once and return to the starting city).
%

clear;clc;

load china;                         % geographic information
plotcities(province, border, city); % draw the map of China

numberofcities = length(city);      % number of cities
% distance matrix: dis(i,j) is the distance between city i and j.
dis = distancematrix(city);   

popSize = 100;                      % population size
max_generation = 1000;              % number of generation
probmutation = 0.16;                % probability of mutation

% Initialize random number generator with "seed". 
rand('seed',103);
% Initialize the pop: start from random routes
pop = zeros(popSize,numberofcities); 
for i=1:popSize
    pop(i,:)=randperm(numberofcities);
end


for generation = 1:max_generation   % generations loop
    
    % evaluate: compute fitness(1/totaldistance) for each individuals in pop
    popDist = totaldistance(pop,dis);
    fitness = 1./popDist;
   
    % find the best route & distance
    [mindist, bestID] = min(popDist); 
    bestPop = pop(bestID, :);       % best route
    
    % update best route on figure:
    if mod(generation,10)==0
        plotroute(city, bestPop, mindist, generation)
    end
    
    % select (competition / roulette)
    pop = select(pop, fitness, popSize,'competition');
    
    % crossover
    pop = crossover(pop);
    
    % mutation
    pop = mutation(pop, probmutation);
   
    % save elitism(best path) and put it to next generation without changes
    pop = [bestPop; pop];
end

% return the best route
[mindist, bestID]=min(popDist); 
bestPop = pop(bestID, :);

% plot and output final solution
plotroute(city, bestPop, mindist, generation);
fpdfprinter('Final Solution')

