clc, clear
a=[-1 -2 0;-1 0 0];b=[-1;0];
[x,y]=ga(@ycfun1,3,a,b,[],[],[],[],@ycfun2);
x, y=-y
