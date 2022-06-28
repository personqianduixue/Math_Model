function f=myfun(x)
%日期序号
day=xlsread('data.xls',1,'B2:B8761');
%水平面总辐射强度
H=xlsread('data.xls',1,'E2:E8761');
%水平面散射辐射强度
Hd=xlsread('data.xls',1,'F2:F8761');
%法向直射辐射强度，×sina等于Hb
Hb_sina=xlsread('data.xls',1,'G2:G8761');
%赤纬角
sigma=xlsread('data.xls',1,'H2:H8761');
%时角
w=xlsread('data.xls',1,'I2:I8761');
%当地纬度
weidu=40.1;
%太阳高度角a的sin值
sina=xlsread('data.xls',1,'K2:K8761');
%水平面日落时角，弧度表示
wh=xlsread('data.xls',1,'M2:M8761');
%倾斜面日落时角，弧度表示
ws=xlsread('data.xls',1,'N2:N8761');
Ho=xlsread('data.xls',1,'Q2:Q8761');
P=0.08;
PI=3.1416;
rad=2*PI/360;
result=0;
for k=1:8760
    r=(cos(rad*(weidu-x))*cos(rad*sigma(k,1))*sin(ws(k,1))+ws(k,1)*sin(rad*(weidu-x))*sin(rad*sigma(k,1)))/(cos(rad*(weidu))*cos(rad*sigma(k,1))*sin(wh(k,1))+wh(k,1)*sin(rad*(weidu))*sin(rad*sigma(k,1)));
    Hb=Hb_sina(k,1)*sina(k,1);
    t=Hb*r+Hd(k,1)*((Hb/Ho(k,1))*r+0.5*(1-(Hb/Ho(k,1)))*(1+cos(rad*x)))+0.5*P*H(k,1)*(1-cos(rad*x));
	%与最低辐射量限值比较
    if(t>=200)
        result=result+t;
    end
end
f=-result;


