%% Hopfield神经网络的联想记忆——数字识别
% 
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对该案例提问，做到有问必答。本套书籍官方网站为：<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2：点此<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">从当当预定本书</a>：<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">《Matlab神经网络30个案例分析》</a>。</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">：此案例有配套的教学视频，视频下载方式<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">。 </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（《Matlab神经网络30个案例分析》）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		</table>
% </html>

%% 清除环境变量
clear all
clc

%% 导入记忆模式
load data1.mat
T = array_one; 

%% 外积法计算权系数矩阵
[m,n] = size(T);
w = zeros(m);
for i = 1:n
    w = w + T(:,i) * T(:,i)' - eye(m);
end

%% 导入待记忆模式
noisy_array = T;
for i = 1:100
    a = rand;
    if a < 0.2
       noisy_array(i) = -T(i);
    end
end

%% 迭代计算
v0 = noisy_array;
v = zeros(m,n);
for k = 1:5
    for i = 1:m
        v(i,:) = sign(w(i,:)*v0);
    end
    v0 = v;
end

%% 绘图
subplot(3,1,1)
t = imresize(T,20);
imshow(t)
title('标准')
subplot(3,1,2)
Noisy_array = imresize(noisy_array,20);
imshow(Noisy_array)
title('噪声')
subplot(3,1,3)
V = imresize(v,20);
imshow(V)
title('识别')

web browser http://www.matlabsky.com/thread-11145-1-2.html

%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p><font size="2"><a href="http://video.ourmatlab.com/">Matlab神经网络30个案例分析</a></font></p><p align="left"><font size="2">相关论坛：</font></p><p align="left"><font size="2">《Matlab神经网络30个案例分析》官方网站：<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></p><p align="left"><font size="2">Matlab技术论坛：<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab函数百科：<a href="http://www.mfun.la">www.mfun.la</a></font></p><p align="left"><font size="2">Matlab中文论坛：<a href="http://www.ilovematlab.com">www.ilovematlab.com</a></font></p></td>	</tr></table>
% </html>