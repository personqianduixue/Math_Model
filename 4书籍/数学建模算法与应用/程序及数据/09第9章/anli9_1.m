%原始数据cancerdata.txt可在网上下载，数据中的B替换成1，M替换成-1，X替换成2，删除了分割符*,替换后的数据命名成cancerdata2.txt
clc,clear
a=load('cancerdata2.txt');
a(:,1)=[];  %删除第一列病例号
gind=find(a(:,1)==1);  %读出良性肿瘤的序号
bind=find(a(:,1)==-1); %读出恶性肿瘤的序号
training0=a([1:500],[2:end]); %提出已知样本点的数据
training=training0'; 
[train,ps]=mapstd(training); %已分类数据标准化
group(gind)=1; group(bind)=-1;  %已知样本点的类别标号
group=group'; %转换成列向量
xa0=a([501:569],[2:end]); %提出待分类数据
xa=xa0'; xa=mapstd('apply',xa,ps); %待分类数据标准化
s=svmtrain(training',group, 'Method','SMO', 'Kernel_Function','quadratic') %使用序列最小化方法训练支持向量机的分类器，如果使用二次规划的方法训练支持向量机则无法求解
sv_index=s.SupportVectorIndices'  %返回支持向量的标号
beta=s.Alpha'  %返回分类函数的权系数
b=s.Bias  %返回分类函数的常数项
mean_and_std_trans=s.ScaleData %第1行返回的是已知样本点均值向量的相反数，第2行返回的是标准差向量的倒数
check=svmclassify(s,training');  %验证已知样本点
err_rate=1-sum(group==check)/length(group) %计算错判率
solution=svmclassify(s,xa'); %进行待判样本点分类
solution=solution' 
sg=find(solution==1)  %求待判样本点中的良性编号
sb=find(solution==-1) %求待判样本点中的恶性编号
