%不同架空率时杆件长宽比与平均减速率关系曲线
clc
x = [8,10,12,16,20];
y1 = [0.60,0.63,0.66,0.69,0.67];
y2 = [0.65,0.70,0.73,0.74,0.71];
y3 = [0.69,0.73,0.76,0.77,0.73];
y4 = [0.62,0.65,0.68,0.72,0.67];
plot(x,y1,'r')
hold on
plot(x,y2)
plot(x,y3,'g')
plot(x,y4,'c')
plot(x,y1,'ro')
plot(x,y2,'*')
plot(x,y3,'gP')
plot(x,y4,'c+')
title('不同架空率时杆件长宽比与平均减速率关系曲线')
xlabel('\lambda')
ylabel('\eta_{eav}')
xlim([5,22])
ylim([0.55,0.8])
legend('\epsilon=3.0','\epsilon=4.0','\epsilon=4.8','\epsilon=6.0')