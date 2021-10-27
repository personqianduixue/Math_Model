clc
y =[0.6300
0.6467
0.6620
0.6761
0.6887
0.7000
0.7098
0.7181
0.7248
0.7300
0.7332
0.7326
0.7261
0.7116
0.6869
0.6500
];
x1 = [3.0	3.2	3.4	3.6	3.8	4.0	4.2	4.4 4.6	4.8	5.0	5.2	5.4	5.6	5.8	6.0]
x = [ones(16,1) x1' x1'.^2]
[b,bint,r,rint,stats]=regress(y,x)
y1 = b(1)+b(2).*x1+b(3).*x1.^2
plot(x1,y,'o')
hold on
h = plot(x1,y1,'r')
get(h)
set(h,'LineWidth',2)
legend('实际数据','模型模拟数据')
% text('Interpreter','latex',...
% 	'String',['$$\eta=-0.0773+0.3396\varepsilon-0.0358\varepsilon^{2}$$'],'Position',[4, 0.66],...
% 	'FontSize',12)'