

clear all; close all;
[x, y]=meshgrid(-128:2:127, -128:2:127);
D=sqrt((x).^2+(y).^2);
D0=50;
W=30;
H=1-exp(-((D.^2-D0^2)./(W*D)).^2/2);
H2=1-H;
figure;
mesh(double(H));