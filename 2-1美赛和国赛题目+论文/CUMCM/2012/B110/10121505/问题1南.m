clc,clear;
m=1010;n=320;
xi(1:1:m,1:1:n)=0;%初始赋0
nan(1,:)=1;nan(m,:)=1;nan(:,1)=1;nan(:,n)=1;%sibian
for x=85:1:265   %门窗：边界标1，内部标2
    for y=80:1:260
        d=sqrt((x-175)^2+(y-170)^2);
        if abs(d-90)<10^(-1)
            nan(x,y)=1;
        end
        if d<90
            nan(x,y)=2;
        end
    end
end
nan(350:1:710,1:1:250)=1;%两扇门
nan(351:1:709,2:1:249)=2;
nan(780:1:890,90:1:230)=1;
nan(781:1:889,91:1:229)=2;
nan1=ones(132,71)*2;%先生成C2的矩阵
nan1(1,:)=1;nan1(132,:)=1;nan1(:,1)=1;nan1(:,71)=1;
for x=2:1:878 %1010-132
    for y=2:1:249 
        if any(any(nan(x:1:x+131,y:1:y+70)))==0
            nan(x:1:x+131,y:1:y+70)=nan1;
        end
    end
end
nan2=ones(82,36)*2;%先生成C10的矩阵
nan2(1,:)=1;nan2(82,:)=1;nan2(:,1)=1;nan2(:,36)=1;
for x=2:1:928 %1010-82
    for y=2:1:284
        if any(any(nan(x:1:x+81,y:1:y+35)))==0
            nan(x:1:x+81,y:1:y+35)=nan2;
        end
    end
end
for i=1:1:m
    for j=1:1:n
        if nan(i,j)==1
            plot(i,j,'b.');hold on;
        end
    end
end