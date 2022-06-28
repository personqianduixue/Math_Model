%% 案例7：RBF网络的回归-非线性函数回归的实现 
% 
% 
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr>		<td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对<a target="_blank" href="http://www.ilovematlab.cn/thread-48362-1-1.html"><font color="#0000FF">该案例</font></a>提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2：此案例有配套的教学视频，配套的完整可运行Matlab程序。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		3：以下内容为该案例的部分内容（约占该案例完整内容的1/10）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（<a target="_blank" href="http://www.ilovematlab.cn/">Matlab中文论坛</a>，<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html">《Matlab神经网络30个案例分析》</a>）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		6：您看到的以下内容为初稿，书籍的实际内容可能有少许出入，以书籍实际发行内容为准。</font></span></td>	</tr><tr>		<td><span class="comment"><font size="2">		7：此书其他常见问题、预定方式等，<a target="_blank" href="http://www.ilovematlab.cn/thread-47939-1-1.html">请点击这里</a>。</font></span></td>	</tr></table>
% </html>
% 


%% 清空环境变量
clc
clear
%% 产生训练样本（训练输入，训练输出）
% ld为样本例数
ld=400; 

% 产生2*ld的矩阵 
x=rand(2,ld); 

% 将x转换到[-1.5 1.5]之间
x=(x-0.5)*1.5*2; 

% x的第一列为x1，第二列为x2.
x1=x(1,:);
x2=x(2,:);

% 计算网络输出F值
F=20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2);

%% 建立RBF神经网络 
% 采用approximate RBF神经网络。spread为默认值
net=newrb(x,F);

%% 建立测试样本

% generate the testing data
interval=0.1;
[i, j]=meshgrid(-1.5:interval:1.5);
row=size(i);
tx1=i(:);
tx1=tx1';
tx2=j(:);
tx2=tx2';
tx=[tx1;tx2];

%% 使用建立的RBF网络进行模拟，得出网络输出
ty=sim(net,tx);

%% 使用图像，画出3维图

% 真正的函数图像
interval=0.1;
[x1, x2]=meshgrid(-1.5:interval:1.5);
F = 20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2);
subplot(1,3,1)
mesh(x1,x2,F);
zlim([0,60])
title('真正的函数图像')

% 网络得出的函数图像
v=reshape(ty,row);
subplot(1,3,2)
mesh(i,j,v);
zlim([0,60])
title('RBF神经网络结果')


% 误差图像
subplot(1,3,3)
mesh(x1,x2,F-v);
zlim([0,60])
title('误差图像')

set(gcf,'position',[300 ,250,900,400])

web browser http://www.ilovematlab.cn/viewthread.php?tid=65099
%%
% 
% <html>
% <table align="center" >	<tr>		<td align="center"><font size="2">版权所有：</font><a
% href="http://www.ilovematlab.cn/">Matlab中文论坛</a>&nbsp;&nbsp; <script
% src="http://s3.cnzz.com/stat.php?id=971931&web_id=971931&show=pic" language="JavaScript" ></script>&nbsp;</td>	</tr></table>
% </html>
% 

