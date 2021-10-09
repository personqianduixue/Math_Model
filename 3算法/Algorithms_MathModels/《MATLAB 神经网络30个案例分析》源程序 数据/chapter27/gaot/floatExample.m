echo on
% This script shows how to use the ga using a float representation. 
% You should see the demos for
% more information as well. gademo1, gademo2, gademo3
global bounds

% Setting the seed to the same for binary
rand('seed',156789)

% Crossover Operators
xFns = 'arithXover heuristicXover simpleXover';
xOpts = [1 0; 1 3; 1 0];

% Mutation Operators
mFns = 'boundaryMutation multiNonUnifMutation nonUnifMutation unifMutation';

mOpts = [2 0 0;3 200 3;2 200 3;2 0 0];

% Termination Operators
termFns = 'maxGenTerm';
termOps = [200]; % 200 Generations

% Selection Function
selectFn = 'normGeomSelect';
selectOps = [0.08];

% Evaluation Function
evalFn = 'gaMichEval';
evalOps = [];

type gaMichEval

% Bounds on the variables
bounds = [-3 12.1; 4.1 5.8];

% GA Options [epsilon float/binar display]
gaOpts=[1e-6 1 1];

% Generate an intialize population of size 20
startPop = initializega(20,bounds,'gaMichEval',[1e-6 1])

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


% bestPop is the best solution tracked over generations
bestPop
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

[x endPop bestPop trace]=ga(bounds,evalFn,evalOps,[],gaOpts);

% x is the best solution found
x
% Hit a return to continue
pause


% endPop is the ending population
endPop
% Hit a return to continue
pause


% bestPop is the best solution tracked over generations
bestPop
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