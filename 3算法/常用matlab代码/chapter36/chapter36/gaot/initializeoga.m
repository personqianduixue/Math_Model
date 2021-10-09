function [pop] = initializeoga(num,bounds,evalFN,evalOps,options)
% initializeoga(populationSize, variableBounds,evalFN,evalOps,options)
%    initializeoga creates a matrix of random permutations with 
%    a number of rows equal to the populationSize and a number
%    columns equal to the size of the permutation plus 1 for 
%    the f(x) value which is found by applying the evalFN.
%    This initization function is used with an order-based
%    representation.
%
% pop    - the initial, evaluated, random population 
% num    - the size of the population, i.e. the number to create
% bounds - the number of permutations in an individual (e.g., number
%          of cities in a tsp
% evalFN - the evaluation fn, usually the name of the .m file for evaluation
% evalOps- any options to be passed to the eval function defaults []
% options- options to the initialize function, ie. [eps float/binary prec] 
%           where eps is the epsilon value and the second option is 1 for
%          orderOps, prec is the precision of the variables defaults [1e-6 1]

if nargin<5
  options=[1e-6 1];
end
if nargin<4
  evalOps=[];
end

if any(evalFN<48) %Not a .m file
  estr=['x=pop(i,:); pop(i,xZomeLength)=', evalFN ';'];  
else %A .m file
    estr=['[pop(i,:) pop(i,xZomeLength)]=' evalFN '(pop(i,:),[0 evalOps]);'];  
end


numVars     = bounds; 		%Number of variables

xZomeLength = numVars+1; 		%Length of string is numVar + fit
pop         = zeros(num,xZomeLength); 	%Allocate the new population
for i=1:num
  pop(i,:)=[randperm(numVars) 0];
  eval(estr);
end

