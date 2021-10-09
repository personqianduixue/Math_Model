function obj=ObjectFunction(X)
%% 待优化的目标函数
col=size(X,1);
for i=1:col
    obj(i,1)=21.5+X(i,1)*sin(4*pi*X(i,1))+X(i,2)*sin(20*pi*X(i,2));
%     obj(i,1)=exp(((X(i,1)-0.1)/0.8)^2)*(sin(5*pi*X(i,1)))^6;
end
