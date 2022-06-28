%% 自适应滤波法
clc, clear

yt = 0.1:0.1:1;
m = length(yt);
k = 0.9;          % 学习常数
N = 2;            % 权数个数
Terr = 10000;
w = ones(1,N) / N;
while abs(Terr)>0.00001
    Terr = [];
    for j = N+1:m-1
        yhat(j) = w*yt(j-1:-1:j-N)';
        err = yt(j) - yhat(j);
        Terr = [Terr, abs(Terr)];
        w = w + 2*k*err*yt(j-1:-1:j-N);
    end
    Terr = max(Terr);
end