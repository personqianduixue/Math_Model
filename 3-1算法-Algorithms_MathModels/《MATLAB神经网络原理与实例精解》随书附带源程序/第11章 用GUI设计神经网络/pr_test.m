% This script assumes these variables are defined:
%
%   x - input data.
%   y0 - target data.
rng(0)
% 自定义语句------------------------------------
x=[0.1,4.2;-0.25,2.8;3,1.1;-0.9,1.2;-1.2,1;3.4,1;-2.5,-1.5;3,3.2;...
    -2.5,2.7;3.1,-3.2;4,-1.2;3.9,-1;4,3;-4,3.5]';
y=[1,1,1,1,1,2,1,2,1,2,2,2,2,1];
y0=ind2vec(y);
%-----------------------------------------------

inputs = x;
targets = y0;

% Create a Pattern Recognition Network
hiddenLayerSize = 20;
net = patternnet(hiddenLayerSize);


% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

% View the Network
% view(net)
% 自定义语句----------------------------------
 xx=-4.4:.4:4.5;
 N=length(xx);
 for i=1:N
     for j=1:N
         xt(1,(i-1)*N+j)=xx(i);
             xt(2,(i-1)*N+j)=xx(j);
     end
 end
 
yt=sim(net,xt);
yt=vec2ind(yt);
plot(x(1,y==2),x(2,y==2),'r>','Linewidth', 2);
hold on;
plot(x(1,y==1),x(2,y==1),'bo','Linewidth', 2);

plot(xt(1,yt==1),xt(2,yt==1),'bo');
hold on;
plot(xt(1,yt==2),xt(2,yt==2),'r>');
%-----------------------------------------------
