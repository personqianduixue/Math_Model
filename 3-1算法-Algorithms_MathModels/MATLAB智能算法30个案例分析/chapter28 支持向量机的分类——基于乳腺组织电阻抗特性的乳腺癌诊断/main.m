%% 第28章 支持向量机的分类——基于乳腺组织电阻抗特性的乳腺癌诊断
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.matlabsky.com/forum-78-1.html"><font color="#0000FF">板块</font></a>里，对该案例提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2</font><font size="2">：此案例有配套的教学视频，视频下载请点击<a href="http://www.matlabsky.com/forum-91-1.html">http://www.matlabsky.com/forum-91-1.html</a></font><font size="2">。 </font></span></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		3：此案例为原创案例，转载请注明出处（《MATLAB智能算法30个案例分析》）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		5：以下内容为初稿，与实际发行的书籍内容略有出入，请以书籍中的内容为准。</font></span></td>	</tr>	</table>
% </html>

%% 清空环境变量
clear all
clc

%% 导入数据
load BreastTissue_data.mat
% 随机产生训练集和测试集
n = randperm(size(matrix,1));
% 训练集——80个样本
train_matrix = matrix(n(1:80),:);
train_label = label(n(1:80),:);
% 测试集——26个样本
test_matrix = matrix(n(81:end),:);
test_label = label(n(81:end),:);

%% 数据归一化
[Train_matrix,PS] = mapminmax(train_matrix');
Train_matrix = Train_matrix';
Test_matrix = mapminmax('apply',test_matrix',PS);
Test_matrix = Test_matrix';

%% SVM创建/训练(RBF核函数)

% 寻找最佳c/g参数——交叉验证方法
[c,g] = meshgrid(-10:0.2:10,-10:0.2:10);
[m,n] = size(c);
cg = zeros(m,n);
eps = 10^(-4);
v = 5;
bestc = 1;
bestg = 0.1;
bestacc = 0;
for i = 1:m
    for j = 1:n
        cmd = ['-v ',num2str(v),' -t 2',' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j))];
        cg(i,j) = svmtrain(train_label,Train_matrix,cmd);     
        if cg(i,j) > bestacc
            bestacc = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end        
        if abs( cg(i,j)-bestacc )<=eps && bestc > 2^c(i,j) 
            bestacc = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end               
    end
end
cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg)];
% 创建/训练SVM模型
model = svmtrain(train_label,Train_matrix,cmd);

%% SVM仿真测试
[predict_label_1,accuracy_1] = svmpredict(train_label,Train_matrix,model);
[predict_label_2,accuracy_2] = svmpredict(test_label,Test_matrix,model);
result_1 = [train_label predict_label_1];
result_2 = [test_label predict_label_2];

%% 绘图
figure
plot(1:length(test_label),test_label,'r-*')
hold on
plot(1:length(test_label),predict_label_2,'b:o')
grid on
legend('真实类别','预测类别')
xlabel('测试集样本编号')
ylabel('测试集样本类别')
string = {'测试集SVM预测结果对比(RBF核函数)';
          ['accuracy = ' num2str(accuracy_2(1)) '%']};
title(string)

%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p align="left"><font size="2">相关论坛：</font></p><p align="left"><font size="2">Matlab技术论坛：<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab函数百科：<a href="http://www.mfun.la">www.mfun.la</a></font></p></td>	</tr></table>
% </html>