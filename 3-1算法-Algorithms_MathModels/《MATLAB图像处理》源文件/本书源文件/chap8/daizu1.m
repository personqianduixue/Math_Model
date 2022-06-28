
clear all; close all;
[x, y]=meshgrid(-128:2:127, -128:2:127);
D=sqrt((x).^2+(y).^2);
D0=50;
W=30;
H=double(or(D<(D0-W/2), D>D0+W/2));
H2=1-H;
figure;
mesh(double(H));
axis tight;
figure;
mesh(double(H2));
axis tight;

