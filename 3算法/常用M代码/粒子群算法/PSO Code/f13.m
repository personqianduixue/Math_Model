function f13=f13(x)
Bound=[-50 50];

if nargin==0
    f13 = Bound;
else
    y=1+(x+1)./4;
    a=x>5;
    b=x<-5;
    [row col]=size(x);

    y1=x(1:row-1,:);
    y2=x(2:row,:);

    usum=sum(a*.100.*((x-10)).^4)+sum(b*.100.*(x+10).^4);    
    a=sum((y1-1).^2.*(1+sin(3*pi.*y2).^2));
    b=(x(row,:)-1).^2.*(1+sin(2*pi.*x(row,:)).^2);
    f13=(sin(3*pi*x(1,:)).^2 + a + b)*.1+usum;
end