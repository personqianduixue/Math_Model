%架空率与减速率关系曲线
clc
e = [3.0,4.0,4.8,5.5,6.0];
yn = [0.60,0.68,0.72,0.71,0.63];
y = [0.63,0.70,0.73,0.72,0.65];
ym = [0.64,0.72,0.74,0.74,0.67];
plot(e,yn,'ro-')
hold on
plot(e,y,'*-')
plot(e,ym,'gP-')
plot(e,yn,'r')
plot(e,y)
plot(e,ym,'g')
title('架空率与减速率关系曲线')
xlabel('\epsilon')
ylabel('\eta')
legend('\eta_{min}','\eta_{eav}','\eta_{max}')
xlim([3,7])
ylim([0.6,0.8])