function [ w ] = AHP(A)
%AHP weighted function
[n,n]=size(A);
x=ones(n,100);
y=ones(n,100);
m=zeros(1,100);
m(1)=max(x(:,1));
y(:,1)=x(:,1);
x(:,2)=A*y(:,1);
m(2)=max(x(:,2));
y(:,2)=x(:,2)/m(2);
p=0.0001;i=2;k=abs(m(2)-m(1));
while  k>p
  i=i+1;
  x(:,i)=A*y(:,i-1);
  m(i)=max(x(:,i));
  y(:,i)=x(:,i)/m(i);
  k=abs(m(i)-m(i-1));
end
a=sum(y(:,i));
w=y(:,i)/a;
t=m(i);
%The following is the consistency test
CI=(t-n)/(n-1);RI=[0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];
CR=CI/RI(n);
if CR<0.10
    disp('The consistency of this matrix is acceptable!');
    disp('CI=');disp(CI);
    disp('CR=');disp(CR);
end
end

