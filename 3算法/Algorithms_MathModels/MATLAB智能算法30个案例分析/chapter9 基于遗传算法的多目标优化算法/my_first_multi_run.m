clear
clc
 

fitnessfcn = @my_first_multi;   % Function handle to the fitness function
nvars = 2;                      % Number of decision variables
lb = [-5,-5];                   % Lower bound
ub = [5,5];                     % Upper bound
A = []; b = [];                 % No linear inequality constraints
Aeq = []; beq = [];             % No linear equality constraints
options = gaoptimset('ParetoFraction',0.3,'PopulationSize',100,'Generations',200,'StallGenLimit',200,'TolFun',1e-100,'PlotFcns',@gaplotpareto);

[x,fval] = gamultiobj(fitnessfcn,nvars, A,b,Aeq,beq,lb,ub,options);