function SelCh=Crossover(SelCh,Pc)
%% 交叉操作
% 输入
%SelCh  被选择的个体
%Pc     交叉概率
%输出：
%SelCh	交叉后的个体

[NSel,len]=size(SelCh);
for i=1:2:NSel-mod(NSel,2)
    if Pc>=rand %交叉概率Pc
        [SelCh(i,2:len-1),SelCh(i+1,2:len-1)]=intercross(SelCh(i,2:len-1),SelCh(i+1,2:len-1));
    end
end

function [a,b]=intercross(a,b)
%% 类PMX方法交叉
%输入：
%a和b为两个待交叉的个体
%输出：
%a和b为交叉后得到的两个个体

L=length(a); %获取亲代染色体长度
r1=unidrnd(L); %在1~L中随机选一整数
r2=unidrnd(L); %在1~L中随机选一整数

s=min([r1,r2]); %起点为较小值
e=max([r1,r2]); %终点为较大值

a0=a(s:e); %用于最后插入
b0=b(s:e); %用于最后插入

aa=a(s:e); %用于检查重复元素
bb=b(s:e); %用于检查重复元素

a(s:e)=[];     %去除交叉部分   去除后后面的元素会往前移
b(s:e)=[];     %去除交叉部分   去除后后面的元素会往前移
outlen=length(a); %去除交叉部分后，  a，b的长度   length outside cross section
inlen=length(a0);      %交叉部分长度  length inside cross section 

for i=1:inlen     %交叉部分去除相同元素
	for j=1:inlen
		if aa(i)==bb(j) %若交叉部分内上下有相同元素
			aa(i)=0; %删去
			bb(j)=0;
			break  %  break能保证最后aa和bb一样长 且无重复元素
		end
	end
end
aa(aa==0)=[];   % 0置空后后面的元素往前移
bb(bb==0)=[];   % 0置空后后面的元素往前移

exlen=length(aa);     %交叉部分去除相同元素后长度   length after deduplication
for i=1:exlen %ab上下去重后
	for j=1:outlen %交叉部分外
		if bb(i)==a(j)   %若交叉部分内上下有相同元素
			a(j)=aa(i); %冗余元素换为缺失元素
			break
		end
	end
end

for i=1:exlen%ab上下去重后
	for j=1:outlen%交叉部分外
		if aa(i)==b(j) %若交叉部分内上下有相同元素
			b(j)=bb(i); %冗余元素换为缺失元素
			break
		end
	end
end
a=[a(1:s-1),b0,a(s:outlen)]; %重新拼接生成子代1
b=[b(1:s-1),a0,b(s:outlen)]; %重新拼接生成子代2