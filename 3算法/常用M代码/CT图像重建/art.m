clc;
clear all;
close all;
N = 180; %图像大小
N2 = N^2;
I = phantom(N);% 产生头模型图像
theta = linspace(0,180,181);   %生成[0,180]内线性分布的181个点
theta = theta(1:180);
%% = = = = = = 产生投影数据 = = = = = = %%
P_num = 260; %探测器通道个数
P = ParallelBeam(theta ,N ,P_num); %产生投影数据
%P = radon(I,theta);
%% = = = = = = 获取投影矩阵 = = = = = =%%
delta = 1;% 网格大小，角度增量
[W_ind,W_dat] = SystemMatrix(theta,N,P_num,delta);
%% = = = = = = 进行ART迭代 = = = = = = %%
F = zeros(N2,1);  %初始图像向量
lambda = 0.25;  %松弛因子
c = 0;  %迭代计数器
irt_num = 5;  
while(c<irt_num)
    for j = 1:length(theta)
        for i = 1:1:P_num
            % 取得一条射线所穿过的网格编号和长度
            u = W_ind((j-1)*P_num + i,:);  % 编号
            v = W_dat((j-1)*P_num + i,:);  % 长度
            
            if any(u) == 0
                continue;
            end
            %恢复投影矩阵中与这一条射线对应的行向量 w
            w = zeros(1,N2);
            ind = u > 0;
            w(u(ind))=v(ind);
            % 图像进行一次迭代
            PP = w * F;   %前向投影
            C = (P(i,j)-PP)/sum(w.^2) * w';  % 修正项           
            F = F + lambda * C;
        end
    end
    F(F<0) = 0;   % 小于0的像素值置为0
    c = c+1;
end
F = reshape(F,N,N)'; % 转换成N x N的图像矩阵
%% = = = = = = 仿真结果显示 = = = = = = %%
figure(1);
imshow(I);xlabel('(a)180x180头模型图像');
figure(2);
%A = imadjust(F);
imshow(F,[]);xlabel('(b)ART算法重建的图像');
     
