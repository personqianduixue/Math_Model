clc,clear;
m=1010;n=651;
nanxie(1:1:m,1:1:n)=0;%初始赋0
nanxie(370:1:730,336:1:475)=1;
nanxie(371:1:729,337:1:474)=2;
nanxie(1,:)=1;nanxie(1010,:)=1;nanxie(:,1)=1;nanxie(:,651)=1;
for i=1:1:m
    for j=1:1:n
        if nanxie(i,j)==1 
            plot(i,j,'b.');hold on;
        end
    end
end
nanxie1=ones(158,81)*2;%先生成A3的矩阵
nanxie1(1,:)=1;nanxie1(158,:)=1;nanxie1(:,1)=1;nanxie1(:,80)=1;
for x=2:1:852 %1010-158
    for y=2:1:570 
        if any(any(nanxie(x:1:x+157,y:1:y+80)))==0
            nanxie(x:1:x+157,y:1:y+80)=nanxie1;
        end
    end
end
nanxie2=ones(82,36)*2;%先生成C10的矩阵
nanxie2(1,:)=1;nanxie2(82,:)=1;nanxie2(:,1)=1;nanxie2(:,36)=1;
for x=2:1:928 %1010-82
    for y=2:1:615 
        if any(any(nanxie(x:1:x+81,y:1:y+35)))==0
            nanxie(x:1:x+81,y:1:y+35)=nanxie2;
        end
    end
end

for i=1:1:m
    for j=1:1:n
        if nanxie(i,j)==1
            plot(i,j,'b.');hold on;
        end
    end
end