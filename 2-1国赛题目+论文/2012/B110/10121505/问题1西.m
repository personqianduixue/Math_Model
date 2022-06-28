clc,clear;
m=710;n=440;
xi(1:1:m,1:1:n)=0;%初始赋0
for i=1:1:70
    xi(i,floor(320+i*12/7):1:440)=2;
end
for i=70:1:710
    xi(i,floor(320+(710-i)*12/64):1:440)=2;
end
for i=1:1:710
    if i<70
        j=floor(320+i*12/7);
    else
        j=floor(320+(710-i)*12/64);
    end
    xi(i,j)=1;
end
xi(1,1:1:320)=1;xi(710,1:1:320)=1;xi(1:1:710,1)=1;%sanbian
xi1=ones(130,110)*2;%先生成C1的矩阵
xi1(1,:)=1;xi1(130,:)=1;xi1(:,1)=1;xi1(:,110)=1;
for x=2:1:580 %710-130
    for y=2:1:330 
        if any(any(xi(x:1:x+129,y:1:y+109)))==0
            xi(x:1:x+129,y:1:y+109)=xi1;
        end
    end
end
xi3=ones(82,36)*2;%先生成电池矩阵C10
xi3(1,:)=1;xi3(82,:)=1;xi3(:,1)=1;xi3(:,36)=1;
for x=2:1:628 
    for y=2:1:404 
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