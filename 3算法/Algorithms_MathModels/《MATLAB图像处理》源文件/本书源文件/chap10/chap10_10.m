%[10.10]
close all; clear all; clc;				%关闭所有图形窗口，清除工作空间所有变量，清空命令行
ORIGIN=imread('lena.bmp');			%读入原始图像 
%步骤1：正向离散余弦变换(FDCT)
fun=@DCT_Measure;
%步骤2：量化
B=blkproc(ORIGIN,[8,8],fun);			%得到量化后的系数矩阵，与原始图像尺寸相同，需要进一步处理
n=length(B)/8; 						%对每个维度分成的块数
C=zeros(8);						%初始化为8×8的全0矩阵
for y=0:n-1
    for x=0:n-1
        T1=C(:,[end-7:end]);			%取出上一组数据做差分,T1的所有8行和最后8列组成的8*8
        T2=B(1+8*x:8+8*x,1+8*y:8+8*y);
        T2(1)=T2(1)-T1(1);			%直流系数做差分
        C=[C,T2];					%将C和T2矩阵串联
    end
end
C=C(:,[9:end]);						%去除C的前8列，就是前面的全0
%步骤4：利用Code_Huffman( )函数实现上述JPEG算法步骤中的步骤3、4、5和6步
JPGCode={''};						%存储编码的元胞初始化为空的字符串
for a=0:n^2-1
    T=Code_Huffman(C(:,[1+a*8:8+a*8]));
    JPGCode=strcat(JPGCode,T);
end
sCode=cell2mat(JPGCode);			%将元胞转化为数组
Fid=fopen('JPGCode.txt','w');			%用变量fid标记I/O流，打开文本文件
fprintf(Fid,'%s',sCode);				%将压缩码sCode保存到文本文件中。添加而不是覆盖
fclose(Fid);						%关闭I/O流
[x y]=size(A);
b=x*y*8/length(sCode);
v=8/b; 							%计算压缩比和压缩效率
disp('JPEG压缩数据已保存至JPGCode.txt中!');
disp(['压缩比为：',num2str(b),'；压缩效率：',num2str(v)]);
