% 问题1
%%  注意！！! 需要用到视频，请将附件1视频放在当前目录下,并改名为1.mpg’
clear;
close all;
clc;

%% 读取视频 且一帧帧的播放

%%  注意！！! 需要用到视频，请将附件1视频放在当前目录下,并改名为1.mpg’
vedio1 = mmreader('1.mpg');
nFrames = vedio1.NumberOfFrames; 
vidHeight = vedio1.Height;
vidWidth = vedio1.Width;

%% 选其中的ROI
img = 0;
C1 = read(vedio1,4950);
%imshow(C1);
C1 = rgb2gray(C1);%转为灰度图
C1 =medfilt2( C1,[3,3]); %中值滤波B(1) = read( vedio1, 1 );
K = 0.90;B1 = 0;tmp = zeros(size(C1));M = 30;

for i =  4960:15: nFrames  
             C = read( vedio1, i );% 大概25帧一秒
             tmp = C;
             C = rgb2gray(C);%转为灰度图            
             C = histeq(C); %直方图均衡化  
%             imshow(C);
             
     %        C = retinex(C);
 %            figure;            
             C = medfilt2( C,[3,3]); %中值滤波              
 %             imshow(C);
             B = K*B1+(1-K)*C1;             
             D = C-B;             
%              for j = 2:288-1
%                 for k = 2:352-1
%                     if D(j,k)>M && D(j-1,k-1)>M && D(j-1,k)>M && D(j,k-1)>M....
%                         && D(j+1,k)>M && D(j,k+1)>M && D(j+1,k-1)>M && D(j+1,k+1)>M....
%                         && D(j-1,k+1)>M
%                         tmp(j,k) = 255;
%                     end
%                 end
%              end   
            D(find(D>M)) = 255;
            D(find(D<= M)) = 0;
           %  level = graythresh(D); %Otsu阈值法
           %  D = im2bw(D,level);   
             subplot(1,2,1);
             imshow(tmp);
             subplot(1,2,2);
             %imshow(tmp);
             se1=strel('square',2);%圆盘型结构元素
             %D = imopen(D,se1);
             
             se=strel('disk',2);%圆盘型结构元素             
             D=imclose(D,se);%直接闭运算                          
             %D = edge(D,'canny'); %边缘检测      
             imshow(D);                                                       
             C1 = C;
             B1 = B;                          
             % 从i= 4990开始进行计数             
end 