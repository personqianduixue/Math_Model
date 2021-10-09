clc, clear
eq=@(x,y,mu)[y(2);-mu*y(1)]; %定义一阶方程组的匿名函数
bd=@(ya,yb,mu)[ya(1);ya(2)-1;yb(1)+yb(2)];  %定义边值条件的匿名函数
guess=@(x)[sin(2*x);2*cos(2*x)]; %定义初始猜测解的匿名函数
guess_structure=bvpinit(linspace(0,1,10),guess,5); %给出初始猜测解的结构,mu=5
sol=bvp4c(eq,bd,guess_structure); %计算数值解
plot(sol.x,sol.y(1,:),'-',sol.x,sol.yp(1,:),'--','LineWidth',2)
xlabel('x','FontSize',12)
legend('y_1','y_2')
