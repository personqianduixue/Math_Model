function fh_SL = SLfilter(N,d)
% S-L filter function
% ----------------------
% 输入参数：
% N:图像大小，探测器通道个数；
% d:平移步长
% 输出参数：
%fh_SL:S-L滤波函数
fh_SL = zeros(1,N);
for k1 = 1:N
    fh_SL(k1) = -2/(pi^2*d^2*(4*(k1-N/2-1)^2-1));
end

