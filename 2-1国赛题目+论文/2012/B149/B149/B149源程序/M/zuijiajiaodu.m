clear;clc
fushe=xlsread('cumcm.xls','sheet','E4:K8763');
dc=xlsread('cumcm.xls','sheet1','B1:J24');
sp_zs=fushe(:,1)-fushe(:,2);
n_zs=fushe(:,5)-0.5*fushe(:,2);
d_zs=fushe(:,4)-0.5*fushe(:,2);
x_zs=fushe(:,6)-0.5*fushe(:,2);
fdl=[];

%for i=1:91
    for j=1:181
    i=91;
        a=(i-1)*pi/180;b=(j-91)*pi/180;
        sa=sin(a);ca=cos(a);
        sb=sin(b);cb=cos(b);
        if sb<0
            fushe_ry=-d_zs*sa*sb+n_zs*sa*cb+sp_zs*ca+fushe(:,2)*(pi-a)/pi;
        else fushe_ry=x_zs*sa*sb+n_zs*sa*cb+sp_zs*ca+fushe(:,2)*(pi-a)/pi;
        end
        %计算月发电量
        S(1,j)=sum(fushe_ry(1:744));
        S(2,j)=sum(fushe_ry(745:1416));
        S(3,j)=sum(fushe_ry(1417:2160));
        S(4,j)=sum(fushe_ry(2161:2880));
        S(5,j)=sum(fushe_ry(2881:3624));
        S(6,j)=sum(fushe_ry(3625:4344));
        S(7,j)=sum(fushe_ry(4345:5088));
        S(8,j)=sum(fushe_ry(5089:5832));
        S(9,j)=sum(fushe_ry(5833:6552));
        S(10,j)=sum(fushe_ry(6553:7296));
        S(11,j)=sum(fushe_ry(7297:8016));
        S(12,j)=sum(fushe_ry(8017:8760));

    %end
end
x=1:181
plot(x,S)

%[x y]=find(S==max(max(S)))

