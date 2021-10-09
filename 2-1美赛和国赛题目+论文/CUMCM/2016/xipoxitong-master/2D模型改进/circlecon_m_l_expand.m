function [c, ceq] = circlecon_m_l_expand(x, I, v1, v2, H, xitong_figure)
%此函数是第三问求解m_qiu和L优化问题的非线性约束
%

%%%%正文%%%%
m_qiu = x(1);
L = x(2);

xitong_save = 0;
bestxx = bestpoint3_expand(H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save);%求最优点
xitong_save = 1;
[~] = For2D_expand(bestxx, H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save);%绘制系统
load('系统信息.mat', 'stat')
alpha1 = stat.alpha1;
alpha2 = stat.alpha2;
L_tuo = stat.L_tuo;
h = stat.h;

%非线性约束
rho = 1.025*10^3;%海水的密度  kg/m^3
D = 2;%圆柱浮标地面直径 m
m0= 1000;%浮标质量 kg
h_min = (m0+m_qiu)/(rho*pi*(D/2)^2);

c(1) = alpha1 - 5;
c(2) = -alpha1;
c(3) = alpha2 - 16;
c(4) = -alpha2;
c(5) = h - 2;
c(6) = -(h - h_min);
c(7) = L_tuo - 0.3;

ceq = [];%ceq = L_tuo;
end























