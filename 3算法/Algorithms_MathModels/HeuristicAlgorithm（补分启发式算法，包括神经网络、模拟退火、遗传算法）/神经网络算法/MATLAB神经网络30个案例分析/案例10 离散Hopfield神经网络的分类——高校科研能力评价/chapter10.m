%% 离散Hopfield的分类——高校科研能力评价
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr>		<td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对<a target="_blank" href="http://www.ilovematlab.cn/thread-49221-1-1.html"><font color="#0000FF">该案例</font></a>提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2：此案例有配套的教学视频，配套的完整可运行Matlab程序。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		3：以下内容为该案例的部分内容（约占该案例完整内容的1/10）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（<a target="_blank" href="http://www.ilovematlab.cn/">Matlab中文论坛</a>，<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html">《Matlab神经网络30个案例分析》</a>）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		6：您看到的以下内容为初稿，书籍的实际内容可能有少许出入，以书籍实际发行内容为准。</font></span></td>	</tr><tr>		<td><span class="comment"><font size="2">		7：此书其他常见问题、预定方式等，<a target="_blank" href="http://www.ilovematlab.cn/thread-47939-1-1.html">请点击这里</a>。</font></span></td>	</tr></table>
% </html>
%
web browser http://www.ilovematlab.cn/thread-60676-1-1.html
%% 清空环境变量
clear all
clc
%% 导入数据
load class.mat
%% 目标向量
T=[class_1 class_2 class_3 class_4 class_5];
%% 创建网络
net=newhop(T);
%% 导入待分类样本
load sim.mat
A={[sim_1 sim_2 sim_3 sim_4 sim_5]};
%% 网络仿真
Y=sim(net,{25 20},{},A);
%% 结果显示
Y1=Y{20}(:,1:5)
Y2=Y{20}(:,6:10)
Y3=Y{20}(:,11:15)
Y4=Y{20}(:,16:20)
Y5=Y{20}(:,21:25)
%% 绘图
result={T;A{1};Y{20}};
figure
for p=1:3
    for k=1:5 
        subplot(3,5,(p-1)*5+k)
        temp=result{p}(:,(k-1)*5+1:k*5);
        [m,n]=size(temp);
        for i=1:m
            for j=1:n
                if temp(i,j)>0
                   plot(j,m-i,'ko','MarkerFaceColor','k');
                else
                   plot(j,m-i,'ko');
                end
                hold on
            end
        end
        axis([0 6 0 12])
        axis off
        if p==1
           title(['class' num2str(k)])
        elseif p==2
           title(['pre-sim' num2str(k)])
        else
           title(['sim' num2str(k)])
        end
    end                
end
% 
noisy=[1 -1 -1 -1 -1;-1 -1 -1 1 -1;
       -1 1 -1 -1 -1;-1 1 -1 -1 -1;
       1 -1 -1 -1 -1;-1 -1 1 -1 -1;
       -1 -1 -1 1 -1;-1 -1 -1 -1 1;
       -1 1 -1 -1 -1;-1 -1 -1 1 -1;
       -1 -1 1 -1 -1];
y=sim(net,{5 100},{},{noisy});
a=y{100}
web browser http://www.ilovematlab.cn/thread-60676-1-1.html
%%
% 
% <html>
% <table align="center" >	<tr>		<td align="center"><font size="2">版权所有：</font><a
% href="http://www.ilovematlab.cn/">Matlab中文论坛</a>&nbsp;&nbsp; <script
% src="http://s3.cnzz.com/stat.php?id=971931&web_id=971931&show=pic" language="JavaScript" ></script>&nbsp;</td>	</tr></table>
% </html>
% 




