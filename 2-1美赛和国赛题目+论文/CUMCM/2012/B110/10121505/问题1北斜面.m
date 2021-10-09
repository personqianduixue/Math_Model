clc,clear;
m=1010;n=139;
beixiemian(1:1:m,1:1:n)=1;%初始赋0,1
beixiemian(2:1:m-1,2:1:n-1)=0;
beixiemian1=ones(130,110)*2;%先生成C1的矩阵
beixiemian1(1,:)=1;beixiemian1(130,:)=1;beixiemian1(:,1)=1;beixiemian1(:,110)=1;
for x=2:1:880 %1010-130
    for y=2:1:29 
        if any(any(beixiemian(x:1:x+129,y:1:y+109)))==0
            beixiemian(x:1:x+129,y:1:y+109)=beixiemian1;
        end
    end
end
beixiemian2=ones(82,36)*2;%先生成C10的矩阵
beixiemian2(1,:)=1;beixiemian2(82,:)=1;beixiemian2(:,1)=1;beixiemian2(:,36)=1;
for x=2:1:928 %1010-82
    for y=2:1:103 
        if any(any(beixiemian(x:1:x+81,y:1:y+35)))==0
            beixiemian(x:1:x+81,y:1:y+35)=beixiemian2;
        end
    end
end
for i=1:1:m
    for j=1:1:n
        if beixiemian(i,j)==1
            plot(i,j,'b.');hold on;
        end
    end
end