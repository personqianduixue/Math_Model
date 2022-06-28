clear
a1=imread('000.bmp');
[m,n]=size(a1);
a=zeros(m,n,11*19);
for i=0:11*19-1
    if i<10
imageName=strcat('0','0',int2str(i),'.bmp');
    elseif i<100
            imageName=strcat('0',num2str(i),'.bmp');
    else
        imageName=strcat(num2str(i),'.bmp');
    end
a(:,:,i+1) = imread(imageName);
end
d=zeros(11*19,11*19);
e=size(d);
%¼ÆËãÆ¥Åä¶È
for i=1:e
    for j=1:e
        if i~=j
        s=abs(a(:,n,i)-a(:,1,j));
      d(i,j)=d(i,j)+sum(sum(s'));
        end
    end
end
tou1=zeros(11*19,1);
for i=1:e
      s=(a(:,n,i)==255&a(:,n-1,i)==255&a(:,n-2,i)==255&a(:,n-3,i)==255&a(:,n-4,i)==255&a(:,n-5,i)==255&a(:,n-6,i)==255&a(:,n-7,i)==255&a(:,n-8,i)==255&a(:,n-9,i)==255&a(:,n-10,i)==255&a(:,n-11,i)==255&a(:,n-12,i)==255)
      tou1(i,1)=tou1(i,1)+sum(s);
end
s=tou1==180;
sum(s)
ind=find(s==1)

