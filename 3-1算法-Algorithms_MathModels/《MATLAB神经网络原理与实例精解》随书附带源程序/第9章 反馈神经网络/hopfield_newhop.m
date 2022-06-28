% hopfield_newhop.m
% 定义吸引子
T = [-1,  1;...
     1,  -1]
 
 % 创建hopfield网络
 net=newhop(T);
 
 % 用原平衡位置的坐标作为输入进行仿真
 Y = sim(net,2,[],T);
 fprintf('输入平衡中心得出的结果：\n');
 disp(Y);

 % 用新的值作为输入
 rng(0);
 N=10;
 for i=1:N
     y=rand(1,2)*2-1;
     y(y>0) = 1;
     y(y<0) = -1;
     [Y,a,b]=sim(net,{1,5},[],y');
     if (sum(abs(b))<1.0e-1)
         b=[0,0]';
     end
     fprintf('第 %d 组测试数据: ',i);
     disp(y);
     fprintf('网络输出:         ');
     disp(b');
end
