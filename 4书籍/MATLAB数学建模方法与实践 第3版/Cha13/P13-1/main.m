%% 2002年CUMCM彩票问题求解程序
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
%% 功能说明：
%     根据参考答案中的模型，本程序分别对
%     K1、K2、K3、K4型彩票进行求解，并对
%     n、m的各种组合进行循环。求解时，首先
%     计算当前n、m的各奖项获奖概率，然后
%     随机生成多个初始值，调用fmincon函数
%     寻找目标函数的最小值（原目标函数要求
%     极大，但fmincon是寻找极小，故令原目标
%     函数乘以(-1)，寻找新目标函数的极小值），
%     最后比较各种类型彩票的求解结果，输出
%     对应最大的原目标函数的解。
% 本程序包含的m文件为：
%     main.m：主程序
%     cpiao.m：目标函数
%     calculate_probability.m：计算各奖项获奖概率
%     nonlcon.m：非线性约束
% 使用说明：
%    执行main.m
%% 设置初始参数
clc, clear
% 为避免陷入局部最优，需要以随机的初值进行多次尝试，
% 该变量为对每个m/n组合生成随机初值的数目，越大则找到
% 全局最优的概率越大，但程序运行的时间也越长，
% 请根据电脑情况自行设置
nums_test_of_initial_value = 20; 

global v
v = 630589;		% 求解v为630589的收入水平情况
DEBUG = 0;
rng('shuffle')
format long g

%%  求解K1型
p_k1 = [2e-7;8e-7;1.8e-5;2.61e-4;3.42e-3;4.1995e-2];
% 6个奖项6个变量
Aeq=[1,1,1,0,0,0];
beq=1;
a_lb=[10,4,3,4,2];
b_ub=[233,54,17,20,10];
A= [0,0,0,-1,a_lb(4),0;
    0,0,0,1,-b_ub(4),0;
    0,0,0,0,-1,a_lb(5);
    0,0,0,0,1,-b_ub(5)];
b= [0;0;0;0];
lb=[0.5;0;0;0;0;0];
ub=[0.8;1;1;inf;inf;inf];
p_test = p_k1;
rx0_tmp = zeros(6,1);
rx_meta_result = zeros(6,1);
fval_meta_result = inf;
flag_meta_result = nan; %用以判断有没有得到过可行解
if DEBUG == 1
    output_meta_result = [];
end
for j = 1:nums_test_of_initial_value
    %随机生成多个初始值rx0_tmp，以避免局部最优
    rx0_tmp(1) = rand*(0.8-0.5) + 0.5;
    rx0_tmp(2) = rand*(1-rx0_tmp(1));
    rx0_tmp(3) = 1 - rx0_tmp(1) - rx0_tmp(2);
    rx0_tmp(4) = rand*1000;
    rx0_tmp(5) = rand*100;
    rx0_tmp(6) = rand*50;
    % 寻优
    [rx_tmp,fval_tmp,flag_tmp,output_tmp]= ...
            fmincon('cpiao',rx0_tmp,A,b,...
                    Aeq,beq,lb,ub,'nonlcon',[],1,p_test,a_lb,b_ub);
	% 上式倒数第四个参数是为了区分彩票的类型(K1/K2/K3/K4)
	% 最后三个是函数cpiao和nonlcon计算中可能要用到的量。
    if (flag_tmp == 1) && (fval_meta_result > fval_tmp)
        fval_meta_result = fval_tmp;
        rx_meta_result = rx_tmp;
        flag_meta_result = 1;
        if DEBUG == 1
            output_meta_result = output_tmp;
        end
    end
end
% 把求得的最好结果保存下来
if ~isnan(flag_meta_result)
    rx_k1 = rx_meta_result;
    fval_k1 = fval_meta_result;
    flag_k1 = flag_meta_result;
    if DEBUG == 1
        output = output_meta_result;
    end
else
    if DEBUG == 1
        rx_k1 = rx_tmp;
        fval_k1 = fval_tmp;
        flag_k1 = flag_tmp;
        output = output_tmp;
    end
end

%%  对于K2、K3、K4型的情况
% n选m或(m+1)，n的选择范围在29到60，m的选择范围为5到7
% 故有 (60-29+1)*(7-5+1)=96种 取法，
% 依题意，K2、K3、K4都有这96种取法，也即第三维上为3
% 故有下面的变量声明：
p_all=zeros(7,96,3);
rx_all = zeros(7,96,3);
fval_all= zeros(1,96,3);
flag_all = zeros(1,96,3);
for m=5:7
    for n=29:60
        for i=1:3
            % 根据i的值判断属于（K2、K3、K4）中哪一型
            % (i=1是K2;i=2是K3;i=3是K4)，
            % 并根据n、m生成各奖项概率
            % p_temp=eval(sprintf('comb_k%d(m,n)',i+1));
			p_temp = calculate_probability(m,n,i+1);
            p_all(:,(m-5).*32+(n-28),i) = p_temp;
            % K2、K3可合并处理（奖项数目一样）
            if (i ~= 3)
                Aeq=[1,1,1,0,0,0,0];
                beq=1;
                a_lb=[10,4,3,4,2,2];
                b_ub=[233,54,17,20,10,10];
                A=[ 0,0,0,-1,a_lb(4),0,0;
                    0,0,0,1,-b_ub(4),0,0;
                    0,0,0,0,-1,a_lb(5),0;
                    0,0,0,0,1,-b_ub(5),0];
                %由于x(7)可能为零，故不在这里对x(6)/x(7)进行上下限限制，
                % 而在非线性约束nonlcon中进行
                %    0,0,0,0,0,-1,a_lb(6);
                %    0,0,0,0,0,1,-b_ub(6)];
                %b=[0;0;0;0;0;0];
                b=[0;0;0;0];
                lb=[0.5;0;0;0;0;0;0];
                ub=[0.8;1;1;inf;inf;inf;inf];
                p_test = p_temp;
                %随机生成多个初始值rx0_tmp，以避免局部最优
                rx0_tmp = zeros(7,1);
                rx_meta_result = zeros(7,1);
                fval_meta_result = inf;
                flag_meta_result = nan; %用以判断有没有得到过可行解
                for j = 1:nums_test_of_initial_value
                    rx0_tmp(1) = rand*(0.8-0.5) + 0.5;
                    rx0_tmp(2) = rand*(1-rx0_tmp(1));
                    rx0_tmp(3) = 1 - rx0_tmp(1) - rx0_tmp(2);
                    rx0_tmp(4) = rand*1000;
                    rx0_tmp(5) = rand*100;
                    rx0_tmp(6) = rand*50;
                    rx0_tmp(7) = rand*10;
                    [rx_tmp,fval_tmp,flag_tmp]= ...
                            fmincon('cpiao',rx0_tmp,...
                                    A,b,Aeq,beq,lb,ub,...
										'nonlcon',[],i+1,p_test,a_lb,b_ub);
					% 上式倒数第四个参数是为了区分彩票的类型(K1/K2/K3/K4)
					% 最后三个是函数cpiao和nonlcon计算中可能要用到的量。
                    if (flag_tmp == 1) && (fval_meta_result > fval_tmp)
                        fval_meta_result = fval_tmp;
                        rx_meta_result = rx_tmp;
                        flag_meta_result = 1;
                    end
                end
                % 把求得的最好结果保存下来
                rx_all(:,(m-5).*32+(n-28),i) = rx_meta_result;
                fval_all(1,(m-5).*32+(n-28),i) = fval_meta_result;
                flag_all(1,(m-5).*32+(n-28),i) = flag_meta_result;
            else
            % i==3，相应于K4型
                % 对于K4型，因只设到五等奖，故仅5个变量了
                Aeq=[1,1,1,0,0];
                beq=1;
                a_lb=[10,4,3,4];
                b_ub=[233,54,17,20];
                A=[ 0,0,0,-1,a_lb(4);
                    0,0,0,1,-b_ub(4)];
                b=[0;0];
                lb=[0.5;0;0;0;0];
                ub=[0.8;1;1;inf;inf];
                p_test = p_temp;
                %随机生成多个初始值rx0_tmp，以避免局部最优
                rx0_tmp = zeros(5,1);
                rx_meta_result = zeros(5,1);
                fval_meta_result = inf;
                flag_meta_result = nan; %用以判断有没有得到过可行解
                for j = 1:nums_test_of_initial_value
                    rx0_tmp(1) = rand*(0.8-0.5) + 0.5;
                    rx0_tmp(2) = rand*(1-rx0_tmp(1));
                    rx0_tmp(3) = 1 - rx0_tmp(1) - rx0_tmp(2);
                    rx0_tmp(4) = rand*1000;
                    rx0_tmp(5) = rand*100;
                    [rx_tmp,fval_tmp,flag_tmp]= ...
                            fmincon('cpiao',rx0_tmp,A,b,...
                                    Aeq,beq,lb,ub,'nonlcon',...
										[],4,p_test,a_lb,b_ub);
					% 上式倒数第四个参数是为了区分彩票的类型(K1/K2/K3/K4)
					% 最后三个是函数cpiao和nonlcon计算中可能要用到的量。
                    if (flag_tmp == 1) && (fval_meta_result > fval_tmp)
                        fval_meta_result = fval_tmp;
                        rx_meta_result = rx_tmp;
                        flag_meta_result = 1;
                    end
                end
                % 把求得的最好结果保存下来
                rx_all(:,(m-5).*32+(n-28),i) = [rx_meta_result;0;0];
                fval_all(1,(m-5).*32+(n-28),i) = fval_meta_result;
                flag_all(1,(m-5).*32+(n-28),i) = flag_meta_result;
                
            end
        end
    end
end

%%  寻优结束，进行结果处理
% 在所有（K1、K2、K3、K4）求解结果中找目标函数最小的
% 判断（K1、K2、K3、K4）中哪一种的目标函数最小
ind_tmp = (flag_all >= 0);
if sum(sum(sum(ind_tmp))) ~= 0
    % K2、K3、K4的求解中找到了可行解（或最优解）
    val_tmp = fval_all.*ind_tmp;
    [val_tmp2,ind_tmp2] = min(val_tmp);
    [val_min,ind_tmp3] = min(val_tmp2);
    if (flag_k1 < 0)
        % K1的求解中没找到可行解
        signal = 1;     % 标志变量
    else
        if val_min < fval_k1
            signal = 1;
        elseif val_min > fval_k1
            signal = 2;
        else
            signal = 3;
        end
    end
   
else
    % K2、K3、K4的求解中没有找到了可行解
    if (flag_k1 < 0)
        % K1的求解中没找到可行解
        disp('(K1、K2、K3、K4)所有的求解中')
        disp('一个可行解都没有找到')
        disp('(还并不意味着完全没有可行解，')
        disp('也许是初值点选的不好因此没有找到）')
%         break;
    else
        signal = 2;
    end
end

if (signal == 1)
    ind_tmp4 = ind_tmp2(ind_tmp3);
    rx_result = rx_all(:,ind_tmp4,ind_tmp3);
    fval_result = fval_all(:,ind_tmp4,ind_tmp3);
    fval_result =-fval_result;
    n = (ind_tmp4 - floor(ind_tmp4 / 32) * 32) + 28;
    m = floor(ind_tmp4 / 32) + 5;
    p_tmp = p_all(:,ind_tmp4,ind_tmp3);
elseif signal == 2
    rx_result = rx_k1;
    fval_result =-fval_k1;
    p_tmp = p_k1;
else    %signal == 3
    ind_tmp4 = ind_tmp2(ind_tmp3);
    rx_result = rx_all(:,ind_tmp4,ind_tmp3);
    fval_result = fval_all(:,ind_tmp4,ind_tmp3);
    fval_result =-fval_result;
    n = (ind_tmp4 - floor(ind_tmp4 / 32) * 32) + 28;
    m = floor(ind_tmp4 / 32) + 5;
end

%% 输出计算结果
if signal == 1      % 最优解在K2、K3、K4中时
    if ind_tmp3 == 1
        fprintf('最优解为：K2型，%d选%d\n',n,m);
    elseif ind_tmp3 == 2
        fprintf('最优解为：K3型，%d选%d+1\n',n,m);
    elseif ind_tmp3 == 3
        fprintf('最优解为：K4型，%d选%d无特别号\n',n,m);
    end
elseif signal == 2  % 最优解在K1中时
    fprintf('最优解为：K1型，10选6+1\n');
else                % K1的解和K2、K3、K4的解重合时
    if ind_tmp3 == 1
        fprintf('10选6+1和K2型%d选%d同为最优解\n',n,m);
    elseif ind_tmp3 == 2
        fprintf('10选6+1和K3型%d选%d+1同为最优解\n',n,m);
    elseif ind_tmp3 == 3
        fprintf('10选6+1和K4型%d选%d无特别号同为最优解\n',n,m);
    end
end
disp('对应的目标函数值为：')
disp(fval_result)
if signal ~= 3
    disp('最终求解变量值为：')
    disp(rx_result)
    disp('各奖项的金额是：')
    x=zeros(3,1);
    x(1) = (1-p_tmp(4).*rx_result(4)-...
              p_tmp(5).*rx_result(5)-...
              p_tmp(6).*rx_result(6)-...
              p_tmp(7).*rx_result(7)).*rx_result(1)./p_tmp(1);
    x(2) = (1-p_tmp(4).*rx_result(4)-...
              p_tmp(5).*rx_result(5)-...
              p_tmp(6).*rx_result(6)-...
              p_tmp(7).*rx_result(7)).*rx_result(2)./p_tmp(2);
    x(3) = (1-p_tmp(4).*rx_result(4)-...
              p_tmp(5).*rx_result(5)-...
              p_tmp(6).*rx_result(6)-...
              p_tmp(7).*rx_result(7)).*rx_result(3)./p_tmp(3);
    rx_money=[x;rx_result(4:7)];
    disp(rx_money)
else
    disp('最终求解变量值为：')
    disp('10选6+1时')
    disp(rx_k1)
    disp('K%d型时',ind_tmp3+1)
    disp(rx_result)
end


