%% 此文件用于求解第三问，最优m_qiu、L和I使单一目标最小
%% 优化设置
%参数设置
clc, clear
I = 5;
c1 = 1;
c2 = 1;
v_wind = 24;
H = 18;
N = 500;
x0 = 20;
y0_yn_figure = 0;
xitong_figure = 0;

%目标及约束
fun = @(x) GA_m_l(x, I, c1, c2, v_wind, H, N, x0, y0_yn_figure, xitong_figure);
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0, H-5];
ub = [inf, inf];
nonlcon = @(x)circlecon_m_l(x, I, v_wind, H, N, x0, y0_yn_figure, xitong_figure);

%% 利用GA算法解此非线性优化-----失败了
% nvars = 2;         % 个体的变量数目
% options = gaoptimset('PopulationSize',100,'CrossoverFraction',0.75,'Generations',20,'StallGenLimit',40,'PlotFcns',{@gaplotbestf,@gaplotbestindiv}); %参数设置
% [x_best, fval,  exitflag] = ga(fun, nvars, A, b, Aeq, beq, lb, ub, nonlcon, options);   

%% 利用fmincon解此非线性优化（具有非线性约束的）
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
X0 = [0, 20];
x_m_l = fmincon(fun, X0, A, b, Aeq, beq, lb, ub, nonlcon, options);

%绘制结果
m_qiu = x_m_l(1);
L = x_m_l(2);
x0 = 20;
xitong_figure = 1;
[besty0, bestx0] = bestpoint(H, N, x0, v_wind, m_qiu, I, L, y0_yn_figure);
y0 = besty0;
x0 = bestx0;
[y1, x1, theta1, T1, stat1] = For2D(y0, x0, v_wind, m_qiu, I, L, xitong_figure);


