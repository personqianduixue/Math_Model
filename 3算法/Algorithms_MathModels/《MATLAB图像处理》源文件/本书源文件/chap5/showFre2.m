

clear all; close all;
[x, y]=meshgrid(-128:2:127, -128:2:127);
z=sqrt(x.^2+y.^2);
D0=30;
H1=(exp(1)).^(-(z.*z)/(2*D0*D0));
H2=1-H1;
figure;
mesh(x, y, H2);
axis tight;
