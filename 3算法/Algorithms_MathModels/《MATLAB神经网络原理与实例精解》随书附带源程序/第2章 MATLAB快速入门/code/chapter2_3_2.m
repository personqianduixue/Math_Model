% chapter2_3_2.m  第2.3.2节 数据类型

a=uint8(9)	%a为无符号一个字节整数
b=int16(8)	% b为有符号两个字节整数
a/b			% 无法直接运算
b=uint8(8)	% b改为无符号一个字节整数
a/b			% 此时可以运算，除法运算只保留整数部分

%%
a=realmax('double'),b=realmax('single')		%双精度和单精度浮点数的最大值
a=realmin('double'),b=realmin('single')		%双精度和单精度浮点数的最小值
class(pi)                                   %常数数字的默认数据类型为double型
class(2)

%%
ele=1:10	% 定义一个向量
l=ele>5     % 向量中大于5的元素位置
ele(l)		% 取出大于5的元素

%%
x=[1,2,3,4]						%向量x
ha=@sum							%直接声明ha为sum函数的句柄
hb=str2func('sum')				%用str2func声明hb为sum函数的句柄
functions(ha)					%函数句柄ha包含的信息
functions(hb)					%函数句柄hb包含的信息
sum(x)							%使用sum求和
ha(x)							%使用ha代替sum
hb(x)							%使用hb代替sum
feval('sum',x)					%不使用函数句柄，使用feval函数求和
hc=@myfun
functions(hc)					%句柄包含的信息
hd=@(x,y)x^(-2)+y^(-2);			%定义匿名函数句柄
functions(hd)					%函数句柄包含的信息
version -java
%%
a={1,2,3}								%1×3细胞数组
b=[{zeros(2,2)},{uint8(9)};{'Matlab'},{0}]			%2×2细胞数组
c=b(3)									%c=b(3)，c是一个小一些的细胞数组
class(c)
d=b{3}									%d=b{3}，d为uint8型整数
class(d)
A=cell(2,3)								%用cell函数创建空的细胞数组
A{1}=zeros(2,2);
A{2}='abc';
A(3)={uint8(9)};
A

%%
book.name='MATLAB';                                             %直接创建结构型数组
book.price=20;
book.pubtime='2011';
book
book2=struct('name','Matlab','price',20,'pubtime','2011');		%用struct函数创建结构数组
book2
whos

%%
for i=1:10,...						%包含10条记录、3个字段的结构数组
        books(i).name=strcat('book',num2str(i));...
        books(i).price=20+i;...
        books(i).pubtime='2011';
end;
books
books(1)
price=[books.price]					%用[]运算符抽取处price字段形成新的向量
web -broswer http://www.ilovematlab.cn/forum-222-1.html