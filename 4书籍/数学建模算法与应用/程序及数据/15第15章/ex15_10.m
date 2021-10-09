clc,clear
format rat  %数据格式是有理分数
fid=fopen('msdata.txt','r');
a=[];
while (~feof(fid))
    a=[a fgetl(fid)];  %把所有字符串连接成一个大字符串行向量
end
for i=0:1
    for j=0:1
        s=[int2str(i),int2str(j)]; %构造子字符串‘ij’
        f(i+1,j+1)=length(findstr(s,a));  %计算子串‘ij’的个数
    end
end
fs=sum(f,2);  %求f矩阵的行和
f=f./repmat(fs,1,size(f,2))  %求状态转移频率
