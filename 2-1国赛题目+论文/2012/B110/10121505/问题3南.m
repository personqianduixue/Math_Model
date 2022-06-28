clc,clear;
m=1500;n=280;
xi(1:1:m,1:1:n)=0;%初始赋0
nanmian(1,:)=1;nanmian(m,:)=1;nanmian(:,1)=1;nanmian(:,n)=1;%sibian
nanmian(690:1:810,1:1:200)=3;%一扇门
nanmian(691:1:809,2:1:199)=2;
nanmian1=ones(132,71)*2;%先生成C2的矩阵
nanmian1(1,:)=1;nanmian1(132,:)=1;nanmian1(:,1)=1;nanmian1(:,71)=1;
jishu=0;
for x=2:1:1368 %1500-132
    for y=2:1:209 
        if any(any(nanmian(x:1:x+131,y:1:y+70)))==0
            nanmian(x:1:x+131,y:1:y+70)=nanmian1;jishu=jishu+1;
        end
    end
end
jishu
nanmian2=ones(82,36)*2;%先生成C10的矩阵
nanmian2(1,:)=1;nanmian2(82,:)=1;nanmian2(:,1)=1;nanmian2(:,36)=1;
jishu=0;
for x=2:1:1418 %1500-82
    for y=2:1:244 
        if any(any(nanmian(x:1:x+81,y:1:y+35)))==0
            nanmian(x:1:x+81,y:1:y+35)=nanmian2;jishu=jishu+1;
        end
    end
end
jishu
for i=1:1:m
    for j=1:1:n
        if nanmian(i,j)==1
            plot(i,j,'b.');hold on;
        end
        if nanmian(i,j)==3
            plot(i,j,'r.');hold on;
        end
    end
end