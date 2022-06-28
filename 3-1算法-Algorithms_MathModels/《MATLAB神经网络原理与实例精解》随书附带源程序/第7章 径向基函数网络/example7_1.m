P=1:.5:10;
rand('state',pi);
T=sin(2*P)+rand(1,length(P));				  % 给正弦函数加噪声
plot(P,T,'o')
% net=newrb(P,T);
net=newrb(P,T,0,0.6);
test=1:.2:10;
out=sim(net,test);                            % 对新的输入值test计算相对应的函数值
figure(1);hold on;plot(test,out,'b-');
legend('输入的数据','拟合的函数');
