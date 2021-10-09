function rec = Backprojection(theta_num,N,R1,delta)
%  back projection restruction function
% ------------------------------------
% 输入参数：
% theta_num:投影角度个数
% N:图像大小、探测器通道个数
% R1：投影数据矩阵
% delta：角度增量（弧度）
% -------------------------------------
% 输出参数：
% rec:反投影重建图像矩阵

rec = zeros(N);
for m = 1:theta_num
    pm = R1(:,m); % 某一角度的投影数据
    Cm = (N/2)*(1-cos((m-1)*delta)-sin((m-1)*delta));
    for k1 = 1:N
        for k2 = 1:N
            % 以下是射束计算，注意射束编号n取值范围为1-N-1
            Xrm = Cm+(k2-1)*cos((m-1)*delta)+(k1-1)*sin((m-1)*delta);
            n = floor(Xrm);
            t = Xrm-floor(Xrm); %小数部分
            n = max(1,n);n = min(n,N-1);
            p = (1-t)*pm(n) + t*pm(n+1); % 线性内插
            rec(N+1-k1,k2) = rec(N+1-k1,k2)+p; % 反投影
        end
    end
end
