function [x,endPop,bPop,traceInfo] = ga(bounds,evalFN,evalOps,startPop,opts,...
termFN,termOps,selectFN,selectOps,xOverFNs,xOverOps,mutFNs,mutOps)
% GA run a genetic algorithm
% function [x,endPop,bPop,traceInfo]=ga(bounds,evalFN,evalOps,startPop,opts,
%                                       termFN,termOps,selectFN,selectOps,
%                                       xOverFNs,xOverOps,mutFNs,mutOps)
%                                
% Output Arguments:
%   x            - the best solution found during the course of the run
%   endPop       - the final population 
%   bPop         - a trace of the best population
%   traceInfo    - a matrix of best and means of the ga for each generation
%
% Input Arguments:
%   bounds       - a matrix of upper and lower bounds on the variables
%   evalFN       - the name of the evaluation .m function
%   evalOps      - options to pass to the evaluation function ([NULL])
%   startPop     - a matrix of solutions that can be initialized
%                  from initialize.m
%   opts         - [epsilon prob_ops display] change required to consider two 
%                  solutions different, prob_ops 0 if you want to apply the
%                  genetic operators probabilisticly to each solution, 1 if
%                  you are supplying a deterministic number of operator
%                  applications and display is 1 to output progress 0 for
%                  quiet. ([1e-6 1 0])
%   termFN       - name of the .m termination function (['maxGenTerm'])
%   termOps      - options string to be passed to the termination function
%                  ([100]).
%   selectFN     - name of the .m selection function (['normGeomSelect'])
%   selectOpts   - options string to be passed to select after
%                  select(pop,#,opts) ([0.08])
%   xOverFNS     - a string containing blank seperated names of Xover.m
%                  files (['arithXover heuristicXover simpleXover']) 
%   xOverOps     - A matrix of options to pass to Xover.m files with the
%                  first column being the number of that xOver to perform
%                  similiarly for mutation ([2 0;2 3;2 0])
%   mutFNs       - a string containing blank seperated names of mutation.m 
%                  files (['boundaryMutation multiNonUnifMutation ...
%                           nonUnifMutation unifMutation'])
%   mutOps       - A matrix of options to pass to Xover.m files with the
%                  first column being the number of that xOver to perform
%                  similiarly for mutation ([4 0 0;6 100 3;4 100 3;4 0 0])

% Binary and Real-Valued Simulation Evolution for Matlab 
% Copyright (C) 1996 C.R. Houck, J.A. Joines, M.G. Kay 
%
% C.R. Houck, J.Joines, and M.Kay. A genetic algorithm for function
% optimization: A Matlab implementation. ACM Transactions on Mathmatical
% Software, Submitted 1996.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 1, or (at your option)
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. A copy of the GNU 
% General Public License can be obtained from the 
% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

%%$Log: ga.m,v $
%Revision 1.10  1996/02/02  15:03:00  jjoine
% Fixed the ordering of imput arguments in the comments to match
% the actual order in the ga function.
%
%Revision 1.9  1995/08/28  20:01:07  chouck
% Updated initialization parameters, updated mutation parameters to reflect
% b being the third option to the nonuniform mutations
%
%Revision 1.8  1995/08/10  12:59:49  jjoine
%Started Logfile to keep track of revisions
%


n=nargin;
if n<2 | n==6 | n==10 | n==12
  disp('Insufficient arguements') 
end
if n<3 %Default evalation opts.
  evalOps=[];
end
if n<5
  opts = [1e-6 1 0];
end
if isempty(opts)
  opts = [1e-6 1 0];
end

if any(evalFN<48) %Not using a .m file
  if opts(2)==1 %Float ga
    e1str=['x=c1; c1(xZomeLength)=', evalFN ';'];  
    e2str=['x=c2; c2(xZomeLength)=', evalFN ';'];  
  else %Binary ga
    e1str=['x=b2f(endPop(j,:),bounds,bits); endPop(j,xZomeLength)=',...
	evalFN ';'];
  end
else %Are using a .m file
  if opts(2)==1 %Float ga
    e1str=['[c1 c1(xZomeLength)]=' evalFN '(c1,[gen evalOps]);'];  
    e2str=['[c2 c2(xZomeLength)]=' evalFN '(c2,[gen evalOps]);'];  
  else %Binary ga
    e1str=['x=b2f(endPop(j,:),bounds,bits);[x v]=' evalFN ...
	'(x,[gen evalOps]); endPop(j,:)=[f2b(x,bounds,bits) v];'];  
  end
end


if n<6 %Default termination information
  termOps=[100];
  termFN='maxGenTerm';
end
if n<12 %Default muatation information
  if opts(2)==1 %Float GA
  mutFNs=['boundaryMutation multiNonUnifMutation nonUnifMutation unifMutation'];
    mutOps=[4 0 0;6 termOps(1) 3;4 termOps(1) 3;4 0 0];
  else %Binary GA
    mutFNs=['binaryMutation'];
    mutOps=[0.05];
  end
end
if n<10 %Default crossover information
  if opts(2)==1 %Float GA
    xOverFNs=['arithXover heuristicXover simpleXover'];
    xOverOps=[2 0;2 3;2 0];
  else %Binary GA
    xOverFNs=['simpleXover'];
    xOverOps=[0.6];
  end
end
if n<9 %Default select opts only i.e. roullete wheel.
  selectOps=[];
end
if n<8 %Default select info
  selectFN=['normGeomSelect'];
  selectOps=[0.08];
end
if n<6 %Default termination information
  termOps=[100];
  termFN='maxGenTerm';
end
if n<4 %No starting population passed given
  startPop=[];
end
if isempty(startPop) %Generate a population at random
  %startPop=zeros(80,size(bounds,1)+1);
  startPop=initializega(80,bounds,evalFN,evalOps,opts(1:2));
end

if opts(2)==0 %binary
  bits=calcbits(bounds,opts(1));
end

xOverFNs=parse(xOverFNs);
mutFNs=parse(mutFNs);

xZomeLength  = size(startPop,2); 	%Length of the xzome=numVars+fittness
numVar       = xZomeLength-1; 		%Number of variables
popSize      = size(startPop,1); 	%Number of individuals in the pop
endPop       = zeros(popSize,xZomeLength); %A secondary population matrix
c1           = zeros(1,xZomeLength); 	%An individual
c2           = zeros(1,xZomeLength); 	%An individual
numXOvers    = size(xOverFNs,1); 	%Number of Crossover operators
numMuts      = size(mutFNs,1); 		%Number of Mutation operators
epsilon      = opts(1);                 %Threshold for two fittness to differ
oval         = max(startPop(:,xZomeLength)); %Best value in start pop
bFoundIn     = 1; 			%Number of times best has changed
done         = 0;                       %Done with simulated evolution
gen          = 1; 			%Current Generation Number
collectTrace = (nargout>3); 		%Should we collect info every gen
floatGA      = opts(2)==1;              %Probabilistic application of ops
display      = opts(3);                 %Display progress 

while(~done)
  %Elitist Model
  [bval,bindx] = max(startPop(:,xZomeLength)); %Best of current pop
  best =  startPop(bindx,:);

  if collectTrace
    traceInfo(gen,1)=gen; 		          %current generation
    traceInfo(gen,2)=startPop(bindx,xZomeLength);       %Best fittness
    traceInfo(gen,3)=mean(startPop(:,xZomeLength));     %Avg fittness
    traceInfo(gen,4)=std(startPop(:,xZomeLength)); 
  end
  
  if ( (abs(bval - oval)>epsilon) | (gen==1)) %If we have a new best sol
    if display
      fprintf(1,'\n%d %f\n',gen,bval);          %Update the display
    end
    if floatGA
      bPop(bFoundIn,:)=[gen startPop(bindx,:)]; %Update bPop Matrix
    else
      bPop(bFoundIn,:)=[gen b2f(startPop(bindx,1:numVar),bounds,bits)...
	  startPop(bindx,xZomeLength)];
    end
    bFoundIn=bFoundIn+1;                      %Update number of changes
    oval=bval;                                %Update the best val
  else
    if display
      fprintf(1,'%d ',gen);	              %Otherwise just update num gen
    end
  end
  
  endPop = feval(selectFN,startPop,[gen selectOps]); %Select
  
  if floatGA %Running with the model where the parameters are numbers of ops
    for i=1:numXOvers,
      for j=1:xOverOps(i,1),
	a = round(rand*(popSize-1)+1); 	%Pick a parent
	b = round(rand*(popSize-1)+1); 	%Pick another parent
	xN=deblank(xOverFNs(i,:)); 	%Get the name of crossover function
	[c1 c2] = feval(xN,endPop(a,:),endPop(b,:),bounds,[gen xOverOps(i,:)]);
	
	if c1(1:numVar)==endPop(a,(1:numVar)) %Make sure we created a new 
	  c1(xZomeLength)=endPop(a,xZomeLength); %solution before evaluating
	elseif c1(1:numVar)==endPop(b,(1:numVar))
	  c1(xZomeLength)=endPop(b,xZomeLength);
	else 
	  %[c1(xZomeLength) c1] = feval(evalFN,c1,[gen evalOps]);
	  eval(e1str);
	end
	if c2(1:numVar)==endPop(a,(1:numVar))
	  c2(xZomeLength)=endPop(a,xZomeLength);
	elseif c2(1:numVar)==endPop(b,(1:numVar))
	  c2(xZomeLength)=endPop(b,xZomeLength);
	else 
	  %[c2(xZomeLength) c2] = feval(evalFN,c2,[gen evalOps]);
	  eval(e2str);
	end      
	
	endPop(a,:)=c1;
	endPop(b,:)=c2;
      end
    end
  
    for i=1:numMuts,
      for j=1:mutOps(i,1),
	a = round(rand*(popSize-1)+1);
	c1 = feval(deblank(mutFNs(i,:)),endPop(a,:),bounds,[gen mutOps(i,:)]);
	if c1(1:numVar)==endPop(a,(1:numVar)) 
	  c1(xZomeLength)=endPop(a,xZomeLength);
	else
	  %[c1(xZomeLength) c1] = feval(evalFN,c1,[gen evalOps]);
	  eval(e1str);
	end
	endPop(a,:)=c1;
      end
    end
    
  else %We are running a probabilistic model of genetic operators
    for i=1:numXOvers,
      xN=deblank(xOverFNs(i,:)); 	%Get the name of crossover function
      cp=find(rand(popSize,1)<xOverOps(i,1)==1);
      if rem(size(cp,1),2) cp=cp(1:(size(cp,1)-1)); end
      cp=reshape(cp,size(cp,1)/2,2);
      for j=1:size(cp,1)
	a=cp(j,1); b=cp(j,2); 
	[endPop(a,:) endPop(b,:)] = feval(xN,endPop(a,:),endPop(b,:),...
	  bounds,[gen xOverOps(i,:)]);
      end
    end
    for i=1:numMuts
      mN=deblank(mutFNs(i,:));
      for j=1:popSize
	endPop(j,:) = feval(mN,endPop(j,:),bounds,[gen mutOps(i,:)]);
	eval(e1str);
      end
    end
  end
  
  gen=gen+1;
  done=feval(termFN,[gen termOps],bPop,endPop); %See if the ga is done
  startPop=endPop; 			%Swap the populations
  
  [bval,bindx] = min(startPop(:,xZomeLength)); %Keep the best solution
  startPop(bindx,:) = best; 		%replace it with the worst
end

[bval,bindx] = max(startPop(:,xZomeLength));
if display 
  fprintf(1,'\n%d %f\n',gen,bval);	  
end

x=startPop(bindx,:);
if opts(2)==0 %binary
  x=b2f(x,bounds,bits);
  bPop(bFoundIn,:)=[gen b2f(startPop(bindx,1:numVar),bounds,bits)...
      startPop(bindx,xZomeLength)];
else
  bPop(bFoundIn,:)=[gen startPop(bindx,:)];
end

if collectTrace
  traceInfo(gen,1)=gen; 		%current generation
  traceInfo(gen,2)=startPop(bindx,xZomeLength); %Best fittness
  traceInfo(gen,3)=mean(startPop(:,xZomeLength)); %Avg fittness
end






