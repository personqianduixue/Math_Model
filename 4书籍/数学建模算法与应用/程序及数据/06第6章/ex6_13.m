clc, clear
eq=@(x,y)[0.5*y(1)*(y(3)-y(1))/y(2)
          -0.5*(y(3)-y(1))
          (0.9-1000*(y(3)-y(5))-0.5*y(3)*(y(3)-y(1)))/y(4)
          0.5*(y(3)-y(1))
          100*(y(3)-y(5))]; %定义一阶方程组的匿名函数
bd=@(ya,yb)[ya(1)-1;ya(2)-1;ya(3)-1;ya(4)+10;yb(3)-yb(5)]; %定义边值条件的匿名函数
guess=@(x)[1;1;-4.5*x.^2+8.91*x+1;-10;-4.5*x.^2+9*x+0.91]; %定义初始猜测解的匿名函数
guess_structure=bvpinit(linspace(0,1,5),guess); %给出初始猜测解的结构
sol=bvp4c(eq,bd,guess_structure); %计算数值解
plot(sol.x,sol.y(1,:),'-*',sol.x,sol.y(2,:),'-D',sol.x,sol.y(3,:),':S',sol.x,sol.y(4,:),'-.O',sol.x,sol.y(5,:),'--P') %画出5条解曲线
legend('u','v','w','z','y',3)  %图注标注在左下角