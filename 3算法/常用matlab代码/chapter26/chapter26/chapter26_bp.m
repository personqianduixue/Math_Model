%% BP神经网络的分类——乳腺肿瘤诊断

%% 创建网络
net = newff(minmax(P_train),[50 1],{'tansig','purelin'},'trainlm');

%% 设置网络参数
net.trainParam.epochs = 1000;
net.trainParam.show = 10;
net.trainParam.lr = 0.1;
net.trainParam.goal = 0.1;

%% 训练网络
net = train(net,P_train,Tc_train);

%% 仿真测试
T_sim = sim(net,P_test);
for i = 1:length(T_sim)
    if T_sim(i) <= 1.5
        T_sim(i) = 1;
    else
        T_sim(i) = 2;
    end
end
result = [T_sim;Tc_test]

number_B = length(find(Tc_test == 1));
number_M = length(find(Tc_test == 2));
number_B_sim = length(find(T_sim == 1 & Tc_test == 1));
number_M_sim = length(find(T_sim == 2 &Tc_test == 2));

disp(['病例总数：' num2str(569)...
      '  良性：' num2str(total_B)...
      '  恶性：' num2str(total_M)]);
disp(['训练集病例总数：' num2str(500)...
      '  良性：' num2str(count_B)...
      '  恶性：' num2str(count_M)]);
disp(['测试集病例总数：' num2str(69)...
      '  良性：' num2str(number_B)...
      '  恶性：' num2str(number_M)]);
disp(['良性乳腺肿瘤确诊：' num2str(number_B_sim)...
      '  误诊：' num2str(number_B - number_B_sim)...
      '  确诊率p1=' num2str(number_B_sim/number_B*100) '%']);
disp(['恶性乳腺肿瘤确诊：' num2str(number_M_sim)...
      '  误诊：' num2str(number_M - number_M_sim)...
      '  确诊率p2=' num2str(number_M_sim/number_M*100) '%']);