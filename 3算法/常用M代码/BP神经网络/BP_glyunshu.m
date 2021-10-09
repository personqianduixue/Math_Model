%BP神经网络的公路运量的预测 P121  


%未debug完
clc  %清屏
clear all;  %清楚内存以加快运算速度
close all;   %关闭当前所有figure图像
SamNum=20; %样本的输入数量为20
TestSamNum=20;%测试样本数量为20
ForcastSamNum=2; %预测样本数量为2
HiddenUnitNum=8;%中间层隐节点数量取8
InDim=3;%网络输入维度为三
OutDim=2;%网络输出为维度为2
%原始数据
%人数（万人）
sqrs=[20.55 22.44 25.37 27.13 29.45 30.10 30.96 34.06 36.42 38.09 39.13 39.99 41.43 44.59 47.30 52.89 55.73 56.76 79.17 60.63];
%机动车数（万辆）
sqjdcs=[0.6 0.75 0.85 0.9 1.05 1.35 1.45 1.6 1.7 1.85 2.15 2.2 2.25 2.35 2.5 2.6 2.7 2.85 2.95 3.1];
%公路面积（万平方千米）
sqglmj=[0.09 0.11 0.11 0.14 0.20 0.23 0.23 0.32 0.32 0.34 0.36 0.36 0.38 0.49 0.56 0.59 0.59 0.67 0.69 0.79];
%公路客运量（万人）
glkyl=[5126 6217 7730 9145 10460 11387 12353 15750 18304 19836 21024 19490 20433 22598 25107 33442 36836 40548 42927 43462];
%公路货运量（万吨）
glhyl=[1237 1379 1385 1399 1663 1714 1834 4322 8132 8936 11099 11203 10524 11115 13320 16762 18673 20724 20803 21804];
p=[sqrs;sqjdcs;sqglmj]; %输入数据矩阵
t=[glkyl;glhyl];         %目标数据矩阵
[SamIn,minp,maxp,tn,mint,maxt]=premnmx(p,t); %原始样本对（输入与输出）初始化


rand('state',sum(100*clock));        %依据系统时钟种子产生随机数
NoiseVar=0.01;                       %噪声强度为0.01（添加噪声的原因是防止网络过度拟合）
Noise=NoiseVar*randn(2,SamNum);     %生成噪声
SamOut=tn+Noise;                  %将噪声加到输出样本上

TestSamIn=SamIn;

TestOut=SamOut;

MaxEpochs=50000;
lr=0.035;
E0=0.65*10^(-3);
W1=0.5*rand(HiddenUnitNum,InDim)-0.1;
B1=0.5*rand(HiddenUnitNum,1)-0.1;
W2=0.5*rand(OutDim,HiddenUnitNum)-0.1;
B2=0.5*rand(OutDim,1)-0.1;
ErrHistory=[];

for i=1:MaxEpochs
        HiddenOut=logsig(W1*SamIn+repmat(B1,1,SamNum));
        NetWorkOut=W2*HiddenOut+repmat(B2,1,SamNum);
        Error=SamOut-NetWorkOut;
        SSE=sumsqr(Error)
       
        ErrHistory=[ErrHistory SSE];
        if SSE<E0,break,end
        
        Delta2=Error;
        Deltal= W2'* Delta2.*HiddenOut.*(1-HiddenOut);
        
        dW2=Delta2*HiddenOut';
        dB2=Delta2*ones(SamNum,1);
        
        
        dW1=Deltal*SamIn';
        dB1=Deltal*ones(SamNum,1);
        
        W2=W2+lr*dW2;
        B2=B2+lr*dB2;
        
        W1=W1+lr*dW1;
        B1=B1+lr*dB1;
end


HiddenOut=logsig(W1*SamIn+repmat(B1,1,TestSamNum));
NetworkOut=W2*HiddenOut+repmat(B2,1,TestSamNum);
a=postmnmx(NetworkOut,mint,maxt);
x=1990:2009;
newk=a(1,:);
newh=a(2,:);
figure;
subplot(2,1,1);plot(x,newk,'r-o',x,glkyl,'b--+');
legend('网络输出客运量','实际客运量');
xlabel('年份');ylabel('客运量/万人');
title('源程序神经网络客运量学习和测试对比图');
title('源程序神经网络货运量学习和测试对比图');
subplot(2,1,2);plot(x,newh,'r-o',x,glhyl,'b--+');
legend('网络输出货运量','实际货运量');
xlabel('年份');ylabel('货运量/万吨');

%利用训练好的网络进行测试
pnew=[73,39  75.55  
     3.9635  4.097 
     0.9880  1.0268];
pnewm=tramnmx(pnew,minp,maxp);


HiddenOut=logsig(W1*pnew+repmat(B1,1,ForcastSamNum));
anewn=W2*HiddenOut+repmat(B1,1,ForcastSamNum);


anew=postmnmx(anewn,mint,maxt);
