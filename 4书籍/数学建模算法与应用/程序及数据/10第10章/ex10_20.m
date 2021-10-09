clc, clear
D=[0, 1, sqrt(3), 2, sqrt(3), 1, 1; zeros(1,2),1, sqrt(3), 2, sqrt(3), 1
   zeros(1,3),1, sqrt(3), 2, 1;zeros(1,4), 1, sqrt(3), 1
   zeros(1,5), 1, 1; zeros(1,6), 1; zeros(1,7)]  %原始距离矩阵的上三角元素
d=D+D'; %构造完整的距离矩阵
%d=nonzeros(D')'; %转换成pdist函数输出格式的数据
[y,eigvals]=cmdscale(d) %求经典解，d可以为实对称矩阵或pdist函数的行向量输出
plot(y(:,1),y(:,2),'o','Color','k','LineWidth',1.3)   %画出点的坐标
%下面我们通过求特征值求经典解
D2=D+D'; %构造对称距离矩阵  
A=-D2.^2/2;   %构造A矩阵
n=size(A,1);
H=eye(n)-ones(n)/n;  %构造H矩阵
B=H*A*H   %构造B矩阵
[vec1,val1]=eig(B);  %求B矩阵的特征向量vec1和特征值val1
[val2,ind]=sort(diag(val1),'descend') %把特征按从大到小排列
vec2=vec1(:,ind)  %相应地把特征向量也重新排序
vec3=orth(vec2(:,[1,2])); %构造正交特征向量
point=[vec3(:,1)*sqrt(val2(1)),vec3(:,2)*sqrt(val2(2))] %求点的坐标
hold on
plot(point(:,1),point(:,2),'D','Color','k','LineWidth',1.3)   %验证得到的解和Matlab不一致
theta=-0.42;      %旋转的角度
T=[cos(theta),-sin(theta);sin(theta),cos(theta)];
Tpoint=point*T;   %把特征向量进行一个正交变换
plot(Tpoint(:,1),Tpoint(:,2),'+','Color','k','LineWidth',1.3)  %验证这样得到的解和Matlab一致
legend('Matlab命令cmdscale求得的解','按照算法求得的一个解','正交变换后得到的与cmdscale相同的解',0)
