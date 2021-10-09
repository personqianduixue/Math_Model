d = load('demand16.txt');
s = load('distribute16.txt');
hold on
scatter(d(:,1),d(:,2),d(:,3))
scatter(s(:,1),s(:,2),s(:,3),'g*')    
axis([108.83,109.08,34.1585,34.4047]);
xrange = linspace(108.83,109.08, 4)
yrange = linspace(34.1585,34.4047, 4)
xlabel('经度')
ylabel('纬度')
legend('车单数','出租车数')

[x,y] = meshgrid(xrange,yrange)
plot(x,y,'k--')
[y,x] = meshgrid(yrange,xrange)
plot(x,y,'k--')