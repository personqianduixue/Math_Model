function X=dft(x,dim)
%DFT   离散傅里叶变换
% Y=DFT(X)  求数据矩阵X的离散傅里叶变换
% Y=DFT(X,DIM)  对矩阵X的行维或列维求傅里叶变换
%
% 输入参数：
%     ---X：数据矩阵
%     ---DIM：指定维的方向
% 输出参数：
%     ---Y：离散傅里叶变换结果
%
% See also fourier

if isvector(x)
    x=x(:).';
end
if nargin<2 || isvector(x)
    dim=1;
end
N=size(x,setdiff([1,2],dim));
n=0:N-1;
k=0:N-1;
WN=exp(-1j*2*pi/N);
nk=n'*k;
W=WN.^nk;
if dim==1
    X=x*W;
else
    X=(x.'*W).';
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html