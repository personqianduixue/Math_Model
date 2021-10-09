x=[1 3 5 6 8 9 10 11 12 14 15 17 19 21 23 25];
y=[10 20 42 60 73 79 80 78 73 64 56 71 51 42 41 40];
plot(x,y,'ro');
p=polyfit(x,y,4);%于拟合曲线p(1)x^4+p(2)x^3+p(3)x^2+p(4)x+p(5)想拟合其数项式需4改相应数即
f=poly2sym(p);
xinterp=[2 4 7 13 16 18 20 22 24];
yinterp=subs(f,xinterp);
hold on;
plot(xinterp,yinterp,'o');
ezplot(f,[0,30])