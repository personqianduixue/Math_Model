%% 精避障轨迹图的绘制　
h=70;
aaa=1.98;
T=sqrt(2*h/g);
t1=0.5*T;
t2=t1;
x3=[];
y3=[];
x33=[];

for i=0:0.01:t1
x3=[x3;0.5*1.98*i^2];
end
temp5=x3(end,1);
vvv=aaa*t1;

for i=0:0.01:t2
x33=[x33;temp5+vvv*i-0.5*aaa*i^2];
end
X3=[x3;x33];
for i=0:0.01:T
y3=[y3;100-0.5*g*i^2];
end
plot(X3,y3,'LineWidth');
title('精避障运动轨迹图','FontSize',12);
xlabel('水平位移/米');
ylabel('高度/米');
