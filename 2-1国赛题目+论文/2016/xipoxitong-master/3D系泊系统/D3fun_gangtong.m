function y = D3fun_gangtong(x_point, T5, theta5, alpha5, beta, v2, m_qiu)
%此函数用于求解钢桶的T、theta和alpha
%
%%%%%输入说明%%%%
% x：解。T,theta，alpha
% T：Ti-1
% theta：



%%%%正文%%%%
Tx = T5*cos(theta5)*cos(alpha5);
Ty = T5*cos(theta5)*sin(alpha5);
Tz = T5*sin(theta5);

%钢桶受力分析
rho = 1.025*10^3;
g = 9.8;
m_tong = 100;%钢桶的质量 kg
G_tong = m_tong*g;%钢桶重力
% m_qiu = 1200;%重物球质量 kg
G_qiu = m_qiu*g;%重物球重力
l_tong = 1;%钢桶长 m
D_tong = 30/100;%钢桶底长
F_tong = rho*g*pi*(D_tong/2)^2*l_tong;%钢桶浮力

% s = D_tong*(l_tong^2 - l_tong^2*(cos(theta5))^2*(sin(alpha5-beta))^2);
s = D_tong*l_tong*sqrt((cos(theta5))^2*(cos(beta - alpha5))^2 + (sin(theta5))^2);
Fs = 374*s*v2^2;%水流力

Ti = x_point(1);
thetai = x_point(2);
alphai = x_point(3);

Tix = Ti*cos(thetai)*cos(alphai);
Tiy = Ti*cos(thetai)*sin(alphai);
Tiz = Ti*sin(thetai);

y = [Tix - Tx - Fs*sin(beta);...
    Tiy - Ty - Fs*cos(beta);...
    Tiz + G_tong + G_qiu  - F_tong - Tz];
end