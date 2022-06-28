%% Hopfield神经网络的联想记忆——数字识别
% 
% 
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对该案例提问，做到有问必答。本套书籍官方网站为：<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2：点此<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">从当当预定本书</a>：<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">《Matlab神经网络30个案例分析》</a>。</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">：此案例有配套的教学视频，视频下载方式<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">。 </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（《Matlab神经网络30个案例分析》）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		</table>
% </html>
% 

%% 清空环境变量
clear all
clc

%% 数据导入
load data1 array_one
load data2 array_two

%% 训练样本（目标向量）
 T = [array_one;array_two]';
 
%% 创建网络
 net = newhop(T);
 
%% 数字1和2的带噪声数字点阵（固定法）
load data1_noisy noisy_array_one
load data2_noisy noisy_array_two

%% 数字1和2的带噪声数字点阵（随机法）

% noisy_array_one=array_one;
% noisy_array_two=array_two;
% for i = 1:100
%     a = rand;
%     if a < 0.3
%        noisy_array_one(i) = -array_one(i);
%        noisy_array_two(i) = -array_two(i);
%     end
% end

%% 数字识别

% 单步仿真——TS = 1(矩阵形式)
% identify_one = sim(net,10,[],noisy_array_one');  
% 多步仿真——元胞数组形式
noisy_one = {(noisy_array_one)'};                    
identify_one = sim(net,{10,10},{},noisy_one);
identify_one{10}';
noisy_two = {(noisy_array_two)'};
identify_two = sim(net,{10,10},{},noisy_two);
identify_two{10}';

%% 结果显示
Array_one = imresize(array_one,20);
subplot(3,2,1)
imshow(Array_one)
title('标准(数字1)') 
Array_two = imresize(array_two,20);
subplot(3,2,2)
imshow(Array_two)
title('标准(数字2)') 
subplot(3,2,3)
Noisy_array_one = imresize(noisy_array_one,20);
imshow(Noisy_array_one)
title('噪声(数字1)') 
subplot(3,2,4)
Noisy_array_two = imresize(noisy_array_two,20);
imshow(Noisy_array_two)
title('噪声(数字2)')
subplot(3,2,5)
imshow(imresize(identify_one{10}',20))
title('识别(数字1)')
subplot(3,2,6)
imshow(imresize(identify_two{10}',20))
title('识别(数字2)')

web browser http://www.matlabsky.com/thread-11145-1-2.html

%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p><font size="2"><a href="http://video.ourmatlab.com/">Matlab神经网络30个案例分析</a></font></p><p align="left"><font size="2">相关论坛：</font></p><p align="left"><font size="2">《Matlab神经网络30个案例分析》官方网站：<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></p><p align="left"><font size="2">Matlab技术论坛：<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab函数百科：<a href="http://www.mfun.la">www.mfun.la</a></font></p><p align="left"><font size="2">Matlab中文论坛：<a href="http://www.ilovematlab.com">www.ilovematlab.com</a></font></p></td>	</tr></table>
% </html>


