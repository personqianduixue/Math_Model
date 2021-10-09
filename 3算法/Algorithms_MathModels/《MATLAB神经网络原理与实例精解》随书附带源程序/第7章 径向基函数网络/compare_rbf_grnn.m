% compare_rbf_grnn.m
x=-9:8;                                         % 样本的x值
y=[129,-32,-118,-138,-125,-97,-55,-23,-4,...    % y值
2,1,-31,-72,-121,-142,-174,-155,-77];
plot(x,y,'o')
P=x;
T=y;
tic;net = newrb(P, T, 0, 2);toc                 % 创建径向基网络

xx=-9:.2:8;
yy = sim(net, xx);                              % 径向基网络仿真
figure(1);
hold on;
plot(xx,yy)
tic;net2=newgrnn(P,T,.5);toc;                   % 设计广义回归网络

yy2 = sim(net, xx);                             % 广义回归网络仿真
plot(xx,yy2,'.-r');
