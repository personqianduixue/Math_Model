function ri=CalculationRI()
ri=zeros(1,30); %定义结果输出格式并初始化，RI(1)直接赋值为0
for n=3:30    %循环计算阶数3到30的随机正互反矩阵的RI
    %n=20;    %起初以20阶矩阵为例测试
    times=1000;    %10000个子样
    enum=[9 8 7 6 5 4 3 2 1 1/2 1/3 1/4 1/5 1/6 1/7 1/8 1/9];%矩阵元素从enum中取得
    lamda = zeros(1, times);    %最大特征值向量初始化
    A=ones(n,n);                %初始化相应阶数的矩阵

    for num=1:times             %循环
        for i=1:n               %把矩阵A赋值为正互反矩阵
            for j=i+1:n
                A(i,j)=enum(ceil(17*rand(1))); %矩阵的上半部分从enum中随机取值
                A(j,i)=1/A(i,j);               %矩阵的下半部分与上半部分成倒数
                A(i,i)=1;                      %矩阵对角线为1
            end
        end
        V=eig(A);               %求得A的特征向量
        lamda(num)=max(V);      %以最大特征值给lamda向量赋值
    end

    k=sum(lamda)/times;   %最大特征值的平均值
    ri(n)=(k-n)/(n-1);    %得出对应的RI(n)
end
ri %最后输出RI向量，即1－30阶矩阵的平均随机一致性指标
