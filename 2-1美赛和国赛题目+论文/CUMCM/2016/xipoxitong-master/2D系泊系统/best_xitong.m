%% 求系统信息及系统图形
%% 利用离散枚举法计算bestx0, besty0情况下的系统信息及系统图形
clc
clear
%风速为12时的系统情况
H = 18;
N = 1000;
x0 = 20;
v_wind = 12;
m_qiu = 1200;
I = 2;
L = 22.05;
y0_yn_figure = 1;
xitong_figure = 1;
[besty0, bestx0] = bestpoint(H, N, x0, v_wind, m_qiu, I, L, y0_yn_figure);
y0 = besty0;
x0 = bestx0;
[y1, x1, theta1, T1, stat1] = For2D(y0, x0, v_wind, m_qiu, I, L, xitong_figure);

%风速为24时的系统情况
v_wind = 24;
[besty0, bestx0] = bestpoint(H, N, x0, v_wind, m_qiu, I, L, y0_yn_figure);
y0 = besty0;
x0 = bestx0;
[y2, x2, theta2, T2, stat2] = For2D(y0, x0, v_wind, m_qiu, I, L, xitong_figure);  

%风速为36时的系统情况
y0_yn_figure = 0;
v_wind = 36;
[besty0, bestx0] = bestpoint(H, N, x0, v_wind, m_qiu, I, L, y0_yn_figure);
y0 = besty0;
x0 = bestx0;
[y3, x3, theta3, T3, stat3] = For2D(y0, x0, v_wind, m_qiu, I, L, xitong_figure);

%% 利用迭代算法计算bestx0, besty0情况下的系统信息及系统图形
clc
clear
%风速为12时的系统情况
y0 = -0.5;
x0 = 20;
H = 18;
eta = 0.001;%注：学习率严重影响求解精度
maxt = 500;
eps = 0.01;
v_wind = 12;
m_qiu = 1200;
I = 2;
L = 22.05;
[besty0, bestx0, bestyn] = bestpoint2(y0, x0, H, eta, maxt, eps, v_wind, m_qiu, I, L);
y0 = besty0;
x0 = bestx0;
xitong_figure = 1;
[y1, x1, theta1, T1, stat1] = For2D(y0, x0, v_wind, m_qiu, I, L, xitong_figure);

%% 利用fzero计算bestx0, besty0情况下的系统信息及系统图形
clc
clear
%风速为12时的系统情况
H = 18;
x0 = 20;
v_wind = 12;
m_qiu = 1200;
I = 2;
L = 22.05;
xitong_figure = 0;
[besty0, bestx0] = bestpoint3(H, x0, v_wind, m_qiu, I, L, xitong_figure);
xitong_figure = 1;
[y, x, theta, T, stat] = For2D(besty0, bestx0, v_wind, m_qiu, I, L, xitong_figure);
% 注：fzero函数可以用fsolve函数代替
