clc,clear;
m=1500;n=621;
nanxiemian(1:1:m,1:1:n)=0;%初始赋0
nanxiemian(1,:)=1;nanxiemian(1500,:)=1;nanxiemian(:,1)=1;nanxiemian(:,621)=1;
nanxiemian1=ones(158,81)*2;%先生成A3的矩阵
nanxiemian1(1,:)=1;nanxiemian1(158,:)=1;nanxiemian1(:,1)=1;nanxiemian1(:,80)=1;
for x=2:1:1342 %1500-158
    for y=2:1:540 
        if any(any(nanxiemian(x:1:x+157,y:1:y+80)))==0
            nanxiemian(x:1:x+157,y:1:y+80)=nanxiemian1;
        end
    end
end
nanxiemian2=ones(82,36)*2;%先生成C10的矩阵
nanxiemian2(1,:)=1;nanxiemian2(82,:)=1;nanxiemian2(:,1)=1;nanxiemian2(:,36)=1;
for x=2:1:1418 %1500-82
    for y=2:1:585 
        if any(any(nanxiemian(x:1:x+81,y:1:y+35)))==0
            nanxiemian(x:1:x+81,y:1:y+35)=nanxiemian2;
        end
    end
end

for i=1:1:m
    for j=1:1:n
        if nanxiemian(i,j)==1
            plot(i,j,'b.');hold on;
        end
    end
end