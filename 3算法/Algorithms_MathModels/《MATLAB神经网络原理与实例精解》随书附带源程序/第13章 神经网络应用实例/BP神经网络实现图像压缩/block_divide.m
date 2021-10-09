function P = block_divide(I,K)
% P=block_divede(I)
% [row,col]=size(I),row%K==0, and col%K==0
% divide matrix I into K*K block,and reshape to 
% a K^2*N matrix
% example:
% I=imread('lena.jpg');
% P=block_divide(I,4);

% 计算块的个数：R*C个
[row,col]=size(I);
R=row/K;
C=col/K;

% 预分配空间
P=zeros(K*K,R*C);     
for i=1:R
    for j=1:C
        % 依次取K*K 图像块
        I2=I((i-1)*K+1:i*K,(j-1)*K+1:j*K);
        % 将K*K块变为列向量
        i3=reshape(I2,K*K,1);
        % 将列向量放入矩阵
        P(:,(i-1)*R+j)=i3;
    end
end
