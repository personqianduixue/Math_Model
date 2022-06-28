%% 第25章 有导师学习神经网络的回归拟合——基于近红外光谱的汽油辛烷值预测
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.matlabsky.com/forum-78-1.html"><font color="#0000FF">板块</font></a>里，对该案例提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2</font><font size="2">：此案例有配套的教学视频，视频下载请点击<a href="http://www.matlabsky.com/forum-91-1.html">http://www.matlabsky.com/forum-91-1.html</a></font><font size="2">。 </font></span></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		3：此案例为原创案例，转载请注明出处（《MATLAB智能算法30个案例分析》）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		5：以下内容为初稿，与实际发行的书籍内容略有出入，请以书籍中的内容为准。</font></span></td>	</tr>	</table>
% </html>

%% 清空环境变量
clear all
clc

%% 训练集/测试集产生
load spectra_data.mat
% 随机产生训练集和测试集
temp = randperm(size(NIR,1));
% 训练集——50个样本
P_train = NIR(temp(1:50),:)';
T_train = octane(temp(1:50),:)';
% 测试集——10个样本
P_test = NIR(temp(51:end),:)';
T_test = octane(temp(51:end),:)';
N = size(P_test,2);

%% BP神经网络创建、训练及仿真测试

% 创建网络
net = newff(P_train,T_train,9);
% 设置训练参数
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-3;
net.trainParam.lr = 0.01;
% 训练网络
net = train(net,P_train,T_train);
% 仿真测试
T_sim_bp = sim(net,P_test);

%% RBF神经网络创建及仿真测试

% 创建网络
net = newrbe(P_train,T_train,0.3);
% 仿真测试
T_sim_rbf = sim(net,P_test);

%% 性能评价

% 相对误差error
error_bp = abs(T_sim_bp - T_test)./T_test;
error_rbf = abs(T_sim_rbf - T_test)./T_test;
% 决定系数R^2
R2_bp = (N * sum(T_sim_bp .* T_test) - sum(T_sim_bp) * sum(T_test))^2 / ((N * sum((T_sim_bp).^2) - (sum(T_sim_bp))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 
R2_rbf = (N * sum(T_sim_rbf .* T_test) - sum(T_sim_rbf) * sum(T_test))^2 / ((N * sum((T_sim_rbf).^2) - (sum(T_sim_rbf))^2) * (N * sum((T_test).^2) - (sum(T_test))^2));
% 结果对比
result_bp = [T_test' T_sim_bp' T_sim_rbf' error_bp' error_rbf']

%% 绘图
figure
plot(1:N,T_test,'b:*',1:N,T_sim_bp,'r-o',1:N,T_sim_rbf,'k-.^')
legend('真实值','BP预测值','RBF预测值')
xlabel('预测样本')
ylabel('辛烷值')
string = {'测试集辛烷值含量预测结果对比(BP vs RBF)';['R^2=' num2str(R2_bp) '(BP)' '  R^2=' num2str(R2_rbf) '(RBF)']};
title(string)

%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p align="left"><font size="2">相关论坛：</font></p><p align="left"><font size="2">Matlab技术论坛：<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab函数百科：<a href="http://www.mfun.la">www.mfun.la</a></font></p></td>	</tr></table>
% </html>
