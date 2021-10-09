% example7_3.m
n = -5:0.1:5;
a = radbas(n-2);		% 中心位置向右平移两个单位
b = exp(-(n).^2/2);     % 除以2，曲线更加“矮胖”
figure;
plot(n,a);
hold on;
plot(n,b,'--');			% 虚线
c = diff(a);			% 计算a的微分
hold off;
figure;
plot(c);
