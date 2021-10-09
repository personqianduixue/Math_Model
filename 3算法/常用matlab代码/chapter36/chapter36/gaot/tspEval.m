function [sol,val] = tsp(sol,options)
global distMatrix;
sol;
numvars=size(sol,2)-1;
val = -sum(diag(distMatrix(sol(1:numvars),[sol(2:numvars) sol(1)])));


