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
%% 导入记忆模式
T = [-1 -1 1; 1 -1 1]';
%% 权值和阈值学习
[S,Q] = size(T);
Y = T(:,1:Q-1)-T(:,Q)*ones(1,Q-1);
[U,SS,V] = svd(Y);
K = rank(SS);

TP = zeros(S,S);
for k=1:K
  TP = TP + U(:,k)*U(:,k)';
  end

TM = zeros(S,S);
for k=K+1:S
  TM = TM + U(:,k)*U(:,k)';
  end

tau = 10;
Ttau = TP - tau*TM;
Itau = T(:,Q) - Ttau*T(:,Q);

h = 0.15;
C1 = exp(h)-1;
C2 = -(exp(-tau*h)-1)/tau;

w = expm(h*Ttau);
b = U * [  C1*eye(K)         zeros(K,S-K);
         zeros(S-K,K)  C2*eye(S-K)] * U' * Itau;
%% 导入待记忆的模式
Ai =[-0.7; -0.6; 0.6];
y0=Ai;
%% 迭代计算
for i=1:5
    for j=1:size(y0,1)
        y{i}(j,:)=satlins(w(j,:)*y0+b(j));
    end
    y0=y{i};
end
y{1}
web browser http://www.ilovematlab.cn/thread-60676-1-1.html
%%
% 
% <html>
% <table align="center" >	<tr>		<td align="center"><font size="2">版权所有：</font><a
% href="http://www.ilovematlab.cn/">Matlab中文论坛</a>&nbsp;&nbsp; <script
% src="http://s3.cnzz.com/stat.php?id=971931&web_id=971931&show=pic" language="JavaScript" ></script>&nbsp;</td>	</tr></table>
% </html>
% 