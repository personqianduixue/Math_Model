a1=imread('000a.bmp');
b=0:208;
[m,n]=size(a1);
[H,N]=size(b);
a=zeros(m,n,N*2);
%��ȡa��
for i=1:N
    if b(i)<10
           imageName=strcat('0','0',int2str(b(i)),'a.bmp'); 
    elseif b(i)<100
            imageName=strcat('0',num2str(b(i)),'a.bmp');
    else
           imageName=strcat(num2str(b(i)),'a.bmp');
    end
    a(:,:,i) = imread(imageName);
end
%��ȡb��
for i=1:N
    if b(i)<10
           imageName=strcat('0','0',int2str(b(i)),'b.bmp');
    elseif b(i)<100
            imageName=strcat('0',num2str(b(i)),'b.bmp');
    else
           imageName=strcat(num2str(b(i)),'b.bmp');
    end
    a(:,:,i+209) = imread(imageName);
end
for i=1:11*19
    for j=1:m
         ss=0;
        for l=1:n
       ss=ss+(aa(j,l,i)==255);
        end
          t1(j,i)=ss;
    end
end
dt=diff(t1);
[u3,r3]=sort(dt);
[ma,ind]=max(dt);
N=63;
for i=1:209
z=fix(ind(i)/N);
ind(i)=ind(i)-z*N;
end
for i=1:size(xia)
    for j=1:size(sh)
        ss2(i,j)=abs(N-sum([ind(xia(i)),ind(sh(j))]'));
    end
end