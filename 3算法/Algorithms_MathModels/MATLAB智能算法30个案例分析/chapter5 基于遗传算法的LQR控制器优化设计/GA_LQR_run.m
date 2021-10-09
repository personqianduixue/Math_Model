clear
clc

fitnessfcn = @GA_LQR;     % 适应度函数句柄
nvars=3;                  % 个体的变量数目
LB = [0.1 0.1 0.1];       % 上限
UB = [1e6 1e6 1e6];       % 下限
options=gaoptimset('PopulationSize',100,'PopInitRange',[LB;UB],'EliteCount',10,'CrossoverFraction',0.4,'Generations',20,'StallGenLimit',20,'TolFun',1e-100,'PlotFcns',{@gaplotbestf,@gaplotbestindiv});%参数设置
[x_best,fval]=ga(fitnessfcn,nvars, [],[],[],[],LB,UB,[],options); 
