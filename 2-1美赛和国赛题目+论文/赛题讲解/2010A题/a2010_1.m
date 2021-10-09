clc,clear;  %纵向位变模型
global a b L;
a=1.78/2; b=1.2/2; L=2.45; alpha1=0;alpha2=4.1/180*pi;

filename="问题A附件1：实验采集数据表.xls";
A=xlsread(filename,1,'C:C')+262;  % 实际油量 单位升 无未变
B=xlsread(filename,1,'D:D');      % 油面高度 单位 mm
A1=xlsread(filename,3,'C:C')+215;  % 实际油量 单位升 有纵向位变4.1°
B1=xlsread(filename,3,'D:D');

v0=zeros(size(B));
for i=1:length(B)
    v0(i)=f3(B(i)/1000,alpha1); %理论容量数组
end    
v1=zeros(size(B1));
for i=1:length(B1)
    v1(i)=f3(B1(i)/1000,alpha2); %理论容量数组
end

tmp1=zeros(1200,1); tmp2=tmp1;
for i=1:1200
    tmp1(i)=f3(i/1000,alpha1);
    tmp2(i)=f3(i/1000,alpha2);
end

figure
ax1=subplot(2,1,1); ax2=subplot(2,1,2); 
plot(ax1,1:1200,tmp1,1:1200,real(tmp2));
title(ax1,'无位变(蓝）和纵向位变4.1°时的理论油量');
plot(ax2,B,A, B1,A1);
title(ax2,'无位变（蓝）和纵向位变4.1°时的实际油量');
c0=v0-A;c1=v1-A1;
figure
ax1=subplot(2,2,1);
plot(ax1,B,v0,B,A,'--');   %可以看出理论油量和实际油量的偏差
title(ax1,'理论油量(蓝）和实际油量，无位变')
ax2=subplot(2,2,3);
plot(ax2,B,c0);     %理论油量和实际油量的偏差
title(ax2,'理论油量与实际油量的差值，无位变');

ax3=subplot(2,2,2);
plot(ax3,B1,v1,B1,A1,'--');   %可以看出理论油量和实际油量的偏差
title(ax3,'理论油量(蓝)和实际油量，纵向位变4.1°')
ax4=subplot(2,2,4);
plot(ax4,B1,c1);     %理论油量和实际油量的偏差
title(ax4,'理论油量与实际油量的差值，纵向位变4.1°');


c2=zeros(size(B1));
for i=1:length(B1)
    c2(i,1)=f4(B1(i));
end
tmp=c1-c2;
c=sum(tmp)/length(tmp);

%由出油量验证误差
A3=xlsread(filename,2,'C:C'); % 累加出油量 单位升 无未变
B3=xlsread(filename,2,'D:D');      % 油面高度 单位 mm

t1=f3(B3(1)/1000,alpha1)-f4(B3(1))+A3(1);

v3=zeros(size(B3));
for i=1:length(B3)
    v3(i)=t1-f3(B3(i)/1000,alpha1)+f4(B3(i));
end


A4=xlsread(filename,4,'C:C');  % 累加出油量 单位升 纵向位变4.1°
B4=xlsread(filename,4,'D:D');      % 油面高度 单位 mm

%出油量数据验证（使用位变误差）
t2=f3(B4(1)/1000,alpha2)-f5(B4(1))+A4(1);

v4=zeros(size(B4));
for i=1:length(B4)
    v4(i)=t2-f3(B4(i)/1000,alpha2)+f5(B4(i));
end

tmp1=f3(B4(1)/1000,alpha2)-f5(B4(1));

v5=zeros(length(B4)-1,1);
for i=1:length(B4)-1
    tmp2=f3(B4(i+1)/1000,alpha2)-f5(B4(i+1));
    v5(i)=tmp1-tmp2;
    tmp1=tmp2;
end

%出油量数据验证（使用无变位误差）
t3=f3(B4(1)/1000,alpha2)-f4(B4(1))-c+A4(1);

v6=zeros(size(B4));
for i=1:length(B4)
    v6(i)=t3-f3(B4(i)/1000,alpha2)+f4(B4(i))+c;
end

tmp1=f3(B4(1)/1000,alpha2)-f4(B4(1));
v7=zeros(length(B4)-1,1);
for i=1:length(B4)-1
    tmp2=f3(B4(i+1)/1000,alpha2)-f4(B4(i+1));
    v7(i)=tmp1-tmp2;
    tmp1=tmp2;
end

tmp1=v3-A3;tmp2=v4-A4; tmp3=v6-A4;%理论累加出油量和实际累加出油量的差值

figure
ax1=subplot(5,1,1);ax2=subplot(5,1,2);ax3=subplot(5,1,3);ax4=subplot(5,1,4);ax5=subplot(5,1,5);
plot(ax1,B3,tmp1);   
title(ax1,'理论累加出油量和实际累加出油量差值，无位变');

plot(ax2,B4,tmp2);
title(ax2,'理论累加出油量和实际累加出油量差值(使用变位误差计算)，纵向夹角4.1°');

plot(ax3,B4,tmp3);
title(ax3,'理论累加出油量和实际累加出油量差值（使用无变位误差计算），纵向夹角4.1°');

plot(ax4,1:length(B4)-1,v5);
title(ax4,'由位变误差计算的理论每次出油量（50），纵向夹角4.1°');

plot(ax5,1:length(B4)-1,v7);
title(ax5,'由无位变误差计算的理论每次出油量（50），纵向夹角4.1°');

%油量标定4.1°的情形
youliang=zeros(121,1);
for i=0:120
    youliang(i+1)=f3(i/100,alpha2)-f4(10*i)-c;
end

figure
plot(0:10:1200,youliang,B1,A1);
title('标定的油量与实际油量（4.1°）');

function s=f(h) %高h的椭圆截面面积
global a b;
  s=a*b.*acos((b-h)/b)-(b-h).*a.*sqrt(1-(h-b).^2/b^2);
end


function l=f1(h,alpha) %当油面标高为h时，垂直于h方向的柱面高度函数 x(h)
   global L;
   h1=2.05*tan(alpha);
   if alpha==0
       l=L;
   elseif h<=h1
       l=0.4+cot(alpha)*h;
   else 
       l=L;
   end
end


function height=f2(x,h,alpha) %当油面标高位h时，在x处的椭圆截面高度   h(l)
    global b;
    if alpha==0
        height=h*ones(size(x));
    else
        h2=2*b-0.4*tan(alpha);
        tmp=0.4-(2*b-h)*cot(alpha);
        if h<=h2
            height=h+(0.4-x)*tan(alpha);
        else
            height=2*(x<=tmp).*b+(x>tmp).*(h+(0.4-x).*tan(alpha));
        end
    end
end

function v=f3(h,alpha)  %油面标高h时的理论油量
    v=integral(@(x) f(f2(x,h,alpha)),0,f1(h,alpha))*1000;
end


%由cftool拟合管线的容积
function p=f4(h)  %容量偏差函数 h 单位(mm), 无位变
    p=-8.403e-08*h.^3+0.0001506*h.^2+0.05822*h-1.711;
end

function p=f5(h)  %容量偏差函数 有位变alpha=4.1
   p=2.881e-07*h.^2-0.001026*h.^2+1.023*h-222.1;
end