function F=myfun(a,X);
sum1=zeros(8,1);%变量有n行，就把8改为n
sum2=zeros(8,1);%变量有n行，就把8改为n

for n=1:100
 sum1=sum1+exp(-(n*n)*(pi*pi)*1.0e-10*a(1)*X(:,3)./(X(:,1).^2))./(n*n);
 sum2=sum2+exp(-(n*n)*(pi*pi)*1.0e-10*a(2)*X(:,3)./(X(:,2).^2))./(n*n);
end;

F=(1-(6*sum1./(pi*pi))+0.01*a(3)*(1-(6*sum2./(pi*pi))))./(1+0.01*a(3));