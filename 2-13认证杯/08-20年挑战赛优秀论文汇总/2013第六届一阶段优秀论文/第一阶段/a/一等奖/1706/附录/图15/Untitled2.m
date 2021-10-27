%不同架空率时杆件长宽比与平均减速率关系三次样条差值曲线
clc
x = [8,10,12,16,20];
y1 = [0.60,0.63,0.66,0.69,0.67];
y2 = [0.65,0.70,0.73,0.74,0.71];
y3 = [0.69,0.73,0.76,0.77,0.73];
y4 = [0.62,0.65,0.68,0.72,0.67];
xi =8:1:20;
y11 = interp1(x,y1,xi,'spline')
y22 = interp1(x,y2,xi,'spline')
y33 = interp1(x,y3,xi,'spline')
y44 = interp1(x,y4,xi,'spline')
plot(xi,y11,'g*-')
hold on
plot(xi,y22,'rs-')
plot(xi,y33,'p-')
plot(xi,y44,'c+-')
title('不同架空率时杆件长宽比与平均减速率关系三次样条插值曲线')
xlabel('\lambda')
ylabel('\eta_{eav}')
legend('\epsilon=3.0','\epsilon=4.0','\epsilon=4.8','\epsilon=6.0')
xlim([5,22])
ylim([0.55,0.8])