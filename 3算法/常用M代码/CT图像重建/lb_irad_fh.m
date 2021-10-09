%% = = =主程序= = = %%
clc;
clear all;
close all;
%% = = = = = 仿真参数设计 = = = = = %%
N = 256;  % 图像大小
I = phantom(N);  % Shepp-Logan头模型
delta = pi/180;  % 角度增量
theta = 0:1:179; % 投影角度
theta_num = length(theta);
d = 1;
%% = = = = = 产生投影数据 = = = = = %%
P = radon(I,theta);
[mm,nn] = size(P);   % 计算投影数据矩阵的行、列长度
e = floor((mm-N-1)/2+1)+1;  % 投影数据的默认投影中心为 floor((size(I)+1)/2)
P = P(e:N+e-1,:);  % 截取中心n点数据，因投影数据较多，含无用数据
P1 = reshape(P,N,theta_num); 
%% = = = = = 产生滤波函数 = = = = = %%

fh_RL = RLfilter(N,d);
fh_SL = SLfilter(N,d);
%% = = = = = 滤波反投影重建 = = = = = %%
rec = Backprojection(theta_num,N,P1,delta);

rec_RL = RLfilteredbackprojection(theta_num,N,P1,delta,fh_RL);

rec_SL = SLfilteredbackprojection(theta_num,N,P1,delta,fh_SL);

%% = = = = = 结果显示 = = = = = %%
figure;
subplot(2,2,1),imshow(I),xlabel('(a)256x256头模型（原始图像）');
subplot(2,2,2),imshow(rec,[]),xlabel('(b)直接反投影重建图像');
subplot(2,2,3),imshow(rec_RL,[]),xlabel('(c)R-L函数滤波反投影重建图像');
subplot(2,2,4),imshow(rec_SL,[]),xlabel('(d)S-L函数滤波反投影重建图像');