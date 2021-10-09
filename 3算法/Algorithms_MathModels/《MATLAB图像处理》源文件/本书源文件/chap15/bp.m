function [w,v]=bptrain(n,p,q,X,Y,k,emax,cntmax)
clear all;
close all;
clc
tic
n='输入神经元个数:16';   %输入层神经元
disp(n)
p='中间层神经元个数:8';    %中间层神经元 
disp(p)
q='输出层神经元个数:3';    %输出层神经元
disp(q)
X1=[1 1 1 1, 1 0 0 1, 1 1 1 1, 1 0 0 1];  %识别模式
X2=[0 1 0 0, 0 1 0 0, 0 1 0 0, 0 1 0 0];
X3=[1 1 1 1, 1 0 0 1, 1 0 0 1, 1 1 1 1];
X=[X1;X2;X3];
Y1=[1 0 0];                           %输出模式           
Y2=[0 1 0];
Y3=[0 0 1];
Yo=[Y1;Y2;Y3];
n=16; %输入层神经元个数
p=8;  %中间层神经元个数
q=3;  %输出神经元个数
k=3 ;%训练模式个数
w=rands(n,p);%输入层与隐含层连接权
v=rands(p,q); %隐含层与输出层连接权
theta=rands(1,p);%中间层的阈值
r=rands(1,q);%输出层的阈值
a1=0.1, b1=0.1, %学习系数，
E=zeros(1,q);
emax=0.01, cntmax=100;%最大误差，训练次数
cnt=1;
er=0;%全局误差为零
while ((er>emax)|(cnt<=cntmax))
 %循环识别模式 
 for cp=1:k
     X0=X(cp,:);             
     Y0=Yo(cp,:);
     %计算中间层的输入Y(j) 
     Y=X0*w; 
     %计算中间层的输出b
     Y=Y-theta;    %中间层阈值
     for j=1:p
         b(j)=1/(1+exp(-Y(j)));%中间层输出f(sj)
     end      
    %计算输出层输出c
             Y=b*v;
             Y=Y-r;  % 输出层阈值
        for t=1:3
           c(t)=1/(1+exp(-Y(t))); %输出层输出
        end 
    %计算输出层校正误差d
        for t=1:3 
          d(t)=(Y0(t)-c(t))*c(t)*(1-c(t));
        end
   %计算中间层校正误差e
         xy=d*v';
         for t=1:8
           e(t)=xy(t)*b(t)*(1-b(t));
         end
   %计算下一次的中间层和输出层之间新的连接权v(i,j),阈值t2(j)
          for t=1:q
              for j=1:p
                  v(j,t)=v(j,t)+a1*d(t)*b(j);
              end
              r(t)=r(t)+a1*d(t);
          end
      %计算下一次的输入层和中间层之间新的连接权w(i,j),阈值t1(j)
           for j=1:p
              for i=1:n
                  w(i,j)=w(i,j)+b1*e(j)*X0(i)
              end
              theta(j)=theta(j)+b1*e(j)
           end
           for t=1:q
               E(cp)=(Y0(t)-c(t))*(Y0(t)-c(t))+E(cp);%求当前学习模式的全局误差
           end
            E(cp)=E(cp)*0.5;
    %输入下一模式    
 end
  er=max(E);%计算全局误差
  cnt=cnt+1;%更新学习次数
end
 time=toc;
 %重新训练 
 %S='训练次数:';
 %disp(S);
 %disp(cnt);
 %S='输出层权值:';
 %disp(S);
 %disp(v);
 %S='中间层权值:';
 %disp(S);
 %disp(w);