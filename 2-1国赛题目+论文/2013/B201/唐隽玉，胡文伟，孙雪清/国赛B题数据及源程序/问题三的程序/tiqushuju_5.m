clear;clc
m=1;n=1;q=1;
for k=0:208
    if k<10 
        t=strcat('00',int2str(k),'a.bmp');
        a1{m}=jz01zh((imread(t)));
        m=m+1;
    end
    if k>=10 && k<=99
        t=strcat('0',int2str(k),'a.bmp');
        a2{n}=jz01zh((imread(t)));
        n=n+1;
    end
    if k>=100
        t=strcat(int2str(k),'a.bmp');
        a3{q}=jz01zh((imread(t)));
        q=q+1;
    end    
end
a=[a1,a2,a3];
m=1;n=1;q=1;
for k=0:208
    if k<10 
        t=strcat('00',int2str(k),'b.bmp');
        b1{m}=jz01zh((imread(t)));
        m=m+1;
    end
    if k>=10 && k<=99
        t=strcat('0',int2str(k),'b.bmp');
        b2{n}=jz01zh((imread(t)));
        n=n+1;
    end
    if k>=100
        t=strcat(int2str(k),'b.bmp');
        b3{q}=jz01zh((imread(t)));
        q=q+1;
    end    
end
b=[b1,b2,b3];
for k=1:209
    temp=a{k};
    [row col]=size(temp);
    br=temp(:,col);
    bl=temp(:,1);
    bu=temp(1,:);
    bd=temp(row,:);
    bounda1{k}=[bl,br];
    bounda2{k}=[bu',bd'];
end
for k=1:209
    temp=b{k};
    [row col]=size(temp);
    br=temp(:,col);
    bl=temp(:,1);
    bu=temp(1,:);
    bd=temp(row,:);
    boundb1{k}=[bl,br];
    boundb2{k}=[bu',bd'];
end

