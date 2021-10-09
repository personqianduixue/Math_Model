function [xm,fv]=SelPSO(fitness,N,c1,c2,w,M,D)
%待优化目标函数：fitness
%粒子数目：N
%学习因子1：c1
%学习因子2：c2
%惯性权重：w
%最大迭代次数：M
%问题的维数：D
%目标函数取最小值时的自变量值：xm
%目标函数的最小值：fv

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
pg=x(N,:);                              %pg为全局最优
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
for t=1:M
    for i=1:N
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        fx(i)=fitness(x(i,:));
        if fx(i)<p(i)
            p(i)=fx(i);
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
    [sortf,sortx]=sort(fx);             %将所有粒子按适应值排序
    exIndex=round((N-1)/2);
    x(sortx((N-exIndex+1):N))=x(sortx(1:exIndex));        %将最好的一半粒子的位置替换掉最差的一半
    v(sortx((N-exIndex+1):N))=v(sortx(1:exIndex));        %将最好的一半粒子的速度替换掉最差的一半
end
xm=pg';
fv=fitness(pg);