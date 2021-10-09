function f = multi_GA_m(m_qiu)
%此函数是IENSGAii的目标函数。
%
%解为m_qiu
%目标1：吃水深度最小
%目标2：游动区域和钢桶夹角最小
%

%正文
%定参
v_wind = 36;
%超参
c = 10;
H = 18;
N = 500;
x0 = 20;
I = 2;
L = 22.05;
y0_yn_figure = 0;
xitong_figure = 0;

[besty0, bestx0] = bestpoint(H, N, x0, v_wind, m_qiu, I, L, y0_yn_figure);
[~, ~, ~, ~, stat] = For2D(besty0, bestx0, v_wind, m_qiu, I, L, xitong_figure);
alpha1 = stat.alpha1;

f(1) = abs(besty0);
f(2) = pi*bestx0^2 + c*alpha1;
end









