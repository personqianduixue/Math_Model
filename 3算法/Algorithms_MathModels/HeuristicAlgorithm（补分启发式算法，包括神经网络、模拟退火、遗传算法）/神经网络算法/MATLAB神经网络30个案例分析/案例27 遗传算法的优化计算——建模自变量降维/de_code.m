function Val=de_code(x)
% 全局变量声明
global S P_train T_train P_test T_test mint maxt 
global p t r s s1 s2
% 数据提取
x=x(:,1:S);
[m,n]=find(x==1);
p_train=zeros(size(n,2),size(T_train,2));
p_test=zeros(size(n,2),size(T_test,2));
for i=1:length(n)
    p_train(i,:)=P_train(n(i),:);
    p_test(i,:)=P_test(n(i),:);
end
t_train=T_train;
p=p_train;
t=t_train;
% 遗传算法优化BP网络权值和阈值
r=size(p,1);
s2=size(t,1);
s=r*s1+s1*s2+s1+s2;
aa=ones(s,1)*[-1,1];
popu=20;  % 种群规模
initPpp=initializega(popu,aa,'gabpEval');  % 初始化种群
gen=100;  % 遗传代数
% 调用GAOT工具箱，其中目标函数定义为gabpEval
x=ga(aa,'gabpEval',[],initPpp,[1e-6 1 0],'maxGenTerm',gen,...
'normGeomSelect',0.09,'arithXover',2,'nonUnifMutation',[2 gen 3]);
% 创建BP网络
net=newff(minmax(p_train),[s1,1],{'tansig','purelin'},'trainlm');
% 将优化得到的权值和阈值赋值给BP网络
[W1,B1,W2,B2]=gadecod(x);
net.IW{1,1}=W1;
net.LW{2,1}=W2;
net.b{1}=B1;
net.b{2}=B2;
% 设置训练参数
net.trainParam.epochs=1000;
net.trainParam.show=10;
net.trainParam.goal=0.1;
net.trainParam.lr=0.1;
net.trainParam.showwindow=0;
% 训练网络
net=train(net,p_train,t_train);
% 仿真测试
tn_sim=sim(net,p_test);
% 反归一化
t_sim=postmnmx(tn_sim,mint,maxt);
% 计算均方误差
SE=sse(t_sim-T_test);
% 计算适应度函数值
Val=1/SE;
end
