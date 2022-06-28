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
n=1:365;
delta=23.5*sin((2*pi*(284+n))/365)*pi/180;
omegat=zeros(1,365);
omegap=zeros(1,365);
flag=0;
for du =-90:0.1:90
    beta=du*pi/180;
    for i=1:365
        omegap(i)=acos(-tan(hpi)*tan(delta(i)));
        omegat(i)=min(omegap(i),acos(-tan(hpi-beta).*tan(delta(i))));
        Rb(i)=(cos(hpi-beta).*cos(delta(i)).*sin(omegat(i))+pi/180*sin(hpi-beta)*sin(delta(i)))./(cos(hpi)*cos(delta(i))*sin(omegap(i))+pi/180*omegap(i)*sin(hpi)*sin(delta(i)));
    end
    data4=zeros(364,1);
    for i=1:365
        data4(24*i-23:24*i,1)=data3(24*i-23:24*i,1).*Rb(i)+(1+cos(beta)).*data2(24*i-23:24*i,1)/2+(1-cos(beta)).*data1(24*i-23:24*i,1)/2*0.25;
    end
    data5=data4;
    data5(find(data5<80))=0;
    power=sum(data5);
    if power>flag
        flag=power;
        zyj=du;
    end
end
disp('最佳倾角')
zyj