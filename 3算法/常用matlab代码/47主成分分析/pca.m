function [tg xs q px newdt]=pca(h)  %输入只能是以分析的指标变量为列，样本变量为行的数据！
h=zscore(h); %数据标准化
r=corrcoef(h); %计算相关系数矩阵
disp('计算的相关系数矩阵如下：');
disp(r);
[x,y,z]=pcacov(r);  %计算特征向量与特征值
s=zeros(size(z));
for i=1:length(z)
    s(i)=sum(z(1:i));
end
disp('由上计算出相关系数矩阵的前几个特征根及其贡献率:');
disp([z,s])
tg=[z,s];
f=repmat(sign(sum(x)),size(x,1),1);
x=x.*f;
n=input('请选择前n个需要计算的主成分：\n');
disp('由此可得选择的主成分系数分别为:');
for i=1:n
    xs(i,:)=(x(:,i)');
end
newdt=h*xs';
disp('以主成分的贡献率为权重，构建主成分综合评价模型系数:');
q=((z(1:n)./100)')
w=input('是否需要进行主成分综合评价?(y or n)\n');
if w==y
    df=h*x(:,1:n);
    tf=df*z(1:n)/100;
    [stf,ind]=sort(tf,'descend'); %按照降序排列
    disp('主成分综合评价结果排序：');
    px=[ind,stf]
else
    return;
end