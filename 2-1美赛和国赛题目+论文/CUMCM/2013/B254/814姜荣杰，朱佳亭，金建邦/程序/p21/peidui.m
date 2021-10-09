clear
%b=[7 14	29	38	49	61	71	89	94	125	168]';%ÕÒµ½µÄ×ó¶Ë
b=[19	37	44	60	61	75	124	142	146	177	197]';
b=b+1;
a1=imread('000.bmp');
[m,n]=size(a1);
aa=zeros(m,n,11);
for i=1:11
    if b(i)<10
imageName=strcat('0','0',int2str(b(i)),'.bmp');
    elseif b(i)<100
            imageName=strcat('0',num2str(b(i)),'.bmp');
    else
        imageName=strcat(num2str(b(i)),'.bmp');
    end
aa(:,:,i) = imread(imageName);
end
d=zeros(11,11);
for i=1:11
    for j=1:11
        if i~=j
        s=abs(aa(m,:,i)-aa(1,:,j));
      d(i,j)=d(i,j)+sum(sum(s'));
        end
    end
end
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
t=[];
for i=1:11*19
    for j=1:m
         ss=0;
        for l=1:n
       ss=ss+(a(j,l,i)==255);
        end
        if ss/n>=1
           t(i,j)=1;
        end
    end
end
s=[];
for k=1:11
for i=1:11*19
    s(i,k)=0;
    for j=1:180
     if  t(b(k),j)==t(i,j)&t(b(k),j)==1
         s(i,k)=s(i,k)+1;
     end
    end
end
end
[r,u]=sort(s);
s1=[];
for k=1:11
for i=1:11*19
    s1(i,k)=0;
    for j=1:180
     if  t(b(k),j)==t(i,j)
         s1(i,k)=s1(i,k)+1;
     end
    end
end

end
[r1,u1]=sort(s1);
[m,n]=size(s);
bord=[]
for i=1:m
    for j=1:n
        a=find(u(:,j)==i);
        b=find(u1(:,j)==i);
        bord(i,j)=a+b;
    end
end
[mn,mu]=sort(bord)
        






