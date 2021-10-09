clear
%找到的两端
b33=[55	90	100	 115 137  144  147 	213  215 223 233 245 288 293 298 300 315 375 382 396 409 10 4 6	14	24	36	79	84	89	91	106	166	173	187	200	219	264	299	309	324	346	353	356];;
a1=imread('000a.bmp');
b=0:208;
[m,n]=size(a1);
[H,N]=size(b);
a=zeros(m,n,N*2);
%读取图a的
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
%读取图b的
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
%图的向量矩阵
t=zeros(180,2*11*29);
for i=1:2*11*19
    for j=1:m
         ss=0;
        for l=1:n
       ss=ss+(a(j,l,i)==0);
        end
          t(j,i)=ss;
    end
end
t=zeros(180,2*11*19);
for i=1:2*11*19
    for j=1:m
         ss=0;
        for l=1:n
       ss=ss+(a(j,l,i)==255);
       if  a(j,l,i)==255 
           ae(j,l,i)=1;
       else
           ae(j,l,i)=0;
       end
        end
        if ss==n
          t(j,i)=1;
        else
            t(j,i)=0;
        end
     end
end
%求匹配度最大的每行
s1=[];
for k=1:44
for i=1:2*11*19
    s1(i,k)=sum(t(:,b33(k)).*t(:,i));
end
end
[ma,ind]=max(s1');
ff=zeros(44,43);
for k=1:44
so=sum(ind==k);
ff(k,1:so)=find(ind==k);
end





