%% 案例16：单层竞争神经网络的数据分类—患者癌症发病预测
% 
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对该案例提问，做到有问必答。本套书籍官方网站为：<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2：点此<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">从当当预定本书</a>：<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">《Matlab神经网络30个案例分析》</a>。</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">：此案例有配套的教学视频，视频下载方式<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">。 </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（《Matlab神经网络30个案例分析》）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		</table>
% </html>




%% 清空环境变量
clc
clear

%% 录入输入数据
% 载入数据并将数据分成训练和预测两类
load gene.mat;
data=gene;
P=data(1:40,:);
T=data(41:60,:);

% 转置后符合神经网络的输入格式
P=P';
T=T';
% 取输入元素的最大值和最小值Q：
Q=minmax(P);

%% 网络建立和训练
% 利用newc( )命令建立竞争网络：2代表竞争层的神经元个数，也就是要分类的个数。0.1代表学习速率。
net=newc(Q,2,0.1)

% 初始化网络及设定网络参数：
net=init(net);
net.trainparam.epochs=20;
% 训练网络：
net=train(net,P);


%% 网络的效果验证

% 将原数据回带，测试网络效果：
a=sim(net,P);
ac=vec2ind(a)

% 这里使用了变换函数vec2ind()，用于将单值向量组变换成下标向量。其调用的格式为：
%  ind=vec2ind(vec)
% 其中，
% vec：为m行n列的向量矩阵x，x中的每个列向量i，除包含一个1外，其余元素均为0。
% ind：为n个元素值为1所在的行下标值构成的一个行向量。



%% 网络作分类的预测
% 下面将后20个数据带入神经网络模型中，观察网络输出：
% sim( )来做网络仿真
Y=sim(net,T)
yc=vec2ind(Y)

web browser http://www.matlabsky.com/thread-11161-1-2.html

%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p><font size="2"><a href="http://video.ourmatlab.com/">Matlab神经网络30个案例分析</a></font></p><p align="left"><font size="2">相关论坛：</font></p><p align="left"><font size="2">《Matlab神经网络30个案例分析》官方网站：<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></p><p align="left"><font size="2">Matlab技术论坛：<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab函数百科：<a href="http://www.mfun.la">www.mfun.la</a></font></p><p align="left"><font size="2">Matlab中文论坛：<a href="http://www.ilovematlab.com">www.ilovematlab.com</a></font></p></td>	</tr></table>
% </html>
