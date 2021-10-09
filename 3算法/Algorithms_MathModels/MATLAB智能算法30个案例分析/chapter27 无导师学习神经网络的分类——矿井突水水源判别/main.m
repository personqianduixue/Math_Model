%% 第27章 无导师学习神经网络的分类——矿井突水水源判别
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.matlabsky.com/forum-78-1.html"><font color="#0000FF">板块</font></a>里，对该案例提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2</font><font size="2">：此案例有配套的教学视频，视频下载请点击<a href="http://www.matlabsky.com/forum-91-1.html">http://www.matlabsky.com/forum-91-1.html</a></font><font size="2">。 </font></span></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		3：此案例为原创案例，转载请注明出处（《MATLAB智能算法30个案例分析》）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		5：以下内容为初稿，与实际发行的书籍内容略有出入，请以书籍中的内容为准。</font></span></td>	</tr>	</table>
% </html>

%% 清空环境变量
clear all
clc

%% 训练集/测试集产生

% 导入数据
load water_data.mat
% 数据归一化
attributes = mapminmax(attributes);
% 训练集——35个样本
P_train = attributes(:,1:35);
T_train = classes(:,1:35);
% 测试集——4个样本
P_test = attributes(:,36:end);
T_test = classes(:,36:end);

%% 竞争神经网络创建、训练及仿真测试

% 创建网络
net = newc(minmax(P_train),4,0.01,0.01);
% 设置训练参数
net.trainParam.epochs = 500;
% 训练网络
net = train(net,P_train);
% 仿真测试
% 训练集
t_sim_compet_1 = sim(net,P_train);
T_sim_compet_1 = vec2ind(t_sim_compet_1);
% 测试集
t_sim_compet_2 = sim(net,P_test);
T_sim_compet_2 = vec2ind(t_sim_compet_2);

%% SOFM神经网络创建、训练及仿真测试

% 创建网络
net = newsom(P_train,[4 4]);
% 设置训练参数
net.trainParam.epochs = 200;
% 训练网络
net = train(net,P_train);
% 仿真测试
% 训练集
t_sim_sofm_1 = sim(net,P_train);
T_sim_sofm_1 = vec2ind(t_sim_sofm_1);
% 测试集
t_sim_sofm_2 = sim(net,P_test);
T_sim_sofm_2 = vec2ind(t_sim_sofm_2);

%% 结果对比

% 竞争神经网络
result_compet_1 = [T_train' T_sim_compet_1']
result_compet_2 = [T_test' T_sim_compet_2']
% SOFM神经网络
result_sofm_1 = [T_train' T_sim_sofm_1']
result_sofm_2 = [T_test' T_sim_sofm_2']

%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p align="left"><font size="2">相关论坛：</font></p><p align="left"><font size="2">Matlab技术论坛：<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab函数百科：<a href="http://www.mfun.la">www.mfun.la</a></font></p></td>	</tr></table>
% </html>