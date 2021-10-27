%架空率与减速率关系三次样条差值曲线
clc
e = [3.0,4.0,4.8,5.5,6.0];
y1= [0.60,0.68,0.72,0.71,0.63];
y2 = [0.63,0.70,0.73,0.72,0.65];
y3 = [0.64,0.72,0.74,0.74,0.67];
xi = 3:0.2:6;
y11 = interp1(e,y1,xi,'spline')
y22 = interp1(e,y2,xi,'spline')
y33 = interp1(e,y3,xi,'spline')
plot(xi,y11,'g*-')
hold on
plot(xi,y22,'rs-')
plot(xi,y33,'p-')
title('架空率与减速率关系三次样条插值曲线')
xlabel('\epsilon')
ylabel('\eta')
legend('\eta_{min}','\eta_{eav}','\eta_{max}')
xlim([3,7])
ylim([0.6,0.8])