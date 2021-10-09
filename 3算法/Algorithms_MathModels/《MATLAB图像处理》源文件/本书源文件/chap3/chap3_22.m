close all;										%关闭当前所有图形窗口
clear all;										%清空工作空间变量
clc;											%清屏
obj = mmreader('xylophone.mpg', 'tag', 'myreader1');		%创建多媒体文件对象句柄，并设置标签
Frames = read(obj);								%读取视频流，将每一帧图像存在数组Frames中
numFrames = get(obj, 'numberOfFrames');			%获取视频流中总帧数
for k = 1 : numFrames						
mov(k).cdata = Frames(:,:,:,k); 				%将每一图像帧中的数据矩阵读取出来存在mov(k).cdata中
mov(k).colormap = [];						%将颜色表赋值为空
end
hf = figure;								%创建一个图像窗口
set(hf, 'position', [150 150 obj.Width obj.Height]); 	%根据视频帧的宽度和高度，重新设置图像窗口大小
movie(hf, mov, 1, obj.FrameRate);				%按照视频流原来的帧速率来播放该视频
