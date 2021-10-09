function I = getPicData()
% getPicData.m
% 读取digital_pic目录下的所有图像
% output:
% I : 64 * 64 * 1000, 包含1000张64*64二值图像

I = zeros(64,64,1000);
k = 1;

% 外层循环：读取不同数字的图像
for i=1:10
    % 内层循环： 读取同一数字的100张图
    for j=1:100
        file = sprintf('digital_pic\\%d_%03d.bmp', i-1, j);
        I(:,:,k) = imread(file);
        
        % 图像计数器
        k = k + 1;
    end
end
