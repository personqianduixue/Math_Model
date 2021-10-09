function P=ParallelBeam(theta, N, P_num)

shep = [1    .69    .92     0     0       0
        -.8  .6624  .8740   0     -.0184  0  
        -.2  .1100  .3100   .22   0       -18
        -.2  .1600  .4100   -.22  0       18
        .1   .2100  .2500   0     .35     0
        .1   .0460  .0460   0     .1      0
        .1   .0460  .0460   0     -.1     0
        .1   .0460  .0230   -.08  -.605   0
        .1   .0230  .0230   0     -.606   0
        .1   .0230  .0460   .06   -.605   0];
    theta_num = length(theta);
    P = zeros(P_num ,theta_num);
    rho = shep(:,1).';
    ae = 0.5 * N * shep(:,2).';
    be = 0.5 * N * shep(:,3).';
    xe = 0.5 * N * shep(:,4).';
    ye = 0.5 * N * shep(:,5).';
    alpha = shep(:,6).';
    alpha = alpha * pi/180;
    theta = theta * pi/180;
    TT = -(P_num-1)/2:(P_num-1)/2;
    for k1 = 1:theta_num
        P_theta = zeros(1,P_num);
        for k2 = 1:max(size(xe))
            a = (ae(k2) * cos(theta(k1)- alpha(k2)))^2+ (be(k2)* sin(theta(k1)- alpha(k2)))^2;
            temp = a -(TT - xe(k2)* cos(theta(k1))- ye(k2)* sin(theta(k1))).^2;
            ind = temp >0;
            P_theta(ind) = P_theta(ind) +rho(k2) *(2 *ae(k2)* be(k2)* sqrt(temp(ind)))./a;
        end
        P(:,k1) = P_theta.';
    end
    