function [x,y]=qiedian(A,B,r)
[b k]=solve(['(k*' num2str(B(1)) '-' num2str(B(2)) '+b)^2=' num2str(r) '^2*(1+k^2)'],...
    ['(k*' num2str(A(1)) '-' num2str(A(2)) '+b)=0']);
['(k*' num2str(B(1)) '-' num2str(B(2)) '+b)^2=' num2str(r) '^2*(1+k^2)'];
['(k*' num2str(A(1)) '-' num2str(A(2)) '+b)=0'];
k=double(k);
b=double(b);
for i=1:length(k)
    ['x*' num2str(k(i)) '-y+' num2str(b(i)) '=0'];
    ['(y-' num2str(B(2)) ')*' num2str(k(i)) '=' num2str(B(1)) '-x'];
    [x(i) y(i)]=solve(['x*(' num2str(k(i)) ')-y+(' num2str(b(i)) ')=0'],...
        ['(y-(' num2str(B(2)) '))*(' num2str(k(i)) ')=(' num2str(B(1)) ')-x']);
end
x=double(x);y=double(y);