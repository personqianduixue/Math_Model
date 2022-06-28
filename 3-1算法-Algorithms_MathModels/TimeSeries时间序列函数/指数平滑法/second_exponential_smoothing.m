%% 二次指数平滑法
clc, clear

yt = [676 825 774 716 940 1159 1384 1524 1668 1688 1958 2031 2234 2566 2820 3006 3093 3277 3514 3770 4107]';
n = length(yt);
alpha = 0.3;
st1(1) = yt(1); st2(1) = yt(1);  % 初始值选实际初始值
for i = 2:n
    st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
    st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
end

at = 2*st1 - st2;
bt = alpha/(1-alpha)*(st1-st2);
yhat = at + bt;
y_predict = alpha*yt(n) + (1-alpha)*yhat(n);

x = 1965:1985;
plot(x, yt, '*', x, yhat);