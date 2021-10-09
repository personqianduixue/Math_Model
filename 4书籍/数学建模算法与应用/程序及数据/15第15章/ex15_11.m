clc, clear, format rat
a=[4  3  2  1  4  3  1  1  2  3 
   2  1  2  3  4  4  3  3  1  1
   1  3  3  2  1  2  2  2  4  4
   2  3  2  3  1  1  2  4  3  1];
a=a'; a=a(:)'; %把矩阵a逐行展开成一个行向量
for i=1:4
   for j=1:4
      f(i,j)=length(findstr([i j],a)); %统计子串‘ij’的个数
   end
end
ni=sum(f,2);  %计算矩阵f的行和
phat=f./repmat(ni,1,size(f,2))  %求状态转移的频率
format %恢复到短小数的显示格式