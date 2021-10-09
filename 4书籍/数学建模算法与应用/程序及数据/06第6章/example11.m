function sol=example11;
solinit=bvpinit(linspace(-1,1,20),@dropinit);
sol=bvp4c(@drop,@dropbc,solinit);
fill(sol.x,sol.y(1,:),[0.7,0.7,0.7])
axis([-1,1,0,1])
xlabel('x','FontSize',12)
ylabel('h','Rotation',0,'FontSize',12)
 
function yprime=drop(x,y);
yprime=[y(2);(y(1)-1)*(1+y(2)^2)^(3/2)];
 
function res=dropbc(ya,yb);
res=[ya(1);yb(1)];
 
function yinit=dropinit(x);
yinit=[sqrt(1-x.^2);-x./(0.1+sqrt(1-x.^2))];

