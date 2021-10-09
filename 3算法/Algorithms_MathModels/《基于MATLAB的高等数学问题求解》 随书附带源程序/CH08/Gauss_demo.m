x=1:0.1:7;
y=@(x)exp(-x).*sin(x)+cos(x)+2;
h=subplot(211);
h1=plot(x,y(x));
hold all
plot([2 6],y([2 6]),'k:')
xn=linspace(2,6);
fill([xn,fliplr(xn)],[y(xn),fliplr(linspace(y(2),y(6)))],[0.9,0.9,0.9])
plot([2,6],y([2,6]),'k.','MarkerSize',20)
plot([2 2],[0 y(2)],'k',[6 6],[0 y(6)],'k')
text(2,3,'\fontname{隶书}\fontsize{16}梯形公式')
text(1.2,y(2),'$$(a,f(a))$$','interpreter','latex','fontsize',12)
text(6.1,y(6)-0.25,'$$(b,f(b))$$','interpreter','latex','fontsize',12)
text(4,y(4)-0.2,'$$y = f(x)$$','interpreter','latex','fontsize',12)
ylim([0 3.5])
set(gca,'xticklabel',{'-1.5','-1.0','-0.5','0','0.5','1.0','1.5'})
h2=subplot(212);
T=quad(y,2,6);
H=T/2-y(2)*0.8;
copyobj(h1,h2)
hold on
fill([xn,fliplr(xn)],[linspace(y(2)*0.8,H),fliplr(y(xn))],[0.9,0.9,0.9])
plot([2,6],[y(2)*0.8,H],'k.','MarkerSize',20)
plot([2 2],[0 y(2)],'k',[6 6],[0 y(6)],'k',[2 6],[y(2)*0.8 H],'k')
plot([2,6],y([2,6]),'k.','MarkerSize',20)
yn=@(x)(H-y(2)*0.8)/(6-2)*(x-2)+y(2)*0.8;
T=[];
for k=1:length(xn)-1
    if (y(xn(k))-yn(xn(k)))*(y(xn(k+1))-yn(xn(k+1)))<=0
        T=[T,xn(k)+(xn(k+1)-xn(k))*(y(xn(k))-yn(xn(k)))/(y(xn(k))-y(xn(k+1)))];
    end
end
plot(T,y(T),'ro')
text(2,3,'\fontname{隶书}\fontsize{16}两点高斯求积公式')
text(1.2,y(2),'$$(a,f(a))$$','interpreter','latex','fontsize',12)
text(6.1,y(6)-0.25,'$$(b,f(b))$$','interpreter','latex','fontsize',12)
text(3.5,y(3.5)-0.2,'$$y = f(x)$$','interpreter','latex','fontsize',12)
text(T,y(T)+[0.3,-0.25],{'$$(x_0,f(x_0))$$','$$(x_1,f(x_1))$$'},...
    'interpreter','latex','fontsize',12)
ylim([0 3.5])
box on
set(gca,'xticklabel',{'-1.5','-1.0','-0.5','0','0.5','1.0','1.5'})
set(gcf,'Color','w')
web -broswer http://www.ilovematlab.cn/forum-221-1.html