function [xm,fv]=SecVibratPSO(fitness,N,w,c1,c2,M,D)
%待优化的目标函数：fitness
%粒子数目：N
%惯性权重：w
%学习因子1：c1
%学习因子2：c2
%最大迭代次数：M
%问题的维数：D
%目标函数取最小值时的自变量的值：xm
%目标函数的最小值：fv

format long;
for i=1:N
    for i=1:D
        x(i,j)=randn;           %随机初始化位置
        xl(i,j)=randn;          %随机初始化速度，用于保存粒子上次的位置
        v(i,j)=randn;           %随机初始化速度，用于保存粒子当前的位置
    end
end
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);                      %pg为全局最优
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
for i=1:M
    for i=1:N
        phi1=c1*rand();
        phi2=c2*rand();
        if t<M/2                %算法前期的参数选择公式
            ks1=(2*sqrt(phi1)-1)*rand()/phi1;
            ks2=(2*sqrt(phi2)-1)*rand()/phi2;
        else
            ks1=(2*sqrt(phi1)-1)*(1+rand())/phi1;
            ks2=(2*sqrt(phi2)-1)*(1+rand())/phi2;
        end
        %速度更新公式
        v(i,:)=w*v(i,:)+phi1*(y(i,:)-(1+ks1)*x(i,:)+ks1*xl(i,:))+phi2*(pg-(1+ks2)*x(i,:)+ks1*xl(i,;));
        xl(i,:)=x(i,:);
        if fitness(x(i,:))<p(i)
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
end
xm=pg';
fv=fitness(pg);