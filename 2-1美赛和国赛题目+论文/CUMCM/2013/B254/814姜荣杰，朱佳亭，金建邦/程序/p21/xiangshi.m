
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
      s=(a(:,1,i)==255&a(:,2,i)==255&a(:,3,i)==255&a(:,4,i)==255&a(:,5,i)==255&a(:,6,i)==255&a(:,7,i)==255&a(:,8,i)==255&a(:,9,i)==255&a(:,10,i)==255&a(:,11,i)==255)
      tou1(i,1)=tou1(i,1)+sum(s);
end
s=tou1==180;
sum(s)
ind=find(s==1)
for i=1:11
    if ind(i)<10
imageName=strcat('0','0',int2str(ind(i)),'.bmp');
    elseif ind(i)<100
            imageName=strcat('0',num2str(ind(i)),'.bmp');
    else
        imageName=strcat(num2str(ind(i)),'.bmp');
    end
tu(:,:,i) = imread(imageName);
end
t=[];
for i=1:11
    for j=1:m
         ss=0;
        for l=1:n
       ss=ss+(tu(j,l,i)==255);
        end
        if ss/n>=1
           t(i,j)=1;
        end
    end
end
s=zeros(11,1);
for i=1:11
    for j=1:m
if t(i,j)==1
    s(i)=s(i)+1
else 
    continue;
end

    end
end
for i=1:209
    d(i,i)=inf;
end
[mi15,ind15]=min(d(15,:));
[mi72,ind72]=min(d(72,:));
[mi90,ind90]=min(d(90,:));
[mi126,ind126]=min(d(126,:));

