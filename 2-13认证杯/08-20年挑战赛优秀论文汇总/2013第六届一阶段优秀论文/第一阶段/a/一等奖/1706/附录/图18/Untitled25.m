clc
y =[0.6900
0.7107
0.7300
0.7468
0.7600
0.7686 
0.7729
0.7732
0.7700
0.7636
0.7546
0.7432
0.7300
];
x1 = 8:1:20
x = [ones(13,1) x1' x1'.^2 ]
[b,bint,r,rint,stats]=regress(y,x)
y1 = b(1)+b(2).*x1+b(3).*x1.^2
plot(x1,y,'o')
hold on
h = plot(x1,y1,'r')
title('杆件长宽比与减速率关系')
get(h)
set(h,'LineWidth',2)
legend('实际数据','模型模拟数据')
 text('Interpreter','latex',...
'String',['$$\eta=0.3835+0.0523\lambda-0.0018 \lambda^{2}$$'],'Position',[11, 0.7],...
'FontSize',12)'