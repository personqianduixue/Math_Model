%【例11-15】
close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I = imread('liftingbody.png');             %读入图像
S = qtdecomp(I,.27);                   %四叉树分解，阈值为0.27
blocks = repmat(uint8(0),size(S));        %矩阵扩充为S的大小
for dim = [512 256 128 64 32 16 8 4 2 1];    
  numblocks = length(find(S==dim));    
  if (numblocks > 0)        
    values = repmat(uint8(1),[dim dim numblocks]);%左上角元素为1
    values(2:dim,2:dim,:) = 0;%其他地方元素为0
    blocks = qtsetblk(blocks,S,dim,values);
  end
end
blocks(end,1:end) = 1;  blocks(1:end,end) = 1;
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])
figure;subplot(121);imshow(I);
subplot(122), imshow(blocks,[])                   %显示四叉树分解的图像
