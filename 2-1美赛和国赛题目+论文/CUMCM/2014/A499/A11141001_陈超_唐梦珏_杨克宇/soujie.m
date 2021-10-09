clc,clear all;
% tic
global F;                   % 推力
global beta;                % 力的角度
global mu;                  % 月球引力常数
global c;                   % 比冲
mu=4.903737416799999e+12;   % 月球引力常数
c=2940;                     % 比冲
vf=zeros(401,360); 
for li=1500:7500
    F=li;
    for ja=1:3600
        beta=pi/180*ja*0.1;             % 力的角度
        [t,x]=ode45(@func,[0:1:400],[1753000;0;0;1692/1753000;2400]);
        h=x(:,1)-1738000;
        [n,m]=size(h);
        for i=1:n
            vf(i,ja)=sqrt((x(i,4)*(h(i)+1737000))^2+x(i,2)^2);
            if h(i)>2900 & h(i)<3100
                if vf(i,ja)>47 & vf(i,ja)<67
                    ja
                end
            end
        end
    end
end



% toc
%
% figure,plot(t,h);title('h');
% figure,plot(t,x(:,2));title('v');
% figure,plot(t,x(:,3));title('cta');
% figure,plot(t,x(:,4));title('omg');
% figure,plot(t,x(:,5));title('m');