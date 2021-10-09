clear;clc
a=xlsread('cumcm.xls','sheet1','B1:H24');%电池的信息
b=xlsread('cumcm.xls','sheet2','A1:M18');%逆变器的信息
c=xlsread('cumcm.xls','sheet3','B1:F24');%发电量
d=xlsread('cumcm.xls','sheet3','A27:D37304');%排列信息
Q=[];
f=4;%方向，东向为2
N=26;%各面的面积
r=[];
for i=1:37278
    q=d(i,3)*d(i,4)*c(d(i,2),f)*b(d(i,1),10)*0.5*31.5-b(d(i,1),13)-d(i,3)*d(i,4)*a(d(i,2),6);
    q_=q/(d(i,3)*d(i,4)*a(d(i,2),7));
    Q=[Q;d(i,:),q,q_,(d(i,3)*d(i,4)*a(d(i,2),7))];

    if (d(i,3)*d(i,4)*a(d(i,2),7))>N
        r=[r;i];
    end
end
Q(r,:)=[];