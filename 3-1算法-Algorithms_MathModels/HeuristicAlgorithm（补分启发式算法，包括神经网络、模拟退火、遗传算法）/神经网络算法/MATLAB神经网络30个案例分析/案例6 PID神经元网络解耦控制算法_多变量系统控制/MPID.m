web browser http://www.ilovematlab.cn/thread-62563-1-1.html
%% 清空环境变量
clc
clear

%% 网络结构初始化
rate1=0.006;rate2=0.001; %学习率
k=0.3;K=3;
y_1=zeros(3,1);y_2=y_1;y_3=y_2;   %输出值
u_1=zeros(3,1);u_2=u_1;u_3=u_2;   %控制率
h1i=zeros(3,1);h1i_1=h1i;  %第一个控制量
h2i=zeros(3,1);h2i_1=h2i;  %第二个控制量
h3i=zeros(3,1);h3i_1=h3i;  %第三个空置量
x1i=zeros(3,1);x2i=x1i;x3i=x2i;x1i_1=x1i;x2i_1=x2i;x3i_1=x3i;   %隐含层输出 

%权值初始化
k0=0.03;

%第一层权值
w11=k0*rand(3,2);
w12=k0*rand(3,2);
w13=k0*rand(3,2);
%第二层权值
w21=k0*rand(1,9);
w22=k0*rand(1,9);
w23=k0*rand(1,9);

%值限定
ynmax=1;ynmin=-1;  %系统输出值限定
xpmax=1;xpmin=-1;  %P节点输出限定
qimax=1;qimin=-1;  %I节点输出限定
qdmax=1;qdmin=-1;  %D节点输出限定
uhmax=1;uhmin=-1;  %输出结果限定

%% 网络迭代优化
for k=1:1:200

    %% 控制量输出计算
    %--------------------------------网络前向计算--------------------------
    
    %系统输出
    y1(k)=(0.4*y_1(1)+u_1(1)/(1+u_1(1)^2)+0.2*u_1(1)^3+0.5*u_1(2))+0.3*y_1(2);
    y2(k)=(0.2*y_1(2)+u_1(2)/(1+u_1(2)^2)+0.4*u_1(2)^3+0.2*u_1(1))+0.3*y_1(3);
    y3(k)=(0.3*y_1(3)+u_1(3)/(1+u_1(3)^2)+0.4*u_1(3)^3+0.4*u_1(2))+0.3*y_1(1);
    
    r1(k)=0.7;r2(k)=0.4;r3(k)=0.6;  %控制目标
    
    %系统输出限制
    yn=[y1(k),y2(k),y3(k)];
    yn(find(yn>ynmax))=ynmax;
    yn(find(yn<ynmin))=ynmin;
    
    %输入层输出
    x1o=[r1(k);yn(1)];x2o=[r2(k);yn(2)];x3o=[r3(k);yn(3)];
    
    %隐含层 
    x1i=w11*x1o;
    x2i=w12*x2o;
    x3i=w13*x3o;

    %比例神经元P计算
    xp=[x1i(1),x2i(1),x3i(1)];
    xp(find(xp>xpmax))=xpmax;
    xp(find(xp<xpmin))=xpmin;
    qp=xp;
    h1i(1)=qp(1);h2i(1)=qp(2);h3i(1)=qp(3);

    %积分神经元I计算
    xi=[x1i(2),x2i(2),x3i(2)];
    qi=[0,0,0];qi_1=[h1i(2),h2i(2),h3i(2)];
    qi=qi_1+xi;
    qi(find(qi>qimax))=qimax;
    qi(find(qi<qimin))=qimin;
    h1i(2)=qi(1);h2i(2)=qi(2);h3i(2)=qi(3);

    %微分神经元D计算
    xd=[x1i(3),x2i(3),x3i(3)];
    qd=[0 0 0];
    xd_1=[x1i_1(3),x2i_1(3),x3i_1(3)];
    qd=xd-xd_1;
    qd(find(qd>qdmax))=qdmax;
    qd(find(qd<qdmin))=qdmin;
    h1i(3)=qd(1);h2i(3)=qd(2);h3i(3)=qd(3);

    %输出层计算
    wo=[w21;w22;w23];
    qo=[h1i',h2i',h3i'];qo=qo';
    uh=wo*qo;
    uh(find(uh>uhmax))=uhmax;
    uh(find(uh<uhmin))=uhmin;
    u1(k)=uh(1);u2(k)=uh(2);u3(k)=uh(3);  %控制律
    
    %% 网络权值修正
    %---------------------网络反馈修正----------------------
    
    %计算误差
    error=[r1(k)-y1(k);r2(k)-y2(k);r3(k)-y3(k)];  
    error1(k)=error(1);error2(k)=error(2);error3(k)=error(3);
    J(k)=0.5*(error(1)^2+error(2)^2+error(3)^2);   %调整大小
    ypc=[y1(k)-y_1(1);y2(k)-y_1(2);y3(k)-y_1(3)];
    uhc=[u_1(1)-u_2(1);u_1(2)-u_2(2);u_1(3)-u_2(3)];
    
    %隐含层和输出层权值调整

    %调整w21
    Sig1=sign(ypc./(uhc(1)+0.00001));
    dw21=sum(error.*Sig1)*qo';  
    w21=w21+rate2*dw21;
    
    %调整w22
    Sig2=sign(ypc./(uh(2)+0.00001));
    dw22=sum(error.*Sig2)*qo';
    w22=w22+rate2*dw22;
    
    %调整w23
    Sig3=sign(ypc./(uh(3)+0.00001));
    dw23=sum(error.*Sig3)*qo';
    w23=w23+rate2*dw23;

    %输入层和隐含层权值调整
    delta2=zeros(3,3);
    wshi=[w21;w22;w23];
    for t=1:1:3
        delta2(1:3,t)=error(1:3).*sign(ypc(1:3)./(uhc(t)+0.00000001));
    end
    for j=1:1:3
        sgn(j)=sign((h1i(j)-h1i_1(j))/(x1i(j)-x1i_1(j)+0.00001));
    end
 
     s1=sgn'*[r1(k),y1(k)];
     wshi2_1=wshi(1:3,1:3);
     alter=zeros(3,1);
     dws1=zeros(3,2);
     for j=1:1:3
         for p=1:1:3
             alter(j)=alter(j)+delta2(p,:)*wshi2_1(:,j);
         end
     end
     
     for p=1:1:3
         dws1(p,:)=alter(p)*s1(p,:);
     end
     w11=w11+rate1*dws1;

     %调整w12
    for j=1:1:3
        sgn(j)=sign((h2i(j)-h2i_1(j))/(x2i(j)-x2i_1(j)+0.0000001));
    end
    s2=sgn'*[r2(k),y2(k)];
    wshi2_2=wshi(:,4:6);
    alter2=zeros(3,1);
    dws2=zeros(3,2);
    for j=1:1:3
        for p=1:1:3
            alter2(j)=alter2(j)+delta2(p,:)*wshi2_2(:,j);
        end
    end
    for p=1:1:3
        dws2(p,:)=alter2(p)*s2(p,:);
    end
    w12=w12+rate1*dws2;
    
    %调整w13
    for j=1:1:3
        sgn(j)=sign((h3i(j)-h3i_1(j))/(x3i(j)-x3i_1(j)+0.0000001));
    end
    s3=sgn'*[r3(k),y3(k)];
    wshi2_3=wshi(:,7:9);
    alter3=zeros(3,1);
    dws3=zeros(3,2);
    for j=1:1:3
        for p=1:1:3
            alter3(j)=(alter3(j)+delta2(p,:)*wshi2_3(:,j));
        end
    end
    for p=1:1:3
        dws3(p,:)=alter2(p)*s3(p,:);
    end
    w13=w13+rate1*dws3;

    %参数更新
    u_3=u_2;u_2=u_1;u_1=uh;
    y_2=y_1;y_1=yn;
    h1i_1=h1i;h2i_1=h2i;h3i_1=h3i;
    x1i_1=x1i;x2i_1=x2i;x3i_1=x3i;
end

%% 结果分析
time=0.001*(1:k);
figure(1)
subplot(3,1,1)
plot(time,r1,'r-',time,y1,'b-');
title('PID神经元网络控制','fontsize',12);
ylabel('控制量1','fontsize',12);
legend('控制目标','实际输出','fontsize',12);

subplot(3,1,2)
plot(time,r2,'r-',time,y2,'b-');

ylabel('控制量2','fontsize',12);
legend('控制目标','实际输出','fontsize',12);
subplot(3,1,3)
plot(time,r3,'r-',time,y3,'b-');       
xlabel('时间（秒）','fontsize',12);ylabel('控制量3','fontsize',12);
legend('控制目标','实际输出','fontsize',12);

figure(2)
plot(time,u1,'r-',time,u2,'g-',time,u3,'b');
title('PID神经网络提供给对象的控制输入');
xlabel('时间'),ylabel('被控量');
legend('u1','u2','u3');grid
figure(3)
figure(3)
plot(time,J,'r-');
axis([0,0.2,0,1]);grid
title('控制误差曲线','fontsize',12);
xlabel('时间','fontsize',12);ylabel('控制误差','fontsize',12);
web browser http://www.ilovematlab.cn/thread-62563-1-1.html