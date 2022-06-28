%% 该代码为基于Kohonen网络的分类算法
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对该案例提问，做到有问必答。本套书籍官方网站为：<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2：点此<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">从当当预定本书</a>：<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">《Matlab神经网络30个案例分析》</a>。</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">：此案例有配套的教学视频，视频下载方式<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">。 </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（《Matlab神经网络30个案例分析》）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		</table>
% </html>
%% 清空环境变量
clc
clear

%% 数据处理
load data
input=datatrain(:,1:38);
%数据归一化
[inputn,inputps]=mapminmax(input);
%inputn=inputn';
[nn,mm]=size(inputn);

%% 网络构建
%输入层节点数
Inum=38; 

%Kohonen网络
M=6;
N=6; 
K=M*N;%Kohonen总节点数

%Kohonen层节点排序
k=1;
for i=1:M
    for j=1:N
        jdpx(k,:)=[i,j];
        k=k+1;
    end
end

%学习率
rate1max=0.2;   
rate1min=0.05;
%学习半径
r1max=1.5;         
r1min=0.8;

%权值初始化
w1=rand(Inum,K);    %第一层权值

%% 迭代求解
maxgen=10000;
for i=1:maxgen
    
    %自适应学习率和相应半径
    rate1=rate1max-i/maxgen*(rate1max-rate1min);
    r=r1max-i/maxgen*(r1max-r1min);
    
    %从数据中随机抽取
    k=unidrnd(4000);   
    x=inputn(k,:);

    %计算最优节点
    [mindist,index]=min(dist(x,w1));
    
    %计算周围节点
    d1=ceil(index/6);
    d2=mod(index,6);
    nodeindex=find(dist([d1 d2],jdpx')<r);
    
    %权值更新
    for j=1:K
        %满足增加权值
        if sum(nodeindex==j)
            w1(:,j)=w1(:,j)+rate1*(x'-w1(:,j));
        end
    end
end

%% 聚类结果
Index=[];
for i=1:4000
    [mindist,index]=min(dist(inputn(i,:),w1));
    Index=[Index,index];
end
web browser www.matlabsky.com
%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p><font size="2"><a href="http://video.ourmatlab.com/">Matlab神经网络30个案例分析</a></font></p><p align="left"><font size="2">相关论坛：</font></p><p align="left"><font size="2">《Matlab神经网络30个案例分析》官方网站：<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></p><p align="left"><font size="2">Matlab技术论坛：<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab函数百科：<a href="http://www.mfun.la">www.mfun.la</a></font></p><p align="left"><font size="2">Matlab中文论坛：<a href="http://www.ilovematlab.com">www.ilovematlab.com</a></font></p></td>	</tr></table>
% </html>