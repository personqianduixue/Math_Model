function assign=assignment(A)
[m,n] = size(A);
M(m,n)=0;
for(i=1:m)
for(j=1:n)
if(A(i,j))
M(i,j)=1;
break;
end
end %求初始匹配 M
if(M(i,j))
break;
end
end %获得仅含一条边的初始匹配 M
while(1)
for(i=1:m)
x(i)=0;
end %将记录X 中点的标号和标记*
for(i=1:n)
y(i)=0;
end %将记录Y 中点的标号和标记*
for(i=1:m)
pd=1; %寻找X 中 M 的所有非饱和点
for(j=1:n)
if(M(i,j))
pd=0;
end;
end
if(pd)
x(i)=-n-1;
end
end %将X 中 M 的所有非饱和点都给以标号0 和标记*, 程序中用 n+1 表示0 标号, 标号为负数时表示标记*
pd=0;
while(1)
xi=0;
for(i=1:m)
if(x(i)<0)
xi=i;
break;
end
end %假如 X 中存在一个既有标号又有标记*的点, 则任 取X 中一个既有标号又有标记*的点xi
if(xi==0)
pd=1;
break;
end %假如X 中所有有标号的点都已去掉了标记*, 算法终止
x(xi)=x(xi)*(-1); %去掉xi 的标记*
k=1;
for(j=1:n )
if(A(xi,j)&y(j)==0)
y(j)=xi;
yy(k)=j;
k=k+1;
end
end %对与 xi 邻接且尚未给标号的 yj 都给以标号i
if(k>1)
k=k-1;
for(j=1:k)
pdd=1;
for(i=1:m)
if(M(i,yy(j)))
x(i)=-yy(j);
pdd=0;
break;
end
end %将yj 在 M 中与之邻接的 点xk (即xkyj ∈M), 给以标号j 和标记*
if(pdd)
break;
end
end
if(pdd)
k=1;
j=yy(j); %yj 不是 M 的饱和点
while(1)
P(k,2)=j;
P(k,1)=y(j);
j=abs(x(y(j))); %任取 M 的一个非饱和点 yj, 逆向返回
if(j==n+1)
break;
end %找到X 中标号为0 的点时结束, 获得 M-增广路
k=k+1;
end
for(i=1:k)
if(M(P(i,1),P(i,2)))
M(P(i,1),P(i,2))=0; %将匹配 M 在增广路 P 中出现的边 去掉
else M(P(i,1),P(i,2))=1;
end
end %将增广路 P 中没有在匹配 M 中出现的边加入 到匹配 M 中
break;
end
end
end
if(pd)
break;
end
end %假如X 中所有有标号的点都已去掉了标记*, 算法终止
assign = M  %显示最大匹配 M, 程序结束