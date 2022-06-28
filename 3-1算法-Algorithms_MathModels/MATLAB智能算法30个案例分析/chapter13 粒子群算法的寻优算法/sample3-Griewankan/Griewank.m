clear,clc,close all;

% Ackley part1
[x,y]=meshgrid(-100:1.6:100);     
z=1/4000.*( x.^2+y.^2 )-cos( x./1 ).*cos( y./sqrt(2) )+1;
surf(x,y,z)