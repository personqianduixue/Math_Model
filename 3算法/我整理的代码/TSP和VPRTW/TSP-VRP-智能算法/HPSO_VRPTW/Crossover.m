function a=Crossover(a,b)
%% PMX方法交叉
%输入：
%a  粒子代表的路径
%b  个体最优粒子代表的路径

%输出：
%a	交叉后的粒子代表的路径

L=length(a); %获取亲代染色体长度
r1=unidrnd(L); %在1~L中随机选一整数
r2=unidrnd(L); %在1~L中随机选一整数

s=min([r1,r2]); %起点为较小值
e=max([r1,r2]); %终点为较大值

b0=b(s:e); %用于最后插入

aa=a(s:e); %用于检查重复元素
bb=b(s:e); %用于检查重复元素

a(s:e)=[];     %去除交叉部分   去除后后面的元素会往前移

outlen=length(a); %去除交叉部分后，  a，b的长度   length outside cross section
inlen=e-s+1;      %交叉部分长度  length inside cross section 

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
bb(bb==0)=[];% 0置空后后面的元素往前移

exlen=length(aa);     %交叉部分去除相同元素后长度   length after deduplication
for i=1:exlen %ab上下去重后
	for j=1:outlen %交叉部分外
		if bb(i)==a(j)   %若交叉部分内上下有相同元素
			a(j)=aa(i); %冗余元素换为缺失元素
			break
		end
	end
end

a=[a(1:s-1),b0,a(s:outlen)]; %重新拼接生成子代1