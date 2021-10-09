function y = D3fun_maolian(x_point, T, theta, alpha, I)
%此函数用于求解锚链的T、theta和alpha
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
switch I 
    case 1
       II = 78/1000;%锚链每节长度 m
       m_II = 3.2;%单位长度的质量 kg/m
    case 2
       II = 105/1000;%锚链每节长度 m
       m_II = 7;%单位长度的质量 kg/m
    case 3
       II = 120/1000;
       m_II = 12.5;%单位长度的质量 kg/m
    case 4
        II = 150/1000;
        m_II = 19.5;%单位长度的质量 kg/m
    case 5
        II = 180/1000;
        m_II = 28.12;%单位长度的质量 kg/m
end
g = 9.8;
G_mao = II*m_II*g;%单位长度重量

Ti = x_point(1);
thetai = x_point(2);
alphai = x_point(3);

Tix = Ti*cos(thetai)*cos(alphai);
Tiy = Ti*cos(thetai)*sin(alphai);
Tiz = Ti*sin(thetai);

y = [Tix - Tx;...
    Tiy - Ty;...
    Tiz + G_mao - Tz];
end