function [x]=yuanyuanqiexian(A,r1,B,r2)
[b k]=solve(['(k*' num2str(A(1)) '-' num2str(A(2)) '+b)^2=' num2str(r1) '^2*(1+k^2)'],...
    ['(k*' num2str(B(1)) '-' num2str(B(2)) '+b)^2=' num2str(r2) '^2*(1+k^2)']);
k=double(real(k));
b=double(real(b));
for i=1:length(k)
    temp5=solve(['x*(' num2str(k(i)) ')-y+(' num2str(b(i)) ')=0'],...
        ['(y-(' num2str(A(2)) '))*(' num2str(k(i)) ')=(' num2str(A(1)) ')-x']);
    x(1,i)=double(temp5.x);x(2,i)=double(temp5.y);
    temp5=solve(['x*(' num2str(k(i)) ')-y+(' num2str(b(i)) ')=0'],...
        ['(y-(' num2str(B(2)) '))*(' num2str(k(i)) ')=(' num2str(B(1)) ')-x']);
    x(3,i)=double(temp5.x);x(4,i)=double(temp5.y);
end
x=double(x);
if length(k)==2
    x(1,3)=A(1)-r1;x(2,3)=A(2);x(3,3)=B(1)-r1;x(4,3)=B(2);
    x(1,4)=A(1)+r1;x(2,4)=A(2);x(3,4)=B(1)+r1;x(4,4)=B(2);
end