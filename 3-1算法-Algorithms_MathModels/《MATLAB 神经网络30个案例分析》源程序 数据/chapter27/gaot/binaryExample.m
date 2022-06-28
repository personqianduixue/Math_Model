echo on
% This script shows how to use the ga using a float representation. 
% You should see the demos for
% more information as well. gademo1, gademo2, gademo3
global bounds

% Setting the seed back to the beginning for comparison sake
rand('seed',0)

% Crossover Operators
xFns = 'simpleXover';
xOpts = [.4];

% Mutation Operators
mFns = 'binaryMutation';

mOpts = [0.005];

% Termination Operators
termFns = 'maxGenTerm';
termOps = [200]; % 200 Generations

% Selection Function
selectFn = 'roulette'
selectOps = [];

% Evaluation Function
evalFn = 'gaMichEval';
evalOps = [];

type gaMichEval

% Bounds on the variables
bounds = [-3 12.1; 4.1 5.8];

% GA Options [epsilon float/binar display]
gaOpts=[1e-6 0 1];

% Generate an intialize population of size 20
startPop = initializega(20,bounds,'gaMichEval',[],[1e-6 0]);

% Lets run the GA
% Hit a return to continue
pause

[x endPop bestPop trace]=ga(bounds,evalFn,evalOps,startPop,gaOpts,...
    termFns,termOps,selectFn,selectOps,xFns,xOpts,mFns,mOpts);

% x is the best solution found
x
% Hit a return to continue
pause

% endPop is the ending population
endPop
% Hit a return to continue
pause

% trace is a trace of the best value and average value of generations
trace
% Hit a return to continue
pause

% Plot the best over time
clf
plot(trace(:,1),trace(:,2));
% Hit a return to continue
pause

% Add the average to the graph
hold on
plot(trace(:,1),trace(:,3));
% Hit a return to continue
pause

% Lets increase the population size by running the defaults
% 
rand('seed',0)
termOps=[100];
[x endPop bestPop trace]=ga(bounds,evalFn,evalOps,[],gaOpts,termFns,termOps,...
    selectFn,selectOps);

% x is the best solution found
x
% Hit a return to continue
pause

% endPop is the ending population
endPop
% Hit a return to continue
pause

% trace is a trace of the best value and average value of generations
trace
% Hit a return to continue
pause

% Plot the best over time
clf
plot(trace(:,1),trace(:,2));
% Hit a return to continue
pause

% Add the average to the graph
hold on
plot(trace(:,1),trace(:,3));

echo off