% script： main_seral.m
% 串行方式训练BP网络，实现性别识别BP网络串行训练的误差想·

%% 清理
clear all
clc

%% 读入数据
xlsfile='student.xls';
[data,label]=getdata(xlsfile);

%% 划分数据
[traind,trainl,testd,testl]=divide(data,label);

%% 设置参数
rng('default')
rng(0)
nTrainNum = 60; % 60个训练样本
nSampDim = 2;   % 样本是2维的
M=2000;         % 迭代次数
ita=0.1;        % 学习率
alpha=0.2;
%% 构造网络
HN=3;           % 隐含层层数
net.w1=rand(3,HN);
net.w2=rand(HN+1,1);

%% 归一化数据
mm=mean(traind);
for i=1:2
    traind_s(:,i)=traind(:,i)-mm(i);
end

ml(1) = std(traind_s(:,1));
ml(2) = std(traind_s(:,2));
for i=1:2
    traind_s(:,i)=traind_s(:,i)/ml(i);
end

%% 训练
for x=1:M                          % 迭代
    ind=randi(60);                 % 从1-60中选一个随机数
    
    in=[traind_s(ind,:),1];        % 输入层输出
    net1_in=in*net.w1;             % 隐含层输入
    net1_out=logsig(net1_in);      % 隐含层输出
    net2_int = [net1_out,1];       % 下一次输入
    net2_in = net2_int*net.w2;     % 输出层输入
    net2_out = logsig(net2_in);    % 输出层输出
    err=trainl(ind)-net2_out;      % 误差
    errt(x)=1/2*sqrt(sum(err.^2)); % 误差平方
    fprintf('第 %d 次循环， 第%d个学生， 误差  %f\n',x,ind, errt(x));
    
    % 调整权值
    for i=1:length(net1_out)+1 
        for j=1:1
            ipu1(j)=err(j);     % 局部梯度
            % 输出层与隐含层之间的调整量
            delta1(i,j) = ita.*ipu1(j).*net2_int(i); 
        end
        
    end
   
    for m=1:3
        for i=1:length(net1_out)
            % 局部梯度
            ipu2(i)=net1_out(i).*(1-net1_out(i)).*sum(ipu1.*net.w2);
            % 输入层和隐含层之间的调整量
            delta2(m,i)= ita.*in(m).*ipu2(i);
        end
    end
    
    % 调整权值
    if x==1
        net.w1 = net.w1+delta2;
        net.w2 = net.w2+delta1;
    else
        net.w1 = net.w1+delta2*(1-alpha) + alpha*old_delta2;
        net.w2 = net.w2+delta1*(1-alpha) + alpha*old_delta1;   
    end
    
    old_delta1=delta1;
    old_delta2=delta2;
end

%% 测试
% 测试数据归一化
for i=1:2
    testd_s(:,i)=testd(:,i)-mm(i);
end

for i=1:2
    testd_s(:,i)=testd_s(:,i)/ml(i);
end

testd_s = [testd_s,ones(length(testd_s),1)];
net1_in=testd_s*net.w1;
net1_out=logsig(net1_in);
net1_out=[net1_out,ones(length(net1_out),1)];
net2_int = net1_out;
net2_in = net2_int*net.w2;
net2_out=net2_in;
% 取整
net2_out(net2_out<0.5)=0;
net2_out(net2_out>=0.5)=1;
rate=sum(net2_out==testl')/length(net2_out);

%% 显示
fprintf('  正确率:\n    %f %%\n', rate*100);
figure(1);
plot(1:M,errt,'b-','LineWidth',1.5);
xlabel('迭代次数')
ylabel('误差')
title('BP网络串行训练的误差')
