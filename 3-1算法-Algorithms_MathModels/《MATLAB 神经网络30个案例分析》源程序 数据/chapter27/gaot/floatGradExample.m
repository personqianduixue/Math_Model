echo off
%load seed.mat
rand('seed',0);
echo on
% This script shows how to use the ga. You should see the demos for
% more information as well. gademo1, gademo2, gademo3
global bounds

% Crossover Operators
xFns = 'arithXover heuristicXover simpleXover';
xOpts = [2 0; 2 3; 2 0];

% Mutation Operators
mFns = 'boundaryMutation multiNonUnifMutation nonUnifMutation unifMutation';
mOpts = [4 0 0;6 10 3;4 10 3;4 0 0];

% Termination Operators
termFns = 'maxGenTerm';
termOps = [10];

% Selection Function
selectFn = 'normGeomSelect';
selectOps = [0.06];

% Evaluation Function takes two options 
% prob to use gradient, prob to perform Lamarkian evolution
evalFn = 'gaZBGradEval';
evalOps = [1.00 1.00];

% Bounds on the variables
bounds = [-3 12.1; 4.1 5.8];

% GA Options [epsilon float/binar display]
gaOpts=[1e-6 1 1];

% Generate an intialize population of size 80
startPop = initializega(80,bounds,evalFn,evalOps,[1e-6 1]);
evalOps = [1.00 0.00]; % 1 - Peform learning 0-Do not update

% Lets run the GA using Baldwinian Evolution

[x endPop bestPop trace]=ga(bounds,evalFn,evalOps,startPop,gaOpts,...
    termFns,termOps,selectFn,selectOps,xFns,xOpts,mFns,mOpts);

% x is the best solution found
x
pause

% endPop is the ending population
endPop
pause

% bestPop is the best solution tracked over generations
bestPop
pause

% trace is a trace of the best value and average value of generations
trace
pause

% Plot the best over time
clf
plot(trace(:,1),trace(:,2));
pause

% Add the average to the graph
hold on
plot(trace(:,1),trace(:,3));
pause

% Lets run the GA using Lamarkian Evolution
evalOps = [1.00 1.00];

[x endPop bestPop trace]=ga(bounds,evalFn,evalOps,startPop,gaOpts,...
    termFns,termOps,selectFn,selectOps,xFns,xOpts,mFns,mOpts);

% x is the best solution found
x
pause

% endPop is the ending population
endPop
pause

% bestPop is the best solution tracked over generations
bestPop
pause

% trace is a trace of the best value and average value of generations
trace
pause

% Plot the best over time
clf
plot(trace(:,1),trace(:,2));
pause

% Add the average to the graph
hold on
plot(trace(:,1),trace(:,3));
pause
