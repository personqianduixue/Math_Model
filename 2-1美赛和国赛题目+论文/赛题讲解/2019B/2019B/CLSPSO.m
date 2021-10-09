function [xm, fv]=CLSPSO(fitness, N ,w, c1, c2,xmax,xmin,M,D)
% fitness:待优化的目标函数
% N:粒子数目
% w: 惯性权重
% c1: 学习因子1
% c2: 学习因子2
% 自变量搜索域的最大值：xmax, 行向量
% 自变量搜索域的最小值：xmin  行向量
% M: 最大迭代次数
% D:自变量个数
% xm： 目标函数取最小值时的自变量值
% fv:  目标函数最小值
format long
Vm=0.2*(xmax-xmin);
x=zeros(N,D); v=x; 
for i=1:N
    for j=1:D
        x(i,j)=xmin(j)+rand*(xmax(j)-xmin(j));
        v(i,j)=randn;
    end
end
p=zeros(1,N);f=p;y=x;
for i=1:N
    p(i)=fitness(x(i,:));
end
px=x(N,:); pg=p(N);
for i=1:(N-1)
   if p(i)<pg
       pg=p(i);
       px=x(i,:);
    end
end
for t=1:M
    for i=1:N
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(px-x(i,:));
        for j=1:D
            if v(i,j)>Vm(j)
                v(i,j)=Vm(j);
            end
            if v(i,j)<-Vm(j)
                v(i,j)=-Vm(j);
            end
        end
        x(i,:)=x(i,:)+v(i,:);
        tp1=x(i,:)<=xmax;
        tp2=x(i,:)>=xmin;
        if (sum(tp1)+sum(tp2))==2*D
            f(i)=fitness(x(i,:));
        else
            f(i)=inf;
        end
        if f(i)<p(i)
            p(i)=f(i);
            y(i,:)=x(i,:);
        end
        if p(i)<pg
            pg=p(i);
            px=y(i,:);
        end
    end
end
xm=px';
fv=pg;            
         
             
           
        
        
    