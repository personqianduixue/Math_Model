clc,clear;
m=332;n=539;
xi(1:1:m,1:1:n)=0;%初始赋0
for i=1:1:332
    j=floor(539-i*259/332);
    xi(i,j)=1;
end
for i=1:1:332
    for j=floor(540-i*259/332):1:539;
        xi(i,j)=2;
    end
end
xi(1,:)=1;xi(332,1:1:280)=1;xi(:,1)=1;%sanbian
xi1=ones(130,110)*2;%先生成C1的矩阵
xi1(1,:)=1;xi1(130,:)=1;xi1(:,1)=1;xi1(:,110)=1;
for x=2:1:202 %332-130
    for y=2:1:429 
        if any(any(xi(x:1:x+129,y:1:y+109)))==0
            xi(x:1:x+129,y:1:y+109)=xi1;
        end
    end
end
xi3=ones(82,36)*2;%先生成电池矩阵C10
xi3(1,:)=1;xi3(82,:)=1;xi3(:,1)=1;xi3(:,36)=1;
for x=2:1:250 
    for y=2:1:503 
        if any(any(xi(x:1:x+81,y:1:y+35)))==0
            xi(x:1:x+81,y:1:y+35)=xi3;
        end
    end
end
for i=1:1:m
    for j=1:1:n
        if xi(i,j)==1
            plot(i,j,'b.');hold on;
        end
    end
end