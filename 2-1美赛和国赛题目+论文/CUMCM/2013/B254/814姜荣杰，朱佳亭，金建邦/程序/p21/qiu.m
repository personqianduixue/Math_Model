%找最大的
clear
%b=[7 14 38	71	89	125]';%找到的左端
b=[7 128 38 156 146 13]';
%b=[19 37 44	60	61	75	124	142	146	177	197]';
b=b+1;
chu=[1	14 16	18	25	34	36	46	47	54	69	81	82	84	89	103	104	123	127	131	133	134	138	139	149	157	159	162	168	175	176	183	190	194	199	201	203	209]';
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
%所有图的向量矩阵
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

s1=[];
for k=1:6
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
r11=r1(209-18:209,:)
u11=u1(209-18:209,:)
for i=1:19
   for j=1:6
        if r11(i,j)<=157
            u11(i,j)=0
        end
    end
end
%求匹配度最大的每行
h=size(chu);
s2=[]
for k=1:6
for i=1:h
    s2(i,k)=0;
    for j=1:180
     if  t(b(k),j)==t(chu(i),j)
         s2(i,k)=s2(i,k)+1;
     end
    end
end
end
[ma,ind]=max(s2')
a=[];
a1=[];
a=find(ind==1);
for i=1:size(a')
    a1(i)=chu(a(i));
end
b=[];
b1=[];
b=find(ind==2);
for i=1:size(b')
    b1(i)=chu(b(i));
end
c=[];
c1=[];
c=find(ind==3);
for i=1:size(c')
    c1(i)=chu(c(i));
end
d=[];
d1=[];
d=find(ind==4);
for i=1:size(d')
    d1(i)=chu(d(i));
end
e=[];
e1=[];
e=find(ind==5);
for i=1:size(e')
    e1(i)=chu(e(i));
end
f=[];
f1=[];
f=find(ind==6);
for i=1:size(f')
    f1(i)=chu(f(i));
end




