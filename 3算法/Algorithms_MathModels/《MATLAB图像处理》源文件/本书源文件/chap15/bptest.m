function c=bptest(p,q,n,w,v,theta,r,X)
%p,q,n表示输入层、中间层和输出层神经元个数
%w，v表示训练好的神经网络输入层到中间层、中间层到输出层权值。
%X为输入测试的模式
%c表示模式X送入神经网络的识别结果。
%计算中间层的输入Y(j) 
Y=X*w; 
%计算中间层的输出b
Y=Y-theta;    %中间层阈值
for j=1:p
    b(j)=1/(1+exp(-Y(j)));%中间层输出f(sj)
end      
%计算输出层输出c
Y=b*v;
Y=Y-r;  % 输出层阈值
thr1=0.01;thr2=0.5;
for t=1:q
   c(t)=1/(1+exp(-Y(t))); %输出层输出
end 

