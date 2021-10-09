clc, clear
format long g
a=load('dy.txt');   %原始文件保存在纯文本文件dy.txt中
T=sum(sum(a));
P=a/T;   %计算对应矩阵P
r=sum(P,2), c=sum(P)  %计算边缘分布
Row_prifile=a./repmat(sum(a,2),1,size(a,2))   %计算行轮廓分布阵
B=(P-r*c)./sqrt((r*c));   %计算标准化数据B
[u,s,v]= svd(B,'econ')    %对标准化后的数据阵B作奇异值分解
w=sign(repmat(sum(v),size(v,1),1)) %修改特征向量的符号矩阵
%使得v中的每一个列向量的分量和大于0
ub=u.*w  %修改特征向量的正负号
vb=v.*w  %修改特征向量的正负号
lamda=diag(s).^2   %计算Z'*Z的特征值,即计算惯量
ksi2square=T*(lamda)  %计算卡方统计量的分解
T_ksi2square=sum(ksi2square) %计算总卡方统计量
con_rate=lamda/sum(lamda)  %计算贡献率
cum_rate=cumsum(con_rate)  %计算累积贡献率
beta=diag(r.^(-1/2))*ub;  %求加权特征向量
G=beta*s   %求行轮廓坐标
alpha=diag(c.^(-1/2))*vb;   %求加权特征向量
F=alpha*s   %求列轮廓坐标F
num=size(G,1);  
rang=minmax(G(:,1)');  %坐标的取值范围
delta=(rang(2)-rang(1))/(8*num); %画图的标注位置调整量
ch='LPSBEM';
hold on
for i=1:num
plot(G(i,1),G(i,2),'*','Color','k','LineWidth',1.3)  %画行点散布图
text(G(i,1)+delta,G(i,2),ch(i)) %对行点进行标注
plot(F(i,1),F(i,2),'H','Color','k','LineWidth',1.3) %画列点散布图
text(F(i,1)+delta,F(i,2),int2str(i+1972)) %对列点进行标注
end
xlabel('dim1'), ylabel('dim2')
xlswrite('tt1',[diag(s),lamda,ksi2square,con_rate,cum_rate])
%把计算结果输出到Excel文件，这样便于把数据直接贴到word中的表格
format
