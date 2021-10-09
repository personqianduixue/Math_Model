function [W_ind,W_dat] = SystemMatrix(theta,N,P_num,delta)

% 用于验证的一小段程序
% theta = 45；
% N = 10;
% P_num = 15;
% delta = 1;
% -------------------------
N2 = N^2;
M = length(theta) * P_num;
W_ind = zeros(M,2 * N);
W_dat = zeros(M,2 * N);

% t_max = sqrt(2) *N * delta;
% t = linspace(-t_max/2,t_max/2,P_num);
t = (-(P_num-1)/2:(P_num-1)/2)*delta;
if N <= 10 && length(theta) <= 5
    x = (-N/2: 1 :N/2)*delta;
    y = (-N/2: 1 :N/2)*delta;
    plot(x,meshgrid(y,x),'k');
    hold on;
    plot(meshgrid(x,y),y,'k');
    axis([-N/2-5,N/2+5,-N/2-5,N/2+5]);
    text(0,-0.4*delta,'0');
end
% = = = = = =投影矩阵的计算 = = = = = = %
for jj = 1: length(theta)
    for ii = 1:1:P_num
        
        u = zeros(1,2*N);v = zeros(1,2*N);
        th = theta(jj);
        if th >=180|| th < 0
            error('输入角度必须在0-180之间');
       %% = = = = =投影角度等于90°时 = = = = = =%%
        elseif th == 90
                
                if N <=10 && length(theta) <=5
                   xx = (-N/2-2:0.01:N/2+2)*delta;
                   yy = t(ii);
                   plot(xx,yy,'b');
                   hold on;
                end
                if t(ii) >= N/2 * delta || t(ii) <= -N/2 * delta;
                    continue;
                end
                kout = N * ceil(N/2-t(ii)/delta);
                kk = (kout-(N-1)):1:kout;
                u(1:N) = kk;
                v(1:N) = ones(1,N) * delta;
          %% = = = = = = 投影角度等于0时 = = = = = = %%
        elseif th == 0
            
            if N <= 10 && length(theta) <= 5
                yy = (-N/2-2:0.01:N/2+2) * delta;
                xx = t(ii);
                plot(xx,yy,'b');
                hold on;
            end
            
            if t(ii) >= N/2 * delta || t(ii) <= -N/2 * delta;
                continue;
            end
            kin = ceil(N/2+t(ii)/delta);
            kk = kin: N: (kin + N * (N-1));
            u(1:N) = kk;
            v(1:N) = ones(1,N) * delta;
        else
            if th > 90
                th_temp = th - 90;
            elseif th < 90
                th_temp = 90 - th;
            end
            th_temp = th_temp * pi/180;
            
            b = t/cos(th_temp);
            m = tan(th_temp);
            y1d = -N/2 * delta * m + b(ii);
            y2d = N/2 * delta * m + b(ii);
            
            if N <= 10 && length(theta) <= 5
                xx = (-N/2-2:0.01:N/2+2) * delta;
                if th < 90
                    yy = -m * xx + b(ii);
                elseif th > 90
                    yy = m * xx + b(ii);
                end
                plot(xx,yy,'b');
                hold on;
            end
            
            if(y1d < -N/2 * delta && y2d < -N/2 * delta) || (y1d > N/2 * delta && y2d > -N/2 * delta)
                continue;
            end
        %% = = == = = =确定射入点（xin，yin）、出射点（xout，yout）及参数d1 = = = = = %%
        if y1d <= N/2 * delta && y1d >= -N/2 * delta && y2d > N/2 * delta
            yin = y1d;
            d1 = yin - floor(yin/delta) * delta;
            kin = N * floor(N/2 - yin/delta) + 1;
            yout = N/2 * delta;
            xout = (yout - b(ii))/m;
            kout = ceil(xout/delta) + N/2;
        elseif y1d <= N/2 * delta && y1d >= -N/2 * delta && y2d >= -N/2 * delta && y2d < N/2 * delta
            yin = y1d;
            d1 = yin - floor(yin/delta) * delta;
            kin = N * floor(N/2 - yin/delta) + 1;
            yout = y2d;
            kout = N * floor(N/2 - yout/delta) + N;
        elseif y1d <- N/2 * delta && y2d >= N/2 * delta
            yin = -N/2 * delta;
            xin = (yin - b(ii))/m;
            d1 = N/2 * delta + (floor(xin/delta)*delta*m+b(ii));
            kin = N * (N - 1) + N/2 + ceil(xin/delta);
            yout = N/2 * delta;
            xout = (yout - b(ii))/m;
            kout = ceil(xout/delta) + N/2;
        elseif y1d < -N/2 * delta && y2d >= -N/2 * delta && y2d < N/2 * delta 
            yin = -N/2 * delta;
            xin = (yin - b(ii))/m;
            d1 = N/2 * delta + (floor(xin/delta) * delta * m + b(ii));
            kin = N * (N - 1) + N/2 + ceil(xin/delta);
            yout = y2d;
            kout = N * floor(N/2 - yout/delta) + N;
        else
            continue
        end
      %% = = == = = 计算射线i穿过像素的编号和长度 = = = = = = %%
      k = kin; 
      c = 0;
      d2 = d1 + m * delta;
      while k >=1 && k <= N2
          c =c +1;
          if d1 >= 0 && d2 > delta
              u(c) = k;
              v(c) = (delta - d1) * sqrt(m^2 + 1)/m;
              if k > N && k ~= kout
                  k = k - N;
                  d1 = d1 - delta;
                  d2 = d1 + m * delta;
              else
                  break;
              end
          elseif d1 >= 0 && d2 == delta
              u(c) = k;
              v(c) = delta * sqrt(m^2 + 1);
              if k > N && k~= kout
                  k = k - N + 1;
                  d1 = 0;
                  d2 = d1 + m * delta;
              else
                  break;
              end
          elseif d1 >= 0 && d2 < delta
              u(c) = k;
              v(c) = delta * sqrt(m^2 + 1);
              if k ~= kout
                  k = k + 1;
                  d1 = d2;
                  d2 = d1 + m * delta;
              else
                  break;
              end
          elseif d1 <= 0 && d2 >=0 && d2 <= delta
              u(c) = k;
              v(c) = delta * sqrt(m^2 + 1);
              if k ~= kout
                  k = k + 1;
                  d1 = d2;
                  d2 = d1 + m * delta;
              else
                  break;
              end   
          elseif d1 <= 0 && d2 > delta
              u(c) = k;
              v(c) = delta * sqrt(m^2 + 1)/m;
              if k > N && k ~= kout
                  k = k - N;
                  d1 = -delta + d1;
                  d2 = d1 + m * delta;
              else
                  break;
              end
          end
      end
      %% = = = 如果投影角度小于90，还需要利用投影射线关于y轴的对称性计算出权因子向量
      if th < 90
          u_temp = zeros(1,2 * N);
          if any(u) == 0
              continue;
          end
          ind = u >0;
          for k = 1: length(u(ind))
              r = rem(u(k),N);
              if r == 0
                  u_temp(k) = u(k) - N + 1;
              else 
                  u_temp(k) = u(k) - 2 * r + N + 1;
              end 
          end
          u = u_temp;
      end
        end
        W_ind((jj-1)* P_num +ii,:) = u;
        W_dat((jj-1)* P_num +ii,:) = v;
    end
end
                
                