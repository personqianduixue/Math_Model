%% 读取视频数据
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
videoFReader = vision.VideoFileReader('vippedtracking.mp4');

% 播放视频文件
videoPlayer = vision.VideoPlayer;
while ~isDone(videoFReader)
  videoFrame = step(videoFReader);
  step(videoPlayer, videoFrame);
end
release(videoPlayer);

%% 设置播放方式
% 重置播放器
reset(videoFReader)
% 增加播放器的尺寸
r = groot;
scrPos = r.ScreenSize;
%  Size/position is always a 4-element vector: [x0 y0 dx dy]
dx = scrPos(3); dy = scrPos(4);
videoPlayer = vision.VideoPlayer('Position',[dx/8, dy/8, dx*(3/4), dy*(3/4)]);
while ~isDone(videoFReader)
  videoFrame = step(videoFReader);
  step(videoPlayer, videoFrame);
end
release(videoPlayer);
reset(videoFReader)

%% 获取视频中的图像
videoFrame = step(videoFReader);
n = 0;
while n~=15
  videoFrame = step(videoFReader);
  n = n+1;
end
figure, imshow(videoFrame)
release(videoPlayer);
release(videoFReader)