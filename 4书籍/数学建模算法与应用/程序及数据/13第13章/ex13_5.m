I = imread('cameraman.tif'); %cameraman.tif是Matlab自带的图像文件
I = im2double(I); %数据转换成double类型
T = dctmtx(8); %T为8×8的DCT变换矩阵
dct = @(block_struct) T * block_struct.data * T'; %定义正DCT变换的隐函数，这里block_struct是Matlab内置的结构变量
B = blockproc(I,[8 8],dct); %做正DCT变换
mask = [1 1 1 1 0 0 0 0
1 1 1 0 0 0 0 0
1 1 0 0 0 0 0 0
1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0]; %给出掩膜矩阵
B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data); %提取低频系数
invdct = @(block_struct) T' * block_struct.data * T; %定义逆DCT变换的隐函数
I2 = blockproc(B2,[8 8],invdct); %做逆DCT变换
subplot(1,2,1), imshow(I) %显示原图像
subplot(1,2,2), imshow(I2) %显示变换后的图像
