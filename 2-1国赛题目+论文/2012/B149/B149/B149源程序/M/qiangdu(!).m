clear;clc
fushe=xlsread('cumcm.xls','sheet','C4:K8763');
w=[];dta=[];
for i=1:8760
    w(i)=15*(fushe(i,1)-12)/57.3;%时角、弧度
    n=ceil(i/24);
    dta(i)=23.45*sin(2*pi*(284+n)/365)/57.3;%赤纬角、弧度
    sa(i)=sin(0.7)*sin(dta(i))+cos(0.7)*cos(dta(i))*cos(w(i));%太阳高度角、正弦
    cA(i)=(sin(dta(i))-sa(i)*sin(0.7))/((sqrt(1-sa(i)^2))*cos(0.7));%太阳方位角、余弦
    if w(i)<0
        A(i)=acos(cA(i));
    else A(i)=2*pi-acos(cA(i));
    end
    sb(i)=sin(A(i)-0.5*pi)*sqrt(1-sa(i)^2);

    re(i)=fushe(i,7)-0.5*fushe(i,4)-fushe(i,5)*sb(i);

end