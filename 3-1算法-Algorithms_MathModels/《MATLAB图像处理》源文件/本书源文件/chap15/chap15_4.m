clear all;  			%清除工作空间，关闭图形窗口，清除命令行
close all;
clc;
N=128;								%定义图像大小，椭圆个数，投影数 
NUM=10;
PROJ=180;
[sp,axes_x,axes_y,pixel]=headata(N) %创建仿真头模型数据
degree=projdata(PROJ,N);            %从头模型产生投影函数
[axes_x,h]=RLfilter(N);             %创建滤波函数
 m=N;
 n=NUM;
 k=PROJ;
 F=zeros(m,m);                      %参数初始化
 for k=1:PROJ
    for j=1:N-1                                     
      sn(j)=0;                                     
      for i=1:N-1
        sn(j)=sn(j)+h(j+N-i)*degree(k,i);		%计算Qtheta，投影数据与滤波函数卷积
      end
    end
    
 for i=1:N
     for j=1:N
       cq=N/2-(N-1)*(cos(k*pi/PROJ)+sin(k*pi/PROJ))/2;			%从投影数据重建图像
	   s2=((i-1)*cos(k*pi/PROJ)+(j-1)*sin(k*pi/PROJ)+cq);
	   n0=fix(s2);%整数部分
       s4=s2-n0;%小数部分
       if((n0>=1) && ((n0+1)<N))
         F(j,i)=F(j,i)+(1.0-s4)*sn(n0)+s4*sn(n0+1);
       end
     end
   end
 end
set(0,'defaultFigurePosition',[100,100,1200,450]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置 
figure,
subplot(121),pcolor(pixel);
subplot(122),pcolor(F)					%显示重构图像
