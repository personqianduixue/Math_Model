function f17=f17(x)

Bound=[0 15];

if nargin==0
    f17 = Bound;
else   
x(1,:)=x(1,:)-5;
f17=(x(2,:)-5.1/(4*pi^2)*x(1,:)^2+(5/pi)*x(1,:)-6)^2+10*(1-1/(8*pi))*cos(x(1,:))+10;
end




