%b=[32	45	83	110	113	116	128	144	147	148	179]';%找到的右端
b=[20	21	71	82	133	87 160	172	192	202	209]';%找到的左端
a1=imread('000.bmp');
[m,n]=size(a1);
aa=zeros(m,n,11);
for i=1:6
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
%
t=zeros(180,11*29);
for i=1:11*19
    for j=1:m
         ss=0;
        for l=1:n
       ss=ss+(a(j,l,i)==255);
        end
        if ss/n>0.95
          t(j,i)=ss;
        end
    end
end
%
%求匹配度最大的每行
s=[];
for k=1:11
for i=1:11*19
    s(i,k)=0;
    for j=1:180
     if  t(j,b(k))==t(j,i)
         s(i,k)=s(i,k)+1;
     end
    end
end
end
[r1,u1]=sort(s);



    


