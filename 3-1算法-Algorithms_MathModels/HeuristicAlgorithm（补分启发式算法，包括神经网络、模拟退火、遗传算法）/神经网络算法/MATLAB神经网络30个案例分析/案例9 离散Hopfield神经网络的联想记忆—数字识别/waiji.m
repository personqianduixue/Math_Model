%% Hopfield神经网络的联想记忆——数字识别
% 
% 
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr>		<td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对<a target="_blank" href="http://www.ilovematlab.cn/thread-48362-1-1.html"><font color="#0000FF">该案例</font></a>提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2：此案例有配套的教学视频，配套的完整可运行Matlab程序。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		3：以下内容为该案例的部分内容（约占该案例完整内容的1/10）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（<a target="_blank" href="http://www.ilovematlab.cn/">Matlab中文论坛</a>，<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html">《Matlab神经网络30个案例分析》</a>）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		6：您看到的以下内容为初稿，书籍的实际内容可能有少许出入，以书籍实际发行内容为准。</font></span></td>	</tr><tr>		<td><span class="comment"><font size="2">		7：此书其他常见问题、预定方式等，<a target="_blank" href="http://www.ilovematlab.cn/thread-47939-1-1.html">请点击这里</a>。</font></span></td>	</tr></table>
% </html>
% 
web browser http://www.ilovematlab.cn/thread-60165-1-1.html
%% 清除环境变量
clear all
clc
%% 导入记忆模式
load data1.mat
T=array_one;
%% 外积法计算权系数矩阵
[m,n]=size(T);
w=zeros(m);
for i=1:n
    w=w+T(:,i)*T(:,i)'-eye(m);
end
%% 导入待记忆模式
noisy_array=T;
for i=1:100
    a=rand;
    if a<0
       noisy_array(i)=-T(i);
    end
end
%% 迭代计算
v0=noisy_array;
v=zeros(m,n);
for k=1:5
    for i=1:m
        v(i,:)=sign(w(i,:)*v0);
    end
    v0=v;
end
%% 绘图
subplot(3,1,1)
t=imresize(T,20);
imshow(t)
title('标准')
subplot(3,1,2)
Noisy_array=imresize(noisy_array,20);
imshow(Noisy_array)
title('噪声')
subplot(3,1,3)
V=imresize(v,20);
imshow(V)
title('识别')
web browser http://www.ilovematlab.cn/thread-60165-1-1.html
%%
% 
% <html>
% <table align="center" >	<tr>		<td align="center"><font size="2">版权所有：</font><a
% href="http://www.ilovematlab.cn/">Matlab中文论坛</a>&nbsp;&nbsp; <script
% src="http://s3.cnzz.com/stat.php?id=971931&web_id=971931&show=pic" language="JavaScript" ></script>&nbsp;</td>	</tr></table>
% </html>
% 