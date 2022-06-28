%% 此文件用于求解第三问，最优m_qiu、L和I使单一目标最小
%% 优化设置
%参数设置
clc, clear
I = 2;
c1 = 1;
c2 = 1;
v1 = 24;
v2 = 1.5;
H = 18;
xitong_figure = 0;

%目标及约束
fun = @(x)GA_m_l_expand(x, I, c1, c2, v1, v2, H, xitong_figure);
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0, H-5];
ub = [inf, inf];
nonlcon = @(x)circlecon_m_l_expand(x, I, v1, v2, H, xitong_figure);

%% 利用GA算法解此非线性优化
% nvars = 2;         % 个体的变量数目
% options = gaoptimset('PopulationSize',100,'CrossoverFraction',0.75,'Generations',20,'StallGenLimit',40,'PlotFcns',{@gaplotbestf,@gaplotbestindiv}); %参数设置
% [x_best, fval,  exitflag] = ga(fun, nvars, A, b, Aeq, beq, lb, ub, nonlcon, options);   

%% 利用fmincon解此非线性优化（具有非线性约束的）
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
X0 = [1200, 28];
x_m_l = fmincon(fun, X0, A, b, Aeq, beq, lb, ub, nonlcon, options);

%绘制结果
m_qiu = x_m_l(1);
L = x_m_l(2);

xitong_figure = 0;
xitong_save = 0;
bestxx = bestpoint3_expand(H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save);%求最优点

xitong_figure = 1;
xitong_save = 1;
[~] = For2D_expand(bestxx, H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save);%绘制系统


