%% 读取图片
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
clc, clear, close all
a1=imread('000.bmp');
[m,n]=size(a1);
%% 批量读取图片
dirname = 'ImageChips';
files = dir(fullfile(dirname, '*.bmp'));
a=zeros(m,n,19);
pic=[];
for ii = 1:length(files)
  filename = fullfile(dirname, files(ii).name);
  a(:,:,ii)=imread(filename);
  pic=[pic,a(:,:,ii)];
end
double(pic);
figure
imshow(pic,[])
