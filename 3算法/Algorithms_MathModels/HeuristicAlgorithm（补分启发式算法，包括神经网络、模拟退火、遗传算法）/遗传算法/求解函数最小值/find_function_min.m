%% 遗传算法求解函数最小值
clc, clear

options = gaoptimset;
options. PopulationType='doubleVector';
% options. PopulationSize=100;
options.PopInitRange=[-11;26]
options. PopulationSize=300;
options.StallGenLimit=inf;
options.StallTimeLimit=inf;
options.PlotFcns=@gaplotbestf;
options.Generations=100;
[x, fval, reason]=ga(@f, 1, options)