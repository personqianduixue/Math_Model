clear
clc
fitnessfcn = @GA_demo;           % 适应度函数句柄
nvars = 2;         % 个体的变量数目
options = gaoptimset('PopulationSize',100,'EliteCount',10,'CrossoverFraction',0.75,'Generations',500,'StallGenLimit',500,'TolFun',1e-100,'PlotFcns',{@gaplotbestf,@gaplotbestindiv}); %参数设置
[x_best,fval] =ga(fitnessfcn,nvars,[],[],[],[],[],[],[],options);   % 调用ga函数

