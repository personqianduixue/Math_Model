
%%%%%%%%%%%%%%%%每天的光照强度%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%以正午为例%%%%%%%%%%%%%%%%%%%
clear all
clc
alpha00=1:90;
alpha0=alpha00*pi/180;
n0=length(alpha0);
fai=40.1*pi/180;%纬度
gama=0*pi/180;%房屋方位角
Isc=1353;
AA=xlsread('工作表.xlsx');
n=length(AA(:,1));
I_bb=AA(:,4)-AA(:,5);
I_dd=AA(:,5);
I_b0=zeros(365,1);%每一天的直射能量
I_d0=zeros(365,1);%每一天的辐射能量
for i=1:365
for j=1:24
    I_b0(i)=I_b0(i)+I_bb((i-1)*24+j);
    I_d0(i)=I_d0(i)+I_dd((i-1)*24+j);    
end
end
for ii=1:n0
    ii
%alpha=10*pi/180;%斜面偏角
alpha=alpha0(ii);
for i=1:365   

   deta(i)=pi/180*23.45*sin((2*pi*(284+i))/365);%
   w0(i)=acos(-tan(fai)*tan(deta(i)));%水平面上日落时
   I0(i)=24/pi*Isc*(1+0.033*cos(360*i/365))*(cos(fai)*cos(deta(i))*sin(w0(i))+2*pi*w0(i)/360*sin(fai)*sin(deta(i)));%
   %%%大气外水平面太阳辐射强度
   w(i)=0;
   a(i)=sin(deta(i))*(sin(fai)*cos(alpha)-cos(fai)*sin(alpha)*cos(gama));
   b(i)=cos(deta(i))*(cos(fai)*cos(alpha)+sin(fai)*sin(alpha)*cos(gama));
   c(i)=cos(deta(i))*sin(alpha)*sin(gama);
   D(i)=sqrt(b(i)^2+c(i)^2);
   w_ss1(i)=acos(-a(i)/D(i))+asin(c(i)/D(i));
   w_sr1(i)=abs(-acos(-a(i)/D(i))+asin(c(i)/D(i)));
   w_ss(i)=min(w0(i),w_ss1(i));
   w_sr(i)=-min(w0(i),w_sr1(i));
  
   R_b_1(i)=pi/180*(w_ss(i)-w_sr(i))*sin(deta(i))*(sin(fai)*cos(alpha)-cos(fai)*sin(alpha)*cos(gama));
   R_b_2(i)=cos(deta(i))*(sin(w_ss(i))-sin(w_sr(i)))*(cos(fai)*cos(alpha)+sin(fai)*sin(alpha)*cos(gama));
   R_b_3(i)=(cos(w_ss(i))-cos(w_sr(i)))*cos(deta(i))*sin(alpha)*sin(gama);
   R_b_4(i)=2*(cos(fai)*cos(deta(i))*sin(w0(i))+pi/180*sin(fai)*sin(deta(i)));
 
   R_b0(i)=(R_b_1(i)+R_b_2(i)+R_b_3(i));   
    R_b(i)=R_b0(i)/R_b_4(i);
    k=i;  
   
    %C_theta(k)=(sin(fai)*cos(alpha)-cos(fai)*sin(alpha)*cos(gama))*sin(deta(k))+(cos(fai)*cos(alpha)+sin(fai)*sin(alpha)*cos(gama))*cos(deta(k))*cos(w(k))+sin(alpha)*sin(gama)*cos(deta(k))*sin(w(k));
    %C_theta0(k)=sin(fai)*sin(deta(k))+cos(fai)*cos(deta(k))*cos(w(k));
    I_b(k)=I_b0(k)*R_b(k);      
    I_d(k)=I_d0(k)*(I_b0(k)*R_b(k)/I0(k)+0.5*(1-I_b0(k)/I0(k))*(1+cos(alpha)));
    I(k)=I_b(k)+I_d(k);
end
w=w'*pi/180;%时角
   deta=deta';%赤纬角
   

BB=[31,28,31,30,31,30,31,31,30,31,30,31];
CC=[0,31,59,90,120,151,181,212,243,273,304,334];
I_m=zeros(12,1);
for i=1:12
    for j=1:BB(i)
        I_m(i)=I_m(i)+I(CC(i)+j);
    end
end
II_m(:,ii)=I_m;
end
plot(alpha00,II_m,'linewidth',2);
II_m=II_m';
xlabel('倾斜角alpha');
ylabel('月辐射量');
grid on

    