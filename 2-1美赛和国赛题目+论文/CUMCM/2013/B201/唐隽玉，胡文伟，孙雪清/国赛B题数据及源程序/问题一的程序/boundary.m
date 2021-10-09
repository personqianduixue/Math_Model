clear;clc
m=1;n=1;
for k=0:18
    if k>=10
        t=strcat('0',int2str(k),'.bmp');
        a1{m}=jz01zh((imread(t)));
        m=m+1;
    end
    if k<10
        t=strcat('00',int2str(k),'.bmp');
        a2{n}=jz01zh((imread(t)));
        n=n+1;
    end
end

a=[a2,a1];
for k=1:19
    temp=a{k};
    [row col]=size(temp);
    br=temp(:,col);
    bl=temp(:,1);
    bound{k}=[bl,br];
end