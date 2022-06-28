function y = D3fun_fubiao(x_point, beta, z0, v1, v2)
%此函数用于求解T1、theta1和alpha1
%

%%%%正文%%%%
h = abs(z0);

%浮标受力分析
rho = 1.025*10^3;
g = 9.8;
m0 = 1000;
H0 = 2;
D0 = 2;
F0 = rho*g*pi*(D0/2)^2*h;
G0=m0*g;
Fw = 0.625*(D0*(H0 - h))*v1^2;
Fs = 374*(D0*h)*v2^2;

T1 = x_point(1);
theta1 = x_point(2);
alpha1 = x_point(3);

T1x = T1*cos(theta1)*cos(alpha1);
T1y = T1*cos(theta1)*sin(alpha1);
T1z = T1*sin(theta1);

y = [T1x - Fs*sin(beta);...
    T1y - Fw - Fs*cos(beta);...
    T1z + G0 - F0];

end



