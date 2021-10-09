echo on
% This script shows how to use the ga using an order-based representation. 
% You should see the demos for
% more information as well. gademo1, gademo2, gademo3
global distMatrix
% Setting the seed to the same for binary
rand('seed',156789)

% 6 city problem
t=[ 92.6112 59.0801; 49.1155 50.0000; 12.5000 57.9436; 75.0000 19.3703;
  8.6504 13.7113; 36.8786 92.9628];
t=100*rand(15,2);
sz=size(t,1);
distMatrix=dists(t,t);


% Order-based Representation Crossover Operators
% cyclicXover.m          
% erXover.m              
% enhancederXover.m      
% linerorderXover.m      
% orderbasedXover.m      
% partmapXover.m         
% singleptXover.m        
% uniformXover.m         

xFns = 'cyclicXover uniformXover partmapXover orderbasedXover '
xFns =[xFns,'singleptXover linerorderXover'];
% xFns = [xFns,'enhancederXover linerorderXover']
% xFns = [xFns,'linerorderXover singleptXover']
xOpts = [2;2;2;2;2;2];% 2; 2; 2; 2; 2; 2; 2];

% Order-based Mutation Operators
% inversionMutation
% adjswapMutation.m      
% shiftMutation.m        
% swapMutation.m         
% threeswapMutation.m    

mFns = 'inversionMutation adjswapMutation shiftMutation swapMutation threeswapMutation';
mOpts = [2;2;2;2;2];

% Termination Operators
termFns = 'maxGenTerm';
termOps = [100]; % 200 Generations

% Selection Function
selectFn = 'normGeomSelect';
selectOps = [0.08];

% Evaluation Function
evalFn = 'tspEval';
evalOps = [];

type tspEval

% Bounds on the number of cities in the TSP
bounds = [sz];

% GA Options [epsilon float/binar display]
gaOpts=[1e-6 1 1];

% Generate an intialize population of size 20
startPop = initializeoga(80,bounds,'tspEval',[1e-6 1]);

% Lets run the GA
%Hit a return to continue
pause
[x endPop bestPop trace]=ga(bounds,evalFn,evalOps,startPop,gaOpts,...
    termFns,termOps,selectFn,selectOps,xFns,xOpts,mFns,mOpts);

% x is the best solution found
x
%Hit a return to continue
pause

% endPop is the ending population
%endPop
%%Hit a return to continue
%pause

% bestPop is the best solution tracked over generations
bestPop
%Hit a return to continue
pause

% trace is a trace of the best value and average value of generations
trace

%Hit a return to continue
pause

% Plot the best over time
clf
plot(trace(:,1),trace(:,2));
%Hit a return to continue
pause

% Add the average to the graph
hold on
plot(trace(:,1),trace(:,3));
%Hit a return to continue
pause
 
figure(2)
clf
A=ones(sz,sz);
A= xor(triu(A),tril(A));
[xg yg]=gplot(A,t);
clf
plot(xg,yg,'b:','MarkerSize',24);
h=gca;
hold on
ap=x;
plot(t(x(1:sz),1),t(x(1:(sz)),2),'r-') 
plot(t([x(1),x(sz)],1),t([x(1),x(sz)],2),'r-') 
plot(xg,yg,'b.','MarkerSize',24);

j=1;
for i=1:sz
   str=sprintf('C-%d',j);
   if t(i,1)<50
     j=j+1;
     text(t(i,1)-7,t(i,2),str);
   else
     j=j+1;
     text(t(i,1)+2,t(i,2),str);
   end
 end
 legend('Path','Best Found Path')
echo off
