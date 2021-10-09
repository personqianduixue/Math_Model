clear;clc
fushe=xlsread('cumcm.xls','sheet','E4:K8763');
dc=xlsread('cumcm.xls','sheet1','B1:K24');
nbq=xlsread('cumcm.xls','sheet2','A1:M18');%逆变器的信息
d=xlsread('cumcm.xls','sheet3','A27:D37304');%排列信息
sp_zs=fushe(:,1)-fushe(:,2);
n_zs=fushe(:,5)-0.5*fushe(:,2);
d_zs=fushe(:,4)-0.5*fushe(:,2);
x_zs=fushe(:,6)-0.5*fushe(:,2);
fdl=[];
N=23;%各面的面积

a=pi/2;%倾斜角
b=-pi/2;%方位角
for m=1:24

        sa=sin(a);ca=cos(a);
        sb=sin(b);cb=cos(b);
        if sb<0
            fushe_ry=-d_zs*sa*sb+n_zs*sa*cb+sp_zs*ca+fushe(:,2)*(pi-a)/pi;
        else fushe_ry=x_zs*sa*sb+n_zs*sa*cb+sp_zs*ca+fushe(:,2)*(pi-a)/pi;
        end
        for k=1:8760
            if fushe_ry(k)<dc(m,9)
                fushe_ry(k)=0;
            end
            if fushe_ry(k)<200
                fushe_ry(k)=fushe_ry(k)*dc(m,8);
            end
            fushe_ry(k)=fushe_ry(k)*dc(m,10);
        end
S(m)=sum(fushe_ry*dc(m,1)/1000)/1000;
end
S=S'
c=S;
Q=[];
r=[];
for i=1:37278
    q=d(i,3)*d(i,4)*c(d(i,2))*nbq(d(i,1),10)*0.5*31.5-nbq(d(i,1),13)-d(i,3)*d(i,4)*dc(d(i,2),6);
    q_=q/(d(i,3)*d(i,4)*dc(d(i,2),7));
    Q=[Q;d(i,:),q,d(i,3)*d(i,4)*c(d(i,2))*nbq(d(i,1),10)*0.5,q_,(d(i,3)*d(i,4)*dc(d(i,2),7)),c(d(i,2))];

    if (d(i,3)*d(i,4)*dc(d(i,2),7))>N
        r=[r;i];
    end
end
Q(r,:)=[];