clear
clc
fitnessfcn = @ PSO_PID;    % 适应度函数句柄
nvars=3;                   % 个体变量数目
LB = [0 0 0];              % 下限
UB = [300 300 300];        % 上限
options=gaoptimset('PopulationSize',100,'PopInitRange',[LB;UB],'EliteCount',10,'CrossoverFraction',0.6,'Generations',100,'StallGenLimit',100,'TolFun',1e-100,'PlotFcns',{@gaplotbestf,@gaplotbestindiv});   % 算法参数设置
[x_best,fval]=ga(fitnessfcn,nvars, [],[],[],[],LB,UB,[],options);      % 运行遗传算法
