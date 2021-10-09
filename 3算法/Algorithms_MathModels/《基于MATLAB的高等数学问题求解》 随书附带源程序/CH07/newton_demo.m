function newton_demo
figure('Name','牛顿法几何意义','NumberTitle','off')
x0=3.5;
fun=sym('exp(x)-x-5');
df=diff(fun);
[xx,fx,~,X]=newton(fun,x0);
x1 = linspace(1,4);
plot(x1,subs(fun,x1),[1,4],[0 0],'k:',xx,fx,'k*');
hold on
XX=reshape([[x0;X] [x0;X]]',1,[]);
F=reshape([zeros(length(X)+1,1) subs(fun,[x0;X])]',1,[]);
plot(XX(1:7),F(1:7),'k')
k=subs(df,XX([2,4]));
a1 = linspace(0,atan(k(1))*0.6); % 标记角度
plot(XX(3)+0.15*cos(a1),4*sin(a1),'k'); % 标记角度的弧线
a2 = linspace(0,atan(k(2))*0.35);
plot(XX(5)+0.15*cos(a2),4*sin(a2),'k');
text(XX([3 5])+0.17,[2.5 1],{'{\it\alpha}_1','{\it\alpha}_2'},'fontname','times','fontsize',16)
text(XX(1:2:7),-2*ones(1,4),{'{\itx}_0','{\itx}_1','{\itx}_2','\bf\cdot\cdot\cdot'},'fontname','times','fontsize',16)
text(xx-0.1,fx+2,'{\itx}^*','fontname','times','fontsize',16)
text(3.2,32,'{\ity}={\itf}({\itx})\rightarrow','fontname','times','fontsize',16)
text(1.5,40,'牛顿法几何意义','fontname','隶书','fontsize',16)
text(1.5,30,'$${x_{k+1}}={x_k}-\frac{{f({x_k})}}{{f''({x_k})}}$$','interpreter','latex','fontsize',14)
web -broswer http://www.ilovematlab.cn/forum-221-1.html