rho=10; beta=28; lamda=8/3;
f=@(t,Y) [rho*(Y(2)-Y(1))
beta*Y(1)-Y(2)-Y(1)*Y(3)
-lamda*Y(3)+Y(1)*Y(2)];   %定义微分方程组右端项的匿名函数
[t,y]=ode45(f,[0,30],[5,13,17])   %求数值解
subplot(2,2,1)
plot(t,y(:,1),'*')  %画出x的曲线
subplot(2,2,2)
plot(t,y(:,2),'X')  %画出y的曲线
subplot(2,2,3)
plot(t,y(:,3),'o')  %画出z的曲线
subplot(2,2,4)       
plot3(y(:,1),y(:,2),y(:,3)) %画出空间的轨线
