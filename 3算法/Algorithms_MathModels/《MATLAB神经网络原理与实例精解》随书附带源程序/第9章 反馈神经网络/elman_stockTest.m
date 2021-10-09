% elman_stockTest.m
%% 清理
close all
clear,clc

%% 加载数据
load stock_net
load stock2
stock1=stock2';
% load stock1

% whos
%   Name        Size             Bytes  Class      Attributes
% 
%   net         1x1              71177  network              
%   stock1      1x280             2240  double    

% 归一化处理
mi=min(stock1);
ma=max(stock1);
testdata = stock1(141:280);
testdata=(testdata-mi)/(ma-mi);

%% 用后140期数据做测试
% 输入
Pt=[];
for i=1:135
    Pt=[Pt;testdata(i:i+4)];
end
Pt=Pt';
% 测试
Yt=sim(net,Pt); 

%根据归一化公式将预测数据还原成股票价格
YYt=Yt*(ma-mi)+mi;

%目标数据-预测数据
figure
plot(146:280, stock1(146:280), 'r',146:280, YYt, 'b');
legend('真实值', '测试结果');
title('股价预测测试');

%% 
%compute the Hit Rate
% count = 0;
% for i = 100:275
%     if (Store(i)-Store(i-1))*(YYt(i)-YYt(i-1))>0
%         count = count+1;
%     end
% end
% hit_rate=count/175
% 
% xlabel('Dates from 2008.06.16 to 2008.08.19(about the last 180days)');
% ylabel('Price');
% title('Simulation Datas Analysis---One day prediction')
% grid on
