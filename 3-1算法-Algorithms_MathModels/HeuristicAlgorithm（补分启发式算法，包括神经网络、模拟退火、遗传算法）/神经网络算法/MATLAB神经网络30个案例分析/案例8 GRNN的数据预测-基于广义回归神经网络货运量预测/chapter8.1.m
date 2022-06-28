%% 案例8：GRNN的数据预测—基于广义回归神经网络的货运量预测
%
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr>		<td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对<a target="_blank" href="http://www.ilovematlab.cn/thread-48362-1-1.html"><font color="#0000FF">该案例</font></a>提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2：此案例有配套的教学视频，配套的完整可运行Matlab程序。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		3：以下内容为该案例的部分内容（约占该案例完整内容的1/10）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（<a target="_blank" href="http://www.ilovematlab.cn/">Matlab中文论坛</a>，<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html">《Matlab神经网络30个案例分析》</a>）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		6：您看到的以下内容为初稿，书籍的实际内容可能有少许出入，以书籍实际发行内容为准。</font></span></td>	</tr><tr>		<td><span class="comment"><font size="2">		7：此书其他常见问题、预定方式等，<a target="_blank" href="http://www.ilovematlab.cn/thread-47939-1-1.html">请点击这里</a>。</font></span></td>	</tr></table>
% </html>
%
%% 清空环境变量
clc;
clear all
close all
nntwarn off;

%% 载入数据
load data;
% 载入数据并将数据分成训练和预测两类
p_train=p(1:12,:);
t_train=t(1:12,:);
p_test=p(13,:);
t_test=t(13,:);
%% 交叉验证
desired_spread=[];
mse_max=10e20;
desired_input=[];
desired_output=[];
result_perfp=[];
indices = crossvalind('Kfold',length(p_train),4);
h=waitbar(0,'正在寻找最优化参数....')
k=1;
for i = 1:4
    perfp=[];
    disp(['以下为第',num2str(i),'次交叉验证结果'])
    test = (indices == i); train = ~test;
    p_cv_train=p_train(train,:);
    t_cv_train=t_train(train,:);
    p_cv_test=p_train(test,:);
    t_cv_test=t_train(test,:);
    p_cv_train=p_cv_train';
    t_cv_train=t_cv_train';
    p_cv_test= p_cv_test';
    t_cv_test= t_cv_test';
    [p_cv_train,minp,maxp,t_cv_train,mint,maxt]=premnmx(p_cv_train,t_cv_train);
    p_cv_test=tramnmx(p_cv_test,minp,maxp);
    for spread=0.1:0.1:2;
        net=newgrnn(p_cv_train,t_cv_train,spread);
        waitbar(k/80,h);
        disp(['当前spread值为', num2str(spread)]);
        test_Out=sim(net,p_cv_test);
        test_Out=postmnmx(test_Out,mint,maxt);
        error=t_cv_test-test_Out;
        disp(['当前网络的mse为',num2str(mse(error))])
        perfp=[perfp mse(error)];
        if mse(error)<mse_max
            mse_max=mse(error);
            desired_spread=spread;
            desired_input=p_cv_train;
            desired_output=t_cv_train;
        end
        k=k+1;
    end
    result_perfp(i,:)=perfp;
end;
close(h)
disp(['最佳spread值为',num2str(desired_spread)])
disp(['此时最佳输入值为'])
desired_input
disp(['此时最佳输出值为'])
desired_output
%% 采用最佳方法建立GRNN网络
net=newgrnn(desired_input,desired_output,desired_spread);
p_test=p_test';
p_test=tramnmx(p_test,minp,maxp);
grnn_prediction_result=sim(net,p_test);
grnn_prediction_result=postmnmx(grnn_prediction_result,mint,maxt);
grnn_error=t_test-grnn_prediction_result';
disp(['GRNN神经网络三项流量预测的误差为',num2str(abs(grnn_error))])
save best desired_input desired_output p_test t_test grnn_error mint maxt

web browser http://www.ilovematlab.cn/thread-65171-1-1.html
%%
%
% <html>
% <table align="center" >	<tr>		<td align="center"><font size="2">版权所有：</font><a
% href="http://www.ilovematlab.cn/">Matlab中文论坛</a>&nbsp;&nbsp; <script
% src="http://s3.cnzz.com/stat.php?id=971931&web_id=971931&show=pic" language="JavaScript" ></script>&nbsp;</td>	</tr></table>
% </html>
%



     
 
 
 
 
 
 
 