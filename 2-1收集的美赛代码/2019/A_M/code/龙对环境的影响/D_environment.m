clear,clc
pressure = [1 1/2 3 1/2;      % pressure comparison matrix
            2 1 4 1;
            1/3 1/4 1 1/5;
            2 1 5 1  ];
state = [1 1/5 2 2;           % stste comparison matrix
         5 1 4 4;
         1/2 1/4 1 1;
         1/2 1/4 1 1];
pre_ori = [3 25 1 10];        % original data of stress
sta_ori = [7 20 25 200];      % original data 0f state 

%% Solving the comprehensive impact index
pre_weights = 0.6*AHP(pressure) % dragon's weight on environmental stress indicators
sta_weights = 0.4*AHP(state)    % environmental status weight

% normalized dragon's pressure on the environment and the state of the environment
[pre_normal,sta_normal]= normolize(pre_ori,sta_ori)

% weighting
CPI = 100*sum(pre_weights'.*pre_normal)
CSI = 100*sum(sta_weights'.*sta_normal)
CII = CPI+CSI




        
