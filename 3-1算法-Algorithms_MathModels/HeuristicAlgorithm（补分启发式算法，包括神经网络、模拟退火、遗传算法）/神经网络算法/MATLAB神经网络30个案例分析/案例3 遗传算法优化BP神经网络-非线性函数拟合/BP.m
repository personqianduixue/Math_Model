%读取数据
data=xlsread('data.xls');

%训练预测数据
data_train=data(1:113,:);
data_test=data(118:123,:);

input_train=data_train(:,1:9)';
output_train=data_train(:,10)';

input_test=data_test(:,1:9)';
output_test=data_test(:,10)';

%数据归一化
[inputn,mininput,maxinput,outputn,minoutput,maxoutput]=premnmx(input_train,output_train); %对p和t进行字标准化预处理 
net=newff(minmax(inputn),[10,1],{'tansig','purelin'},'trainlm');

net.trainParam.epochs=100;
net.trainParam.lr=0.1;
net.trainParam.goal=0.00001;
%net.trainParam.show=NaN

%网络训练
net=train(net,inputn,outputn);

%数据归一化
inputn_test = tramnmx(input_test,mininput,maxinput);

an=sim(net,inputn);

test_simu=postmnmx(an,minoutput,maxoutput);

error=test_simu-output_train;

plot(error)

k=error./output_train

