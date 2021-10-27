%不同杆件长宽比时架空率与平均减速率关系曲线
clc
x = [3,4,4.8,6];
y1 = [0.6,0.65,0.69,0.62];
y2 = [0.63,0.70,0.73,0.63];
y3 = [0.66,0.73,0.76,0.68];
y4 = [0.69,0.74,0.77,0.72];
y5 = [0.67,0.71,0.73,0.68];
plot(x,y1,'r')
hold on
plot(x,y2)
plot(x,y3,'g')
plot(x,y4,'c')
plot(x,y5,'y')
plot(x,y1,'ro')
plot(x,y2,'*')
plot(x,y3,'gP')
plot(x,y4,'c+')
plot(x,y5,'yv')
title('不同杆件长宽比时架空率与平均减速率关系曲线')
xlabel('\epsilon')
ylabel('\eta_{eav}')
legend('\eta1=8','\eta2=10','\eta3=12','\eta4=16','\eta5=20')
xlim([3,7])
ylim([0.6,0.8])