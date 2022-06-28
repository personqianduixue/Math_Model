clear
b=[32	45	83	110	113	116	128	144	147	148	179]';%找到的右端
%b=[20	21	71	82	133	147	160	172	192	202	209]';%找到的左端
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
t=zeros(180,11*29);
for i=1:11*19
    for j=1:m
         ss=0;
        for l=1:n
       ss=ss+(a(j,l,i)==0);
        end
          t(j,i)=ss;
    end
end
dt=diff(t);
[ma,ind]=max(dt);
t=zeros(180,11*19);
for i=1:11*19
    for j=1:m
         ss=0;
        for l=1:n
       ss=ss+(a(j,l,i)==255);
        end
          t(j,i)=ss;
    end
end
we=t;
dt=diff(t);
[u3,r3]=sort(dt);
[ma,ind]=max(dt);
N=63;
ind=ind+3;
for i=1:11*19
    z=fix(ind(i)/N);
    ind(i)=ind(i)-z*N;
    if ind(i)<=N/3
        for j=1:ind(i)
            t(j,i)=0;
        end
       for k=0:1
        for j=ind(i)+k*N:ind(i)+k*N+N/3
            t(j,i)=1;
        end
        for j=ind(i)+k*N+N/3:ind(i)+k*N+N
            t(j,i)=0;
        end
       end
       for j=ind(i)+2*N:ind(i)+2*N+N/3
            t(j,i)=1;
       end
        for j=ind(i)+2*N+N/3:180
            t(j,i)=0;
        end
    elseif  ind(i)>N/3&ind(i)<=N*2/3
          for j=1:ind(i)
             t(j,i)=0;
          end
          for k=0:1
          for j=ind(i)+k*N:ind(i)+k*N+N/3
            t(j,i)=1;
          end
         for j=ind(i)+k*N+N/3:ind(i)+k*N+N
            t(j,i)=0;
         end
         end
         if  ind(i)+2*N+N/3>180
         for j=ind(i)+2*N:180
            t(j,i)=1;
         end
         else
         for j=ind(i)+2*N:ind(i)+2*N+N/3
          t(j,i)=1;
         end
         for j=ind(i)+2*N+N/3:180
            t(j,i)=0;
         end
         end
    elseif  ind(i)>2*N/3&ind(i)<N
          for j=ind(i)-2*N/3:ind(i)
             t(j,i)=0;
          end
          for j=1:ind(i)-2*N/3
             t(j,i)=1;
          end
         k=0;
          for j=ind(i)+k*N:ind(i)+k*N+N/3
            t(j,i)=1;
          end
         for j=ind(i)+k*N+N/3:ind(i)+k*N+N
            t(j,i)=0;
         end
         k=1;
 
        for j=ind(i)+k*N:ind(i)+k*N+N/3
            t(j,i)=1;
        end
       if ind(i)+k*N+N<180
           for j=ind(i)+k*N:ind(i)+k*N+N/3
            t(j,i)=1;
           end
            for j=ind(i)+k*N+N/3:ind(i)+k*N+N
            t(j,i)=0;
            end
            for j=ind(i)+k*N+N:180
            t(j,i)=1;
            end
       else
           for j=ind(i)+k*N:ind(i)+k*N+N/3
            t(j,i)=1;
           end
            for j=ind(i)+k*N+N/3:180
            t(j,i)=0;
            end
       end
     end 
end
%求匹配度最大的每行
s1=[];
for k=1:11
for i=1:11*19
    s1(i,k)=sum(t(:,b(k)).*t(:,i));
end
end
[r1,u1]=sort(s1);






