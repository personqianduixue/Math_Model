%% Matlab神经网络43个案例分析

% GRNN的数据预测—基于广义回归神经网络的货运量预测
% by 王小川(@王小川_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
 
%% 以下程序为案例扩展里的GRNN和BP比较 需要load chapter8.1的相关数据
clear all
load best
n=13
p=desired_input
t=desired_output
net_bp=newff(minmax(p),[n,3],{'tansig','purelin'},'trainlm');
% 训练网络
net.trainParam.show=50;
net.trainParam.epochs=2000;
net.trainParam.goal=1e-3;
%调用TRAINLM算法训练BP网络
net_bp=train(net_bp,p,t);
bp_prediction_result=sim(net_bp,p_test);
bp_prediction_result=postmnmx(bp_prediction_result,mint,maxt);
bp_error=t_test-bp_prediction_result';
disp(['BP神经网络三项流量预测的误差为',num2str(abs(bp_error))])
