f=[-2; -3; 5];
a=[-2,5,-1;1,3,1]; b=[-10;12];
aeq=[1,1,1];
beq=7;
[x,y]=linprog(f,a,b,aeq,beq,zeros(3,1));
x, y=-y
