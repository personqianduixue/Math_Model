figure('Name','二分法几何意义','NumberTitle','off')
f=@(x)exp(x)-x-5;a=1;b=4;
[x,fx,iter,X]=bisect(f,a,b);
ezplot(f,[a,b]+(b-a)*0.1*[-1,1])
hold on
plot(xlim,[0 0],'r:',x,fx,'k*')
Y=[a X(1:3) b];fY=f(Y);
d=char('r','g','b');
plot([Y;Y],[fY;zeros(size(Y))],'k')
for i=1:3
    if f(X(i))*f(a)<0
        xx=a+(X(i)-a)*[0 1/30 7/15 1/2 8/15 29/30 1];
        plot([xx;xx+(X(i)-a)],[0 1 1 2 1 1 0]/80*diff(ylim)*(2.5-0.5*i)*(-1)^(i+1),d(i,:))
        b=X(i);
    else
        xx= X(i)+(b-X(i))*[0 1/30 7/15 1/2 8/15 29/30 1];
        plot([xx;xx+(X(i)-b)],[0 1 1 2 1 1 0]/80*diff(ylim)*(2.5-0.5*i)*(-1)^(i+1),d(i,:))
        a=X(i);
    end
end
text(1.35,10,{'$$\Delta x = \frac{{b - a}}{2}$$'},'interpreter','latex','fontsize',14)
text(1-0.1,1.5,'\fontname{times}\fontsize{16}\ita')
text([2.5+0.05,4+0.05],[-1.5,-1.5],{'\itx','\itb'},'fontname','times','fontsize',16)
text(1,60,'\fontname{隶书}\fontsize{16}二分法几何意义')
text(3.5,50,'\fontname{times}\fontsize{16}{\ity}={\itf}({\itx})\rightarrow')
xlabel('\itx','fontname','times','fontsize',16)
ylabel('\ity','fontname','times','fontsize',16)
title('')
web -broswer http://www.ilovematlab.cn/forum-221-1.html
