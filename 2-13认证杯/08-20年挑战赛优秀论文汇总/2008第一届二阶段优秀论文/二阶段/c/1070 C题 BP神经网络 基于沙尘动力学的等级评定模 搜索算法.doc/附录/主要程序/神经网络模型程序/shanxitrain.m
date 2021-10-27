net= newff ( minmax(pp), [28,1],{'tansig','logsig'},'traingdx');
net.trainParam.epochs = 20000;
net.trainParam.goal = 0.002;
net.trainParam.Ir= 0.05;
net. trainParam. show = 50;
net=train(net,pp,tt);

%ÏµÍ³·ÂÕæ

%result=sim(net,pp)