%% sub function of pre-processing pic
function pic_preprocess = pic_preprocess(pic)
% 图片预处理子函数
% 图像反色处理
pic = 255-pic;
% 设定阈值，将反色图像转成二值图像
pic = im2bw(pic,0.4);
% 查找数字上所有像素点的行标y和列标x
[y,x] = find(pic == 1);
% 截取包含完整数字的最小区域
pic_preprocess = pic(min(y):max(y), min(x):max(x));
% 将截取的包含完整数字的最小区域图像转成16*16的标准化图像
pic_preprocess = imresize(pic_preprocess,[16,16]);