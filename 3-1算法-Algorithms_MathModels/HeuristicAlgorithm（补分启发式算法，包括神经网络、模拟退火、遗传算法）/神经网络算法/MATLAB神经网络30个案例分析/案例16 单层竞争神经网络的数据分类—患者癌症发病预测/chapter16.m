%% 案例16：单层竞争神经网络的数据分类—患者癌症发病预测
% 
% 
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr>		<td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对<a target="_blank" href="http://www.ilovematlab.cn/thread-48362-1-1.html"><font color="#0000FF">该案例</font></a>提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2：此案例有配套的教学视频，配套的完整可运行Matlab程序。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		3：以下内容为该案例的部分内容（约占该案例完整内容的1/10）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（<a target="_blank" href="http://www.ilovematlab.cn/">Matlab中文论坛</a>，<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html">《Matlab神经网络30个案例分析》</a>）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		6：您看到的以下内容为初稿，书籍的实际内容可能有少许出入，以书籍实际发行内容为准。</font></span></td>	</tr><tr>		<td><span class="comment"><font size="2">		7：此书其他常见问题、预定方式等，<a target="_blank" href="http://www.ilovematlab.cn/thread-47939-1-1.html">请点击这里</a>。</font></span></td>	</tr></table>
% </html>
% 


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

web browser http://www.ilovematlab.cn/viewthread.php?tid=60656
%%
% 
% <html>
% <table align="center" >	<tr>		<td align="center"><font size="2">版权所有：</font><a
% href="http://www.ilovematlab.cn/">Matlab中文论坛</a>&nbsp;&nbsp; <script
% src="http://s3.cnzz.com/stat.php?id=971931&web_id=971931&show=pic" language="JavaScript" ></script>&nbsp;</td>	</tr></table>
% </html>
% 

