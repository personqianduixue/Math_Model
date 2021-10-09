clear;clc
fushe=xlsread('cumcm.xls','sheet','E4:L8763');
dianban=xlsread('cumcm.xls','sheet1','B1:F24');
tz_zs=fushe(:,1)-fushe(:,2);
nx_zs=fushe(:,5)-0.5*fushe(:,2);
thta=33/57.3;
sa=sin(thta);ca=cos(thta);
fushe_renyi=tz_zs*ca+nx_zs*sa+fushe(:,2)*(pi-thta)/pi;
P=295;%组件额定功率
p0=80;%最低强度，单晶硅多晶硅为80，薄膜为30
for i=1:8760
    for j=1:8
        if fushe(i,j)<p0
            fushe(i,j)=0;
        end
    end
end
for i=1:8760%单晶硅的需要，另外两种不要
    for j=1:8
        if fushe(i,j)<200
            fushe(i,j)=fushe(i,j)*0.05;
        end
    end
end
Q=sum(fushe*P/1000)/1000;

