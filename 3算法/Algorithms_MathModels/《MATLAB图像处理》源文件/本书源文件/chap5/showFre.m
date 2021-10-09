

clear all; close all;
[x, y]=meshgrid(-128:2:127, -128:2:127);
n1=0;
n2=0;
z=sqrt((x-n1).^2+(y-n2).^2);
D1=40;  D2=40;
n=6;
H1=1./(1+(z/D1).^(2*n));
H2=1-H1;
figure;
mesh(H2);
axis tight;
