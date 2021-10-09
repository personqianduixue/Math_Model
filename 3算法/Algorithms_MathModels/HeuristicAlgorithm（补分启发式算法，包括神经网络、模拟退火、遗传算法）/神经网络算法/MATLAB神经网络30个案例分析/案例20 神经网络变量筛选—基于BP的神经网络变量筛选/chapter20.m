%% 案例20:神经网络变量筛选—基于BP的神经网络变量筛选
%
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr>		<td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对<a target="_blank" href="http://www.ilovematlab.cn/thread-48362-1-1.html"><font color="#0000FF">该案例</font></a>提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2：此案例有配套的教学视频，配套的完整可运行Matlab程序。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		3：以下内容为该案例的部分内容（约占该案例完整内容的1/10）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（<a target="_blank" href="http://www.ilovematlab.cn/">Matlab中文论坛</a>，<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html">《Matlab神经网络30个案例分析》</a>）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		6：您看到的以下内容为初稿，书籍的实际内容可能有少许出入，以书籍实际发行内容为准。</font></span></td>	</tr><tr>		<td><span class="comment"><font size="2">		7：此书其他常见问题、预定方式等，<a target="_blank" href="http://www.ilovematlab.cn/thread-47939-1-1.html">请点击这里</a>。</font></span></td>	</tr></table>
% </html>
%
%% 清空环境变量
clc
clear
%% 产生输入 输出数据

% 设置步长
interval=0.01;

% 产生x1 x2
x1=-1.5:interval:1.5;
x2=-1.5:interval:1.5;

% 产生x3 x4（噪声）
x=rand(1,301);
x3=(x-0.5)*1.5*2;
x4=(x-0.5)*1.5*2;

% 按照函数先求得相应的函数值，作为网络的输出。
F =20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2);

%设置网络输入输出值
p=[x1;x2;x3;x4];
t=F;


%% 变量筛选 MIV算法的初步实现（增加或者减少自变量）

p=p';
[m,n]=size(p);
yy_temp=p;

% p_increase为增加10%的矩阵 p_decrease为减少10%的矩阵
for i=1:n
    p=yy_temp;
    pX=p(:,i);
    pa=pX*1.1;
    p(:,i)=pa;
    aa=['p_increase'  int2str(i) '=p'];
    eval(aa);
end


for i=1:n
    p=yy_temp;
    pX=p(:,i);
    pa=pX*0.9;
    p(:,i)=pa;
    aa=['p_decrease' int2str(i) '=p'];
    eval(aa);
end


%% 利用原始数据训练一个正确的神经网络
nntwarn off;

p=p';
% bp网络建立
net=newff(minmax(p),[8,1],{'tansig','purelin'},'traingdm');
% 初始化bp网络
net=init(net);
% 网络训练参数设置
net.trainParam.show=50;
net.trainParam.lr=0.05;
net.trainParam.mc=0.9;
net.trainParam.epochs=2000;

% bp网络训练
net=train(net,p,t);


%% 变量筛选 MIV算法的后续实现（差值计算）

% 转置后sim

for i=1:n
    eval(['p_increase',num2str(i),'=transpose(p_increase',num2str(i),')'])
end

for i=1:n
    eval(['p_decrease',num2str(i),'=transpose(p_decrease',num2str(i),')'])
end


% result_in为增加10%后的输出 result_de为减少10%后的输出
for i=1:n
    eval(['result_in',num2str(i),'=sim(net,','p_increase',num2str(i),')'])
end

for i=1:n
    eval(['result_de',num2str(i),'=sim(net,','p_decrease',num2str(i),')'])
end

for i=1:n
    eval(['result_in',num2str(i),'=transpose(result_in',num2str(i),')'])
end

for i=1:n
    eval(['result_de',num2str(i),'=transpose(result_de',num2str(i),')'])
end

%% MIV的值为各个项网络输出的MIV值 MIV被认为是在神经网络中评价变量相关的最好指标之一，其符号代表相关的方向，绝对值大小代表影响的相对重要性。


for i=1:n
    IV= ['result_in',num2str(i), '-result_de',num2str(i)];
    eval(['MIV_',num2str(i) ,'=mean(',IV,')'])
    
end


web browse http://www.ilovematlab.cn/viewthread.php?tid=62460
%%
%
% <html>
% <table align="center" >	<tr>		<td align="center"><font size="2">版权所有：</font><a
% href="http://www.ilovematlab.cn/">Matlab中文论坛</a>&nbsp;&nbsp; <script
% src="http://s3.cnzz.com/stat.php?id=971931&web_id=971931&show=pic" language="JavaScript" ></script>&nbsp;</td>	</tr></table>
% </html>
%

