clc
clear
p=xlsread('Book2.xls');
t=p(:,1);
m=length(t);
Hh=p(:,2);
Hd=p(:,3);
Hb=p(:,4);
y=40.1*pi/180;
Ht=[];
for b=0:0.001:pi/3
  for i=1:m
    w=15*pi/180*(rem(t(i),24)-12);
    n=fix(t(i)/24)+1;
    q=23.45*pi/180*sin(360*(284+n)/365);
    a=asin(sin(y)*sin(q)+cos(y)*cos(q)*cos(w));
    if a<pi/2&a>0
    Hb1=Hb(i)*sin(a);
    Rb=(pi/12*sin(y-b)*sin(q)+cos(y-b)*cos(q)*sin(15*pi/180))/(pi/12*sin(y)*sin(q)+cos(y)*cos(q)*sin(15/180*pi));
    H(i)=Hb1*Rb+(Hd(i)*(1+cos(b))/2+Hh(i)*(1-cos(b))/2*0.2);
    end
  end
H(H<0)=0;
oo=sum(H);
Ht=[Ht,oo];
end

