clc
x=[4.1,6.1,10.2,20.3,30.5,40.6]
y=[0.63,0.78,0.97,1.0,1.02,1.05]
xi=1:1:41
y1 = interp1(x,y,xi,'spline')
plot(x,y,'o')
hold on
plot(xi,y1,'r*-')
title('减速率与框架体长度关系三次样条插值曲线')
xlabel('L/m')
ylabel('\eta/\eta_{10}')
xlim([0,60])
ylim([0,1.2])
