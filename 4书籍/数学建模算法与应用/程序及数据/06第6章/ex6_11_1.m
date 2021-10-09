solinit=bvpinit(linspace(-1,1,20),@dropinit);
sol=bvp4c(@drop,@dropbc,solinit);
fill(sol.x,sol.y(1,:),[0.7,0.7,0.7])
axis([-1,1,0,1])
xlabel('x','FontSize',12)
ylabel('h','Rotation',0,'FontSize',12)
