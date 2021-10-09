function [xm,fv]=CLSPSO(fitness,N,w,c1,c2,xmax,xmin,M,MaxC,D)
%待优化函数：fitness
%粒子数目：N
%惯性权重：w
%学习因子1：c1
%学习因子2：c2
%自变量搜索域的最大值：xmax
%自变量搜索域的最小值：xmin
%最大迭代次数:M
%混沌搜索的最大步数:MaxC
%问题的维数：D
%目标函数取最小值时的自变量值：xm
%目标函数的最小值：fv

format long;
for i=1:N
    for j=1:D
        x(i,j)=randn;       %随机初始化位置
        v(i,j)=randn;       %随机初始化速度
    end
end
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);                  %pg为全局最优
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
for t=1:M
    for i=1:N
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        fv(i)=fitness(x(i,:));
    end
    [sort_fv,index]=sort(fv);
    Nbest=floor(N*0.2);                 %保留群体中20%的最佳粒子
    for n=1:Nbest                       %对群体中20%的最佳粒子进行混沌搜索
        tmpx=x(index(n),:);
        for k=1:MaxC                    %混沌搜索的最大步数
            for dim=1:D                 %混沌搜索的迭代公式
                cx(dim)=(tmpx(1,dim)-xmin(dim))/(tmpx(1,dim)-xmax(dim));
                cx(dim)=4*cx(dim)*(1-cx(dim));
                tmpx(1,dim)=tmpx(1,dim)+cx(dim)*(xmax(dim)-xmin(dim));
            end
            fcs=fitness(tmpx);
            if fcs<sort_fv(n)           %对混沌搜索后的决策变量值进行评估
                x(index(n),:)=tmpx;
                break;
            end
        end
        x(index(n),:)=tmpx;
    end
    r=rand();
    for s=1:D                           %收缩搜索区域
        xmin(s)=max(xmin(s),pg(s)-r*(xmax(s)-xmin(s)));
        xmax(s)=min(xmax(s),pg(s)+r*(xmax(s)-xmin(s)));
    end
    x(1:Nbest,:)=x(index(1:Nbest),:);
    for i=(Nbest+1):N                   %随机产生剩余的80%微粒
        for j=1:D
            x(i,j)=xmin(j)+rand*(xmax(j)-xmin(j));      %随机初始化位置
            v(i,j)=randn;                               %随机初始化速度
        end
    end
    Pbest(t)=fitness(pg);
    for i=1:N
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