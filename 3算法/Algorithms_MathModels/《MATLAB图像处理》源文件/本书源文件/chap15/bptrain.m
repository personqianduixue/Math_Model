function [w,v,theta,r,t,mse]=bptrain(n,p,q,X,Yo,k,emax,cntmax,a1,b1)
%n表示输入神经元个数,p表示中间层神经元个数，q表示输出神经元个数,
%X表示输入训练模式，Yo表示标准输出，k表示训练模式的个数
%emax表示最大误差，cntmax表示最大训练次数，a1，b1表示学习系数，rou表示动量系数
%w、theta表示训练结束后输入层与中间层连接权系数和阈值，
%v、r表示训练结束后中间层与输出层连接权和阈值
%t表示训练时间
tic
w=rands(n,p);%输入层与隐含层连接权
v=rands(p,q); %隐含层与输出层连接权
theta=rands(1,p);%中间层的阈值
r=rands(1,q);%输出层的阈值
cnt=1;
mse=zeros(1,cntmax);%全局误差为零
er=0;
while ((er>emax)|(cnt<=cntmax))
 E=zeros(1,q);
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
        for t=1:q
           c(t)=1/(1+exp(-Y(t))); %输出层输出
        end 
    %计算输出层校正误差d
        for t=1:q 
          d(t)=(Y0(t)-c(t))*c(t)*(1-c(t));
        end
   %计算中间层校正误差e
         xy=d*v';
         for t=1:p
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
                  w(i,j)=w(i,j)+b1*e(j)*X0(i);
              end
              theta(j)=theta(j)+b1*e(j);
           end
           for t=1:q
               E(cp)=(Y0(t)-c(t))*(Y0(t)-c(t))+E(cp);%求当前学习模式的全局误差
           end
           E(cp)=E(cp)*0.5;
    %输入下一模式    
  end
  er=sum(E);%计算全局误差
  mse(cnt)=er;
  cnt=cnt+1;%更新学习次数
 end
 t=toc;
