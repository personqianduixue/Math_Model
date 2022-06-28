function z=iscycleIntersect(line,A,r)
if (line(3)-line(1))~=0
    k=(line(4)-line(2))/(line(3)-line(1));
    b=line(2)-k*line(1);
    d=abs(k*A(1)-A(2)+b)/sqrt(k^2+1);
    [x y]=solve(['x*(' num2str(k) ')-y+(' num2str(b) ')=0'],...
    ['(y-(' num2str(A(2)) '))*(' num2str(k) ')=(' num2str(A(1)) ')-x']);
else
    x=line(3);y=A(2);
    d=abs(line(3)-A(1));
end
x=double(x);y=double(y);
if d>=r-0.5
    z=0;
elseif (y-line(4))*(y-line(2))>0
    z=0;
else
    z=1;
end
