clc, clear
a=load('xf.txt');   %原始文件保存在纯文本文件xf.txt中
T=sum(sum(a));
P=a/T;   %计算对应矩阵P
r=sum(P,2), c=sum(P)  %计算边缘分布
Row_prifile=a./repmat(sum(a,2),1,size(a,2))   %计算行轮廓分布阵
B=(P-r*c)./sqrt((r*c));   %计算标准化数据B
[u,s,v]= svd(B,'econ')    %对标准化后的数据阵B作奇异值分解
w1=sign(repmat(sum(v),size(v,1),1)) %修改特征向量的符号矩阵，使得v中的每一个列向量的分量和大于0
w2=sign(repmat(sum(v),size(u,1),1))  %根据v对应地修改u的符号
vb=v.*w1  %修改特征向量的正负号
ub=u.*w2  %修改特征向量的正负号，本例中样本点个数和变量个数不等
lamda=diag(s).^2   %计算Z'*Z的特征值，即计算主惯量
ksi2square=T*(lamda)  %计算卡方统计量的分解
T_ksi2square=sum(ksi2square) %计算总卡方统计量
con_rate=lamda/sum(lamda)  %计算贡献率
cum_rate=cumsum(con_rate)  %计算累积贡献率
beta=diag(r.^(-1/2))*ub;  %求加权特征向量
G=beta*s   %求行轮廓坐标
alpha=diag(c.^(-1/2))*vb;   %求加权特征向量
F=alpha*s   %求列轮廓坐标F
num1=size(G,1);  %样本点的个数
rang=minmax(G(:,[1,2])');  %坐标的取值范围
delta=(rang(:,2)-rang(:,1))/(5*num1); %画图的标注位置调整量
ch={'A', 'B', 'C', 'D', 'E', 'F', 'G'};
yb={'山西','内蒙古','辽宁','吉林','黑龙江','海南','四川','贵州','甘肃','青海'};
hold on
plot(G(:,1),G(:,2),'*','Color','k','LineWidth',1.3)  %画行点散布图
text(G(:,1)-delta(1),G(:,2)-3*delta(2),yb) %对行点进行标注
plot(F(:,1),F(:,2),'H','Color','k','LineWidth',1.3) %画列点散布图
text(F(:,1)+delta(1),F(:,2),ch) %对列点进行标注
xlabel('dim1'), ylabel('dim2')
xlswrite('tt',[diag(s),lamda,ksi2square,con_rate,cum_rate])
%把计算结果输出到Excel文件，这样便于把数据直接贴到word中的表格
ind1=find(G(:,1)>0); %根据行坐标第一维进行分类
rowclass=yb(ind1)  %提出第一类样本点
ind2=find(F(:,1)>0); %根据列坐标第一维进行分类
colclass=ch(ind2)  %提出第一类变量
