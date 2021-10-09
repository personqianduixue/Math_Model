clc,clear
a=[-1 -1  0  0
   0  0  -1 -1
   3  0   2  0
   0  3   0  2];
b=[-30 -30 120 48]';
c1=[-100 -90 -80 -70];
c2=[0 3 0 2];
fun=@(x) [c1;c2]*x;  %用匿名函数定义目标向量
[x1,g1]=linprog(c1,a,b,[],[],zeros(4,1))  %求第一个目标函数的目标值
[x2,g2]=linprog(c2,a,b,[],[],zeros(4,1))  %求第二个目标函数的目标值
g3=[g1;g2];  %目标goal的值
[x,fval]=fgoalattain(fun,rand(4,1),g3,abs(g3),a,b,[],[],zeros(4,1))
