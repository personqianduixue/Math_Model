function f12=f12(x)
Bound=[-50 50];

if nargin==0
    f12 = Bound;
else
    y=1+(x+1)./4;
    a=x>10;
    b=x<-10;
    [row col]=size(x);

    y1=y(1:row-1,:);
    y2=y(2:row,:);

    usum=sum(a*.100.*((x-10)).^4)+sum(b*.100.*(x+10).^4);
    f12=(10*sin(pi*y(1,:)).^2+sum((y1-1).^2.*(1+10*sin(pi.*y2).^2))+(y(row,:)-1).^2)*(pi/30)+usum;
end