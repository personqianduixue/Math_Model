function f16=f16(x)

Bound=[-5 5];

if nargin==0
    f16 = Bound;
else   
    f16=4*x(1,:)^2-2.1*x(1,:)^4+(1/3)*x(1,:)^6+x(1,:)*x(2,:)-4*x(2,:)^2+4*x(2,:)^4;
end




