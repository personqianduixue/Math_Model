%模拟退火算法解决背包问题
%0-1背包，假设12件物品，质量分别为2磅，5磅，18，3，2，5，10，4，11，7，14，6磅
%价值分别为5元，10，13，4，3，11，13，10，8，16，7，4元
%包的最大允许质量为46磅
clear
clc
a=0.95;  %温度衰减函数的参数
k=[5;10;13;4;3;11;13;10;8;16;7;4];
k=-k;%模拟退火算法求解最小值，故取负数
d=[2;5;18;3;2;5;10;4;11;7;14;6];
restriction=46;
num=12;
sol_new=ones(1,num); %生成初始解
E_current=inf;E_best=inf;
% E_current是当前解对应的目标函数值
%E_new是新解的目标函数值
%E_是最优解
sol_current=sol_new;sol_best=sol_new;
t0=97; tf=3;  t=t0;
p=1;

while t>=tf
    for r=1:100
        %产生随机扰动
        tmp=ceil(rand.*num);
        sol_new(1,tmp)=~sol_new(1,tmp);
        %检查是否满足约束要求
        while 1
            q=(sol_new*d<=restriction);
            if~q
                p=~p    %实现交错着逆转头尾的第一个1
                tmp=find(sol_new==1);
                if p
                     sol_new(1,tmp)=0;
                else 
                    sol_new(1,tmp(end))=0;
                end
            else
                break
            end
        end
        
%计算背包中的物品价值
E_new=sol_new*k;
if E_new<E_current
   E_current=E_new;
   sol_current=sol_new;
   if E_new<E_best
       %把最好的冷却过程中的解保留下来
       E_best=E_new;
       sol_best=sol_new;
   end
else
    if rand<exp(-(E_new-E_current)./t)
        E_current=E_new;
        sol_current=sol_new;
    else
        sol_new=sol_current;
    end
end
    end
    t=t.*a;
end

disp('最优解为：')
sol_best;
disp('物品总价值等于：')
val= -E_best;
disp(val)
disp('背包中的物品重量为：')
disp(sol_best * d)

%最优解的0-1表示物品是否放入背包，例如，第四个位置上是1，即第四件物品放入背包
