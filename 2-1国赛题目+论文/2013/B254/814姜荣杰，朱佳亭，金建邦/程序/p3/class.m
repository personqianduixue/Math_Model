clear
%b=[32	45	83	110	113	116	128	144	147	148	179]';%找到的右端
%b=[20	21	71	82	133	147	160	172	192	202	209]';%找到的左端
%b33=[55	90	100	 115	137 	144 	147 	213 	215 	223 	233 	245 	288 	293 	298 	300 	315 	375 	382 	396 409 10];%右端
b33=[4 6	14	24	36	79	84	89	91	106	166	173	187	200	219	264	299	309	324	346	353	356];%左端
a1=imread('000a.bmp');
b=0:208;
[m,n]=size(a1);
[H,N]=size(b);
a=zeros(m,n,N*2);
%读取a的
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
%读取b的
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
dt=diff(t);
[ma,ind]=max(dt);
%找出下限
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
          t(j,i)=ss;
    end
end
dt=diff(t);
[u3,r3]=sort(dt);
[ma,ind]=max(dt);
%补齐空白
N=63;
ind=ind+1;
for i=1:2*11*19
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
s3=[];
for k=1:2*11
for i=1:2*11*19
    s3(i,k)=0;
    for j=1:180
        if b33(k)<=209&i<=209
             if  t(j,b33(k))==t(j,i)&t(j,(b33(k)+209))==t(j,i+209)
                 s3(i,k)=s3(i,k)+1;
             end
        elseif b33(k)<=209&i>209
            if  t(j,b33(k))==t(j,i)&t(j,(b33(k)+209))==t(j,i-209)
               s3(i,k)=s3(i,k)+1;
            end  
       elseif b33(k)>209&i<=209
            if  t(j,b33(k))==t(j,i)&t(j,(b33(k)-209))==t(j,i+209)
               s3(i,k)=s3(i,k)+1;
            end 
        else
            if  t(j,b33(k))==t(j,i)&t(j,(b33(k)-209))==t(j,i-209)
               s3(i,k)=s3(i,k)+1;
            end 
        end
end
end
end
[ma4,ind4]=max(s3');
s31=zeros(22,60);
for i=1:22
    a=sum(ind4==i);
s31(i,1:a)=find(ind4==i);
end
for i=1:22
    for j=1:60
        if s31(i,j)~=0
        s32(i,j)=s3(s31(i,j),i);
        end
    end
end
[r32,u32]=sort(s32');
[r3,u3]=sort(s3);





