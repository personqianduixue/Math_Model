clc;
clear;
H=dlmread('Sun_Battery_Sunlight.txt');
t=dlmread('Sun_T.txt');
t=t+1;
B=36.6/180*pi;
%B=atan(12/64);%大斜面屋顶与水平面的夹角
G=40.1/180*pi;%当地纬度
p=0.2;%地表的平均反射率
Hmax=[];

for k=1:length(H)
    w=15*(t(k)-12)/180*pi;
    Q=23.45*sin(2*pi*(284+ceil(k/24))/365)/180*pi;%太阳赤纬角
    a=asin(sin(G)*sin(Q)+cos(G)*cos(Q)*cos(w));
    if a>0 & a<pi/2
    H(k,3)=H(k,3)*sin(a);
    ws=acos(-tan(G)*tan(Q));
    wst=min(ws,acos(-tan(G-B)*tan(Q)));
    Rb=(cos(G-B)*cos(Q)*sin(wst)+pi/180*wst*sin(G-B)*sin(Q))/(cos(G)*cos(Q)*sin(ws)+pi/180*ws*sin(G)*sin(Q));
    Ho=24/pi*1.1*(1+360*ceil(k/24)/365*0.033)*(cos(G)*cos(Q)*sin(ws)+pi/180*ws*sin(G)*sin(Q));
    Hmax(k)=H(k,3)*Rb+H(k,2)*((H(k,1)-H(k,2))/Ho*Rb+(1+cos(B))/2*(1-(H(k,1)-H(k,2))/Ho))+H(k,1)*(1-cos(B))/2*p;
    end
end
%Hmax(Hmax<80)=0;
dlmwrite('Sun_Hmax.txt',Hmax);

Hmax_max=max(Hmax)
Hmax_min=min(Hmax)
Hmax_sum=sum(Hmax)
