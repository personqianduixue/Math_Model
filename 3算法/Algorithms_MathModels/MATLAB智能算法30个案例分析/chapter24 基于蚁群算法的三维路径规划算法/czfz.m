clc
clear

h=[1800 2200 1900 2400 2300 2100 2500 2400 2700 2600 2900
   1600 2000 2000 2600 2900 2000 2000 2500 2700 3000 2800
   2100 1900 2000 1900 1700 2000 2000 2000 2000 2500 2900
   1700 2000 2000 2000 1800 2000 2200 2000 2000 2000 2800
   2200 1800 2000 3100 2300 2400 1800 3100 3200 2300 2000
   1900 2100 2200 3000 2300 3000 3500 3100 2300 2600 2500
   1700 1400 2300 2900 2400 2800 1800 3500 2600 2000 3200
   2300 2500 2400 3100 3000 2600 3000 2300 3000 2500 2700
   2000 2200 2100 2000 2200 3000 2300 2500 2400 2000 2300
   2300 2200 2000 2300 2200 2200 2200 2500 2000 2800 2700
   2000 2300 2500 2200 2200 2000 2300 2600 2000 2500 2000];
h=h-1400;
[n,m]=size(h);

for i=3:n+2
    for j=3:n+2
        H(i,j)=h(i-2,j-2);
    end
end

H(3:m+2,2)=(290*H(3:m+2,3)-366*H(3:m+2,4)+198*H(3:m+2,5)-38*H(3:m+2,6))/84;
H(3:m+2,1)=(7211*H(3:m+2,3)-12813*H(3:m+2,4)+8403*H(3:m+2,5)-1919*H(3:m+2,6))/882;
H(3:m+2,n+3)=-(21*H(3:m+2,n-1)-101*H(3:m+2,n)+177*H(3:m+2,n+1)-135*H(3:m+2,n+2))/38;
H(3:m+2,n+4)=-(2079*H(3:m+2,n-1)-8403*H(3:m+2,n)+12013*H(3:m+2,n+1)-6411*H(3:m+2,n+2))/722;

H(2,:)=(290*H(3,:)-366*H(4,:)+198*H(5,:)-38*H(6,:))/84;
H(1,:)=(7211*H(3,:)-12813*H(4,:)+8403*H(5,:)-1919*H(6,:))/882;
H(n+3,:)=-(21*H(n-1,:)-101*H(n,:)+177*H(n+1,:)-135*H(n+2,:))/38;
H(n+4,:)=-(2079*H(n-1,:)-8403*H(n,:)+12013*H(n+1,:)-6411*H(n+2,:))/722;

%二维四次卷积插值
[n,m]=size(h);
D=[-21 59 -32 -48 61 -19
    63 -261 386 -222 15 19
    -63 366 -600 354 -57 0
    21 -164 6 156 -19 0
    0 0 240 0 0 0];
for i=1:10*(n-1)
    for j=1:10*(m-1)
        indexi=floor(i/10)+3;
        indexj=floor(j/10)+3;
        s=mod(i,10)*0.1;
        if j==100
            indexj=indexj-1;
        end
        if i==100
            indexi=indexi-1;
        end
%         if s==0
%             indexi=indexi-1;
%         end
        t=mod(j,10)*0.1;
%         if t==0
%             indexj=indexj-1;
%         end
        S=[s^4,s^3,s^2,s 1];
        T=[t^4,t^3,t^2,t,1];
        C=[H(indexi-2,indexj-2) H(indexi-2,indexj-1) H(indexi-2,indexj) H(indexi-2,indexj+1) H(indexi-2,indexj+2) H(indexi-2,indexj+3)
           H(indexi-1,indexj-2) H(indexi-1,indexj-1) H(indexi-1,indexj) H(indexi-1,indexj+1) H(indexi-1,indexj+2) H(indexi-1,indexj+3)
           H(indexi  ,indexj-2) H(indexi  ,indexj-1) H(indexi  ,indexj) H(indexi  ,indexj+1) H(indexi  ,indexj+2) H(indexi  ,indexj+3)
           H(indexi+1,indexj-2) H(indexi+1,indexj-1) H(indexi+1,indexj) H(indexi+1,indexj+1) H(indexi+1,indexj+2) H(indexi+1,indexj+3)
           H(indexi+2,indexj-2) H(indexi+2,indexj-1) H(indexi+2,indexj) H(indexi+2,indexj+1) H(indexi+2,indexj+2) H(indexi+2,indexj+3)
           H(indexi+3,indexj-2) H(indexi+3,indexj-1) H(indexi+3,indexj) H(indexi+3,indexj+1) H(indexi+3,indexj+2) H(indexi+3,indexj+3)];
        HH(i,j)=S*D*C*D'*T'/57600;
    end
end

[n,m]=size(HH);
x=1:n;
y=1:m
[xx,yy]=meshgrid(x,y);
mesh(xx,yy,HH)
xlabel('km')
ylabel('km')
zlabel('m')

a =[     50         600
          65         600
          50         600
          40         600
          30         800
          30         600
          35         800
          35         600
          35         800
          25         800
          30        1200
          15        1200
          20        1000
          15        1000
          30        1000
          35        1200
          35        1000
          40        1000
          30        1400
          35        1600
          40        1000];
      b=[0     5    10    15    20    25    30    35    40    45    50    55    60    65    70 75    80    85    90    95   100];
       
      hold on
      plot3(b',a(:,1)-2,a(:,2)+300,'-o','linewidth',2)