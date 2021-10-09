%% Hopfield神经网络的联想记忆——数字识别
% 
% 
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr>		<td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对<a target="_blank" href="http://www.ilovematlab.cn/thread-48362-1-1.html"><font color="#0000FF">该案例</font></a>提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2：此案例有配套的教学视频，配套的完整可运行Matlab程序。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		3：以下内容为该案例的部分内容（约占该案例完整内容的1/10）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（<a target="_blank" href="http://www.ilovematlab.cn/">Matlab中文论坛</a>，<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html">《Matlab神经网络30个案例分析》</a>）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		6：您看到的以下内容为初稿，书籍的实际内容可能有少许出入，以书籍实际发行内容为准。</font></span></td>	</tr><tr>		<td><span class="comment"><font size="2">		7：此书其他常见问题、预定方式等，<a target="_blank" href="http://www.ilovematlab.cn/thread-47939-1-1.html">请点击这里</a>。</font></span></td>	</tr></table>
% </html>
% 
web browser http://www.ilovematlab.cn/thread-60165-1-1.html
%% 清空环境变量
clc
clear
%% 数据导入
load data1 array_one
load data2 array_two
%% 训练样本（目标向量）
 T=[array_one;array_two]';
%% 创建网络
 net=newhop(T);
%% 数字1和2的带噪声数字点阵（固定法）
load data1_noisy noisy_array_one
load data2_noisy noisy_array_two
%% 数字1和2的带噪声数字点阵（随机法）
% noisy_array_one=array_one;
% noisy_array_two=array_two;
% for i=1:100
%     a=rand;
%     if a<0.3
%        noisy_array_one(i)=-array_one(i);
%        noisy_array_two(i)=-array_two(i);
%     end
% end
%% 数字识别
% identify_one=sim(net,10,[],noisy_array_one');
noisy_one={(noisy_array_one)'};
identify_one=sim(net,{10,10},{},noisy_one);
identify_one{10}';
noisy_two={(noisy_array_two)'};
identify_two=sim(net,{10,10},{},noisy_two);
identify_two{10}';
%% 结果显示
Array_one=imresize(array_one,20);
subplot(3,2,1)
imshow(Array_one)
title('标准(数字1)') 
Array_two=imresize(array_two,20);
subplot(3,2,2)
imshow(Array_two)
title('标准(数字2)') 
subplot(3,2,3)
Noisy_array_one=imresize(noisy_array_one,20);
imshow(Noisy_array_one)
title('噪声(数字1)') 
subplot(3,2,4)
Noisy_array_two=imresize(noisy_array_two,20);
imshow(Noisy_array_two)
title('噪声(数字2)')
subplot(3,2,5)
imshow(imresize(identify_one{10}',20))
title('识别(数字1)')
subplot(3,2,6)
imshow(imresize(identify_two{10}',20))
title('识别(数字2)')
web browser http://www.ilovematlab.cn/thread-60165-1-1.html
%%
% 
% <html>
% <table align="center" >	<tr>		<td align="center"><font size="2">版权所有：</font><a
% href="http://www.ilovematlab.cn/">Matlab中文论坛</a>&nbsp;&nbsp; <script
% src="http://s3.cnzz.com/stat.php?id=971931&web_id=971931&show=pic" language="JavaScript" ></script>&nbsp;</td>	</tr></table>
% </html>
% 

