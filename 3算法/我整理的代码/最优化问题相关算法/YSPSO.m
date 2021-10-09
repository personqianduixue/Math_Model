function [xm,fv]=YSPSO(fitness,N,c1,c2,M,D)
%待优化的目标函数：fitness
%粒子数目：N
%学习因子1：c1
%学习因子2：c2
%惯性权重：w
%最大迭代次数：M
%问题的维数：D
%目标函数取最小值时的自变量值：xm
%目标函数的最小值：fv

phi=c1+c2;
if phi<=4
    disp('c1与c2的和必须大于4！');
    xm=NaN;
    fv=NaN;
    return;
end
format long;
for i=1:N
    for j=1:D
        x(i,j)=randn;                   %随机初始化位置
        v(i,j)=randn;                   %随机初始化速度
    end
end
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
for t=1:M
    for i=1:N
        ksi=2/abs(2-phi-sqrt(phi^2-4*phi));
        v(i,:)=v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        v(i,:)=ksi*v(i,:);
        x(i,:)=x(i,:)+v(i,:);
        if fitness(x(i,:))<p(i)
            p(i)<fitness(x(i,:));
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
end
xm=pg';
fv=fitness(pg);