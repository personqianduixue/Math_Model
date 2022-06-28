

clear all; close all;
[x, y]=meshgrid(-128:2:127, -128:2:127);
n1=0;
n2=0;
z=sqrt((x-n1).^2+(y-n2).^2);
D1=10;  D2=20;
n=6;
H1=z<30;
H2=1-H1;
figure;
mesh(double(H1));
axis tight;
figure;
mesh(double(H1));
axis tight;
