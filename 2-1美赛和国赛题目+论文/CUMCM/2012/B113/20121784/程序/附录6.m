%正南方向的最佳gama的求解
clc;
clear;
format long
H=dlmread('Sun_Battery_Sunlight.txt');
t=dlmread('Sun_T.txt');
t=t+1;
G=40.1/180*pi;%当地纬度
p=0.2;%地表的平均反射率
HT=[];
result=[];
B=36.6/180*pi;
for r=-pi/3:0.01:-pi/3
   for k=1:length(H)
    w=15*(t(k)-12)/180*pi;
    Q=23.45*sin(2*pi*(284+ceil(k/24))/365)/180*pi;%太阳赤纬角
    H(k,3)=H(k,3)*(sin(G)*sin(Q)+cos(G)*cos(Q)*cos(w));
    ws=acos(-tan(G)*tan(Q));
    a=sin(Q)*(sin(G)*cos(B)-cos(G)*sin(B)*cos(r));
    b=cos(Q)*(cos(G)*cos(B)+sin(G)*sin(B)*cos(r));
    c=cos(Q)*sin(B)*sin(r);
    D=(b^2+c^2)^(1/2);
    wss=min(ws,acos(-a/D)+asin(c/D));
    wsr=-min(ws,abs(-acos(-a/D)+asin(c/D)));
    Rb=(pi/180*(wss-wsr)*sin(Q)*(sin(G)*cos(B)-cos(G)*sin(B)*cos(r))+cos(Q)*(sin(wss)-sin(wsr))*(cos(G)*cos(B)+sin(G)*sin(B)*cos(r))+(cos(wss)-cos(wsr)*cos(Q)*sin(B)*sin(r)))/(2*(cos(G)*cos(Q)*sin(ws)+pi/180*sin(G)*sin(Q)));
    Ho=24/pi*1.1*(1+360*ceil(k/24)/365*0.033)*(cos(G)*cos(Q)*sin(ws)+pi/180*ws*sin(G)*sin(Q));
    HT(k)=H(k,3)*Rb+H(k,2)*((H(k,1)-H(k,2))/Ho*Rb+(1+cos(B))/2*(1-(H(k,1)-H(k,2))/Ho))+H(k,1)*(1-cos(B))/2*p;
   end
   result=[result;r+pi/2.65,sum(HT)/10^6-1.1];
end
[Y,U]=max(result(:,2))
Best=result(U,1)*180/pi
HTmax=Y*10^6
