%%Feature_Extract.m
function [FileName,mean_value,variance]=Feature_Extract(FileName)
% [mean_value,variance]=Feature_Extract(FileName)
% FileName是需要分析的波形文件的路径
% mean_value是计算得出的特征值的平均值
% variance是计算得出的特征值的方差
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[F,Fs,NBITS] = wavread(FileName,20*44100);         % 读入波形数据
time = 20;                                         % 采样时间60秒
T = 1:time*Fs;                                       % 采样时间轴
Wave = F(T);                                         % 采样段数据
Wave = Wave/max(abs(Wave)); % 数据归一化处理
WLen = length(T); % 统计采样数据点的数量

winlen = 2^nextpow2(Fs*20/1000); % 窗长为10ms~30ms,这里取20ms
dupwin = 2^nextpow2(Fs*5/1000); % 为保持连续性，窗口有重叠，重叠5ms
stepwin = winlen-dupwin; % 窗每次移动stepwin个采样点
E = zeros(WLen-stepwin,1); %` 初始化能量矩阵
for i = 1:stepwin:WLen-stepwin % 计算帧能量FE
    xm = Wave(i:i+stepwin);
    E(i) = sum(xm.*xm);
end
E0 = [E zeros(length(E),1)]; % 为记录帧的位置准备，E0第一维是E,
                             % 第二维是相应的位置
E0 = setxor(E0(:,1),0); % 删除末尾零记录
j=1;
for i = 1:length(E) % 记录帧的位置
    if E(i)>0
        E0(j,1)=E(i);
        E0(j,2)=i;
        j = j+1;
    end
end
Emin = min(E0(:,1)); % 计算帧能量的最小值
Emax = max(E0(:,1)); % 计算帧能量的最大值
Emean = mean(E0(:,1)); % 计算帧能量的平均值
lamda = 0.5; % 设定静音阈值
Ttfe = Emin + lamda * (Emean - Emin);

for i = 1:length(E0(:,1)) % 屏蔽E0中对饮帧能量小于静音阈值的值
    if E0(i,1) < Ttfe 
        E0(i,1) = 0;
    end
end
% 寻找特征片段
FER = ones(length(E0(:,1)),2); % 初始化帧能量比矩阵
for i = 1:(length(E0(:,1))-1) % 计算帧能量比
    if(and(E0(i,1),E0(i+1,1))) % 若当前帧与后一帧都不为零
        FERa = E0(i+1,1)/E0(i,1);
        FERb = E0(i,1)/E0(i+1,1);
        FER(i,1)=max(FERa,FERb);
        FER(i,2)=E0(i,2);
    end
end
level = mean(FER(:,1)); % 设定高潮端点阈值
result0 = zeros(length(FER(:,2)),1); % 初始化结果矩阵
j = 2;
if FER(1,1)-level >0
    result(1) = FER(1,2);
end              %过滤出高潮端点
for i = 2:length(FER(:,2))-1
    if FER(i,2)-level >0
        if FER(i-1,2)-level <0
            result0(j) = FER(i,2);
            j = j+1;
        end
    end
end
result0 = setxor(result0,0); % 删除多余的零元素
result = zeros(length(result0)-1,1);
for i = 1:length(result0)-1
    result(i) = result0(i+1)-result(i);
end
charaction = zeros(size(result));
for i = 1:length(result)-1
    charaction(i) = result(i+1)-result(i);
end
result = charaction;
FileName;                 %输出特征向量
u = mean(result);
d = var(result);
disp([FileName])
disp([ '均值：' num2str(u) '方差：' num2str(d)]);
mean_value = u; % 函数返回特征向量
variance = d;
end




        






    