clear,clc;close all
%  omega%时角
%  delta%赤纬角
%  alpha%太阳高度角
%  A%太阳方位角
hpi=40.1*pi/180;%大同的纬度
omega=45*pi/180;
n=1:365;
delta=38.1*pi/180;
H=1.482;
%sin(alpha)=sin(hpi).*sin(delta)+cos(hpi)*cos(delta)*sin(omega);
%sin(A)=sin(omega).*cos(delta)./cos(alpha)

alpha=asin(sin(hpi).*sin(delta)+cos(hpi)*cos(delta)*sin(omega));
A=asin(sin(omega).*cos(delta)./cos(alpha));     

D=cos(A)*H/tan(alpha)
