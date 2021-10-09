%b=[32	45	83	110	113	116	128	144	147	148	179]';%找到的右端
%b=[20	21	71	82	133	87 160	172	192	202	209]';%找到的左端
%b33=[4  6	14	24	36	79	84	89	91	106	166	173	187	200	219	264	299	309	324	346	353	356]';
b33=[55	90	100	 115	137 	144 	147 	213 	215 	223 	233 	245 	288 	293 	298 	300 	315 	375 	382 	396 	409 	10];
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
t=zeros(180,2*11*29);
for i=1:2*11*19
    for j=1:m
         ss=0;
        for l=1:n
       ss=ss+(a(j,l,i)==255);
        end
        if ss/n>0.95
          t(j,i)=1;
        else
           t(j,i)=0;
        end
    end
end
%
%求匹配度最大的每行
s3=[];
for k=1:2*11
for i=1:2*11*19
    s3(i,k)=0;
    for j=1:180
     if  t(j,b33(k))==t(j,i)
         s3(i,k)=s3(i,k)+1;
     end
    end
end
end
[r1,u1]=sort(s3);



    


