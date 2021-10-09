clc;clear;close all
%% 数据的读入
data=xlsread('cumcm2012B附件4_山西大同典型气象年逐时参数及各方向辐射强度.xls');
data1=data(:,3);%水平面总辐射强度
data2=data(:,4);%水平面散射辐射强度
data3=data1-data2;%水平面上直射强度
hpi=40.1*pi/180;%大同的纬度
%% 参数符号说明
   
%phi是当地纬度；beta是光伏阵列的倾角；delta为太阳赤纬角；
%omegap为水平面日落时角；romegat为倾斜面日落时角。
%Rb为倾斜面上的直接辐射量与水平面上直接辐射量之比
% Rb=(cos(hpi-beta).*cos(delta).*sin(omegat)+pi/180*sin(hpi-beta)sin(delta))./(cos(hpi)*cos(delta)*sin(omegap)+pi/180*omegap*sin(hpi)*sin(delta))
% delta=23.5*sin((2*pi*(284+n))/365)*pi/180;
% omegap=acos(-tan(hpi)*tan(delta));
% omegat=min(omegap,acos(-tan(hpi-beta)*tan(delta)));


%% 架空铺设
   %选用56块B3多晶硅电池 用一个SN18逆变器
   % B3的参数U=33.6; I=8.33; 价格12.5 尺寸1482*992 转换率15.98%
   % 逆变器的价格 price2=54700  逆变效率97.3%
n=1:365;
beta=38.1*pi/180;%倾斜角38.1
delta=23.5*sin((2*pi*(284+n))/365)*pi/180;
omegat=zeros(1,365);
omegap=zeros(1,365);

for i=1:365
    omegap(i)=acos(-tan(hpi)*tan(delta(i)));
    omegat(i)=min(omegap(i),acos(-tan(hpi-beta).*tan(delta(i))));
    Rb(i)=(cos(hpi-beta).*cos(delta(i)).*sin(omegat(i))+pi/180*sin(hpi-beta)*sin(delta(i)))./(cos(hpi)*cos(delta(i))*sin(omegap(i))+pi/180*omegap(i)*sin(hpi)*sin(delta(i)));
end
data4=zeros(365,1);
for i=1:365
    data4(24*i-23:24*i,1)=data3(24*i-23:24*i,1).*Rb(i)+(1+cos(beta)).*data2(24*i-23:24*i,1)/2+(1-cos(beta)).*data1(24*i-23:24*i,1)/2*0.25;
     
end
data5=data4;
data5(find(data5<80))=0;
 %屋顶光伏电池每年每平米的总光照强度
power1=sum(data5);

U=33.6; I=8.33;  %B3的电压电流
S=1.482*0.992; %B4的面积
m=56; %光伏电池的数目
price1=m*12.5*U*I; %光伏电池的费用
price2=45700;%逆变器SN17的费用
g1=power1*S*m/1000*0.1598*0.973; %每年所发电经济效益


%% 输出结果
disp('35年总的发电量')
G=g1*10+g1*15*0.9+g1*10*0.8
disp('经济效益')
g=g1*0.5;  %光伏电池每年所发发电能量的效益
price=price1+price2; %成本费用
%计算拿回成本的年份
G*0.5-price
disp('拿回成本的年份')
if price/g<10
    nian=price/g
end
if (price/g>10)&(price/g<25)
    nian=(price-g*10)/(g*0.9)+10
else
    nian=(price-g*10-g*15*0.9)/(g*0.8)+25
end

    