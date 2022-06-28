%% 二维元胞自动机
%imagesc(a)的色度矩阵a中0->256由蓝变黄
% 规则，先把中间点置为1，每一时间每一点如果
%周围八个点和为偶数，则变为0，为奇数则变为 1
% 颜色控制
clc, clear

Map = [1 1 1; 0 0 0];% [0 0 0] is black, [1 1 1] is white,
colormap(Map);
% 设置网格大小
S = 121;
L = zeros(S);
% 把中间一个数设置为 1 作为元胞种子
M = (S+1)/2;
display(M)
L(M, M) =1;
Temp = L;
% imagesc(L);

% 计算层数
Layer = (S-1)/2 + 1;
display(Layer)
for t=2:Layer
    for x=M-t+1:M+t-1  % 60-62,59-63...1-121
        if x==M-t+1 || x==M+t-1
            for y=M-t+1:M+t-1
                SUM = 0;
                for m=-1:1
                    for n=-1:1
                        if x+m>0 && x+m<=S && y+n>0 && y+n<=S  % s+121;
                            SUM = SUM + L(x+m, y+n);
                            % display(SUM)
                        end
                    end
                end
                SUM = SUM - L(x, y);
                Temp(x, y) = mod(SUM, 2); % mod(a,b)就是求的是a除以b的余数
            end
        else
            y = M-t+1;
            SUM = 0;
            for m=-1:1
                for n=-1:1
                    if x+m>0 && x+m<=S && y+n>0 && y+n<=S
                        SUM = SUM + L(x+m, y+n);
                    end
                end
            end
            SUM = SUM - L(x, y);
            Temp(x, y) = mod(SUM, 2);
            
            y = M+t-1;
            SUM = 0;
            for m=-1:1
                for n=-1:1
                    if x+m>0 && x+m<=S && y+n>0 && y+n<=S
                        SUM = SUM + L(x+m, y+n);
                    end
                end
            end
            SUM = SUM - L(x, y);
            Temp(x, y) = mod(SUM, 2);
        end
    end
    L = Temp;
    imagesc(L);
    % 速度控制
    pause(0.05);
end
