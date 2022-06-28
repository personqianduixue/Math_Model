%用遗传算法进行简单函数的优化,可以显示中间过程
clear

bn=22; %个体串长度
inn=50; %初始种群大小
gnmax=200;  %最大代数
pc=0.8; %交叉概率
pm=0.05; %变异概率

%产生初始种群
s=round(rand(inn,bn));

gnf1=5;
gnf2=20;

%计算适应度,返回适应度f和累积概率p
[f,p]=objf(s);  

gn=1;
while gn<gnmax+1
    xp=-1:0.01:2;
    yp=ft(xp);
    for d=1:inn
        xi=n2to10(s(d,:));
        xdi(d)=-1.0+xi*3/(power(2,bn)-1);
    end
    yi=ft(xdi);
    plot(xp,yp,'b-',xdi,yi,'g*');
    strt=['当前代数 gn=' num2str(gn)];
    text(-0.75,1,strt);
    text(-0.75,3.5,'*  当前种群','Color','g');
    if gn<gnf1
        pause;
    end
    hold on;
           
    for j=1:2:inn
      %选择操作
      seln=sel(s,p);
      xs1=n2to10(s(seln(1),:));
      xds1=-1.0+xs1*3/(power(2,bn)-1);
      ys1=ft(xds1);
      xs2=n2to10(s(seln(2),:));
      xds2=-1.0+xs2*3/(power(2,bn)-1);
      ys2=ft(xds2);
      hold on;
      drawnow;
      plot(xds1,ys1,'r*',xds2,ys2,'r*');
      %交叉操作
      scro=cro(s,seln,pc);
      scnew(j,:)=scro(1,:);
      scnew(j+1,:)=scro(2,:);
      
      %变异操作
      smnew(j,:)=mut(scnew(j,:),pm);
      smnew(j+1,:)=mut(scnew(j+1,:),pm);
      
  end
  drawnow;
  text(-0.75,3.3,'*  选择后','Color','r');
  if gn<gnf1
      pause;
  end
  
  for d=1:inn
      xc=n2to10(scnew(d,:));
      xdc(d)=-1.0+xc*3/(power(2,bn)-1);
  end
  yc=ft(xdc);
  drawnow;
  plot(xdc,yc,'m*');
  text(-0.75,3.1,'*  交叉后','Color','m');
  if gn<gnf1
      pause;
  end
  hold on;
  
  for d=1:inn
      xm=n2to10(smnew(d,:));
      xdm(d)=-1.0+xm*3/(power(2,bn)-1);
  end
  ym=ft(xdm);
  drawnow;
  plot(xdm,ym,'c*');
  text(-0.75,2.9,'*  变异后','Color','c');
  
  if gn<gnf2
      pause;
  end
  hold off;
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
   
   gn=gn+1;
end
gn=gn-1;

figure(2);
subplot(2,1,1);
plot(1:gn,[ymax;ymean]);
title('历代适应度变化','fonts',10);
legend('最大适应度','平均适应度');
string1=['最终适应度',num2str(ymax(gn))];
gtext(string1);
subplot(2,1,2);
plot(1:gn,xmax,'r-');
legend('自变量');
string2=['最终自变量',num2str(xmax(gn))];
gtext(string2);
