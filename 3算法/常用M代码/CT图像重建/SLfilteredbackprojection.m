function rec_SL = SLfilteredbackprojection(theta_num,N,R1,delta,fh_SL)
% S-L filtered back projection function
% ------------------------------------
% theta_num:投影角度个数
% N:图像大小、探测器通道个数
% R1：投影数据矩阵
% delta：角度增量（弧度）
% fh_SL:S-L滤波函数
% 输出参数：
% rec_SL:反投影重建矩阵
rec_SL = zeros(N);
for m = 1:theta_num
    pm = R1(:,m); % 某一角度的投影数据
    pm_SL = conv(fh_SL,pm,'same'); % 做卷积
    Cm = (N/2)*(1-cos((m-1)*delta)-sin((m-1)*delta));
    for k1 = 1:N
        for k2 = 1:N
            % 以下是射束计算，注意射束编号n取值范围为1-N-1
            Xrm = Cm+(k2-1)*cos((m-1)*delta)+(k1-1)*sin((m-1)*delta);
            n = floor(Xrm);
            t = Xrm-floor(Xrm); %小数部分
            n = max(1,n);n = min(n,N-1);
            p_SL = (1-t)*pm_SL(n) + t*pm_SL(n+1); % 线性内插
            rec_SL(N+1-k1,k2) = rec_SL(N+1-k1,k2)+p_SL; % 反投影
        end
    end
end