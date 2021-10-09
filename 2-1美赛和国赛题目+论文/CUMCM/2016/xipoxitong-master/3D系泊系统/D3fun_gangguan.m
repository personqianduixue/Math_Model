function y = D3fun_gangguan(x_point, T, theta, alpha, beta, v2)
%此函数用于求解钢管的T、theta和alpha
%
%%%%%输入说明%%%%
% x：解。T,theta，alpha
% T：Ti-1
% theta：



%%%%正文%%%%
Tx = T*cos(theta)*cos(alpha);
Ty = T*cos(theta)*sin(alpha);
Tz = T*sin(theta);

%钢管受力分析
rho = 1.025*10^3;
g = 9.8;
m = 10;%钢管质量 kg
G = m*g;%钢管重力
l = 1;%钢管长度 m
d = 50/1000;%钢管直径 m
F = rho*g*pi*(d/2)^2*l;%钢管浮力

% s = d*(l^2 - l^2*(cos(theta))^2*(sin(alpha-beta))^2);
s = d*l*sqrt((cos(theta))^2*(cos(beta - alpha))^2 + (sin(theta))^2);
Fs = 374*s*v2^2;

Ti = x_point(1);
thetai = x_point(2);
alphai = x_point(3);

Tix = Ti*cos(thetai)*cos(alphai);
Tiy = Ti*cos(thetai)*sin(alphai);
Tiz = Ti*sin(thetai);

y = [Tix - Tx - Fs*sin(beta);...
    Tiy - Fs*cos(beta) - Ty;...
    Tiz + G - F - Tz];
end