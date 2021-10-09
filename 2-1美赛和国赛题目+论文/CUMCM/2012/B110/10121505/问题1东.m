clc,clear;
m=710;n=440;
dong(1:1:m,1:1:n)=0;%初始赋0
for i=1:1:640
    dong(i,floor(321+i*12/64):1:440)=2;
end
for i=1:1:640
    dong(i,floor(320+(710-i)*12/7):1:440)=2;
end
for i=1:1:710
    if i<640
        j=floor(321+i*12/64);
    else
        j=floor(320+(710-i)*12/7);
    end
    dong(i,j)=1;
end
dong(340:1:450,1:1:250)=1;%men标记
dong(1,1:1:320)=1;dong(710,1:1:320)=1;dong(1:1:710,1)=1;%sanbian
dong1=ones(130,110)*2;%先生成C1的矩阵
dong1(1,:)=1;dong1(130,:)=1;dong1(:,1)=1;dong1(:,110)=1;
for x=2:1:579 %710-130
    for y=2:1:329 
        if any(any(dong(x:1:x+129,y:1:y+109)))==0
            dong(x:1:x+129,y:1:y+109)=dong1;
        end
    end
end
dong2=ones(82,36)*2;%先生成C10的矩阵
dong2(1,:)=1;dong2(82,:)=1;dong2(:,1)=1;dong2(:,36)=1;
for x=2:1:628 %710-82
    for y=2:1:404 
        if any(any(dong(x:1:x+81,y:1:y+35)))==0
            dong(x:1:x+81,y:1:y+35)=dong2;
        end
    end
end
for i=1:1:m
    for j=1:1:n
        if dong(i,j)==1
            plot(i,j,'b.');hold on;
        end
    end
end