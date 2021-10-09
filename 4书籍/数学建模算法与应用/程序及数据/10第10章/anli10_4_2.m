clc,clear
load sy.txt   %把原始数据保存在纯文本文件sy.txt中
num=input('请选择主因子的个数：');  %交互式选择主因子的个数
[lambda,psi,T,stats,F]=factoran(sy,num,'rotate','varimax') %Lambda返回的是因子载荷矩阵，psi返回的是特殊方差，T返回的是旋转正交矩阵，stats返回的是一些统计量，F返回的是因子得分矩阵
gtd=1-psi   %计算共同度
contr=sum(lambda.^2)  %计算可解释方差
