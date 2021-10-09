%% 使用蒙特卡洛方法在所有的枚举值中随机选择一些点来计算
% 任意一点落在高值区的概率并不低

rng('shuffle')
p0 = 0;

tic % 开始计时

for i = 1:10^6
    x = 99 * rand(5, 1);
    x1 = floor(x);
    x2 = ceil(x);

    [f, g] = example_1(x1);
    if sum(g <= 0) == 4
        if p0 <= f
            x0 = x1;
            p0 = f;
        end
    end

    [f, g] = example_1(x2);
    if sum(g <= 0) == 4
        if p0 <= f
            x0 = x2;
            p0 = f;
        end
    end
end

x0, p0

toc % 计算使用时间: 时间已过 14.130765 秒。
