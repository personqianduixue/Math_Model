%用遗传算法进行简单函数的优化
clear,clc

bn=22; %个体串长度
inn=50; %初始种群大小
gnmax=200;  %最大代数
pc=0.75; %交叉概率
pm=0.05; %变异概率

%产生初始种群
s=round(rand(inn,bn));

%计算适应度,返回适应度f和累积概率p
[f,p]=objf(s);  

gn=1;
while gn<gnmax+1
   for j=1:2:inn
      
      %选择操作
      seln=sel(s,p);
      
      %交叉操作
      scro=cro(s,seln,pc);
      scnew(j,:)=scro(1,:);
      scnew(j+1,:)=scro(2,:);
      
      %变异操作
      smnew(j,:)=mut(scnew(j,:),pm);
      smnew(j+1,:)=mut(scnew(j+1,:),pm);
   end
   s=smnew;  %产生了新的种群
   
   %计算新种群的适应度   
   [f,p]=objf(s);
   
   %记录当前代最好和平均的适应度
   [fmax,nmax]=max(f);
   fmean=mean(f);
   ymax(gn)=fmax;
   ymean(gn)=fmean;
   %记录当前代的最佳个体
   x=n2to10(s(nmax,:));
   xx=-1.0+x*3/(power(2,bn)-1);
   xmax(gn)=xx;
   
   gn=gn+1
end
gn=gn-1;

%绘制曲线
subplot(2,1,1);
plot(1:gn,[ymax;ymean]);
title('历代适应度变化');
legend('最大适应度','平均适应度');
string1=['最终适应度',num2str(ymax(gn))];
gtext(string1);
subplot(2,1,2);
plot(1:gn,xmax,'r-');
legend('自变量');
string2=['最终自变量',num2str(xmax(gn))];
gtext(string2);