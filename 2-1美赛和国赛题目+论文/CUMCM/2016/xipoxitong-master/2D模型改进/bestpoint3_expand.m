function bestxx = bestpoint3_expand(H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save)
%此函数用于求解系泊系统的3元方程组，从而求出最优y0,x0,alpha2。
%
%%%%输入说明%%%%
% H = 18;
% v1 = 24;%风速 m/s
% v2 = 1.5;%水速 m/s
% m_qiu = 1200;%重物球质量 kg
% I = 2;
% L = 22.05;
% xitong_figure = 0;%求最优点时 = 0，绘制系统时 = 1；
% xitong_save = 0;
%

%%%%正文%%%%
fun = @(xx)For2D_expand(xx, H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save);
xx0 = [H-0.7, 20, 0];
bestxx = fsolve(fun, xx0);
end




















