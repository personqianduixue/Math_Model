function dx = func(t,x)
global F;                     % 推力   
global beta;                    % 力的角度
global mu;                    % 月球引力常数
global c;                     % 比冲
dx=zeros(5,1);
dx(1) = x(2);
dx(2) = F/x(5)*sin(beta)-mu/(x(1)*x(1)) + x(1)*x(4)*x(4);
dx(3) = x(4);
dx(4) = -1/x(1)*(F/x(5)*cos(beta)+2*x(2)*x(4));
dx(5) = -F/c;
end

