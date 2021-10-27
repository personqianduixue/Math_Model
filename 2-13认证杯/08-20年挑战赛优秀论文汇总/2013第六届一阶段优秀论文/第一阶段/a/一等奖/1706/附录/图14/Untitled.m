%不同杆件长宽比时架空率与平均减速率关系三次样条差值曲线
clc
x = [3,4,4.8,6];
y1 = [0.6,0.65,0.69,0.62];
y2 = [0.63,0.70,0.73,0.63];
y3 = [0.66,0.73,0.76,0.68];
y4 = [0.69,0.74,0.77,0.72];
y5 = [0.67,0.71,0.73,0.68];
xi = 3:0.2:6;
y11 = interp1(x,y1,xi,'spline')
y22 = interp1(x,y2,xi,'spline')
y33 = interp1(x,y3,xi,'spline')
y44 = interp1(x,y4,xi,'spline')
y55 = interp1(x,y5,xi,'spline')
plot(xi,y11,'g*-')
hold on
plot(xi,y22,'rs-')
plot(xi,y33,'p-')
plot(xi,y44,'c+-')
plot(xi,y55,'yv-')
title('不同杆件长宽比时架空率与平均减速率关系三次样条插值曲线')
xlabel('\epsilon')
ylabel('\eta_{eav}')
legend('\lambda=8','\lambda=10','\lambda=12','\lambda=16','\lambda=20')
xlim([3,7])
ylim([0.6,0.8])