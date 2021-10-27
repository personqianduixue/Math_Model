%杆件长宽比与减速率关系三次样条差值
clc
x = [8,10,12,16,20];
y1 = [0.67,0.70,0.75,0.75,0.70];
y2 = [0.69,0.73,0.76,0.77,0.73];
y3 = [0.71,0.74,0.77,0.78,0.76];
plot(x,y1,'g*-')
hold on
plot(x,y2,'rs-')
plot(x,y3,'p-')
title('杆件长宽比与减速率关系')
xlabel('\lambda')
ylabel('\eta')
legend('\eta_{min}','\eta_{eav}','\eta_{max}')
xlim([5,22])
ylim([0.64,0.8])