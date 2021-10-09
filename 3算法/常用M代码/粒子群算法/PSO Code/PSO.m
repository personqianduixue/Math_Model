function fbestval = PSO()
%clear;
fname =@f1;  %评估函数文件名
NDim = 30;   % 决策变量的维数
MaxIter =3000;  % PSO的总迭代次数
Bound = fname(); % 确定决策变量的上下限


%function [fbestval,bestparticle,phis] = PSOconstriction(fname,bound,vmax,NDim,MaxIter)
%                          
%   Run a PSO algorithm
%   
%Input Arguments:
%   fname       - the name of the evaluation .m function
%   bounds      - a matrix of upper and lower bounds on the variables
%   vmax        - maximum velocity
%   NDim        - dimension of the evalation function
%   MaxIter     - maximum iteration


% Modified Particle Swarm Optimization for Matlab  
% Copyright (C) 2002 Shan He, the University of Liverpool
% Intelligence Engineering & Automation Group

iteration = 0;
PopSize=48;     % population of particles
w=1;
c1=2.05;
c2=2.05;
gbest = zeros(NDim,PopSize);
% Defined lower bound and upper bound.
LowerBound = zeros(NDim,PopSize);
UpperBound = zeros(NDim,PopSize);
for i=1:PopSize
    LowerBound(:,i)=Bound(:,1);
    UpperBound(:,i)=Bound(:,2);
end

population =  rand(NDim, PopSize).*(UpperBound-LowerBound) + LowerBound;     % Initialize swarm population
vmax = ones(NDim,PopSize);

for i=1:NDim
    vmax(i,:)=(UpperBound(i,:)-LowerBound(i,:))/10;
end
velocity = vmax.*rand(1);      % Initialize velocity


% Evaluate initial population
for i = 1:PopSize,
    fvalue(i) = fname(population(:,i));
end

pbest = population;   % Initializing Best positions’ matrix
fpbest = fvalue;      % Initializing the corresponding function values
% Finding best particle in initial population
[fbestval,index] = min(fvalue);    % Find the globe best   

%population = population + velocity;
while(iteration < MaxIter)
    iteration = iteration +1;
       

    R1 = rand(NDim, PopSize);
    R2 = rand(NDim, PopSize);

    
    % Evaluate the new swarm
    for i = 1:PopSize,
        fvalue(i) = fname(population(:,i));
        %fprintf('%d',i);
    end
    % Updating the pbest for each particle

    % Updating the pbest for each particle
    changeColumns = fvalue < fpbest;
    pbest(:, find(changeColumns)) = population(:, find(changeColumns));     % find(changeColumns) find the columns which the values are 1
    fpbest = fpbest.*( ~changeColumns) + fvalue.*changeColumns;    
        
    % Updating index 
    [fbestval, index] = min(fpbest);
    

    for i=1:PopSize
        gbest(:,i) = population(:,index);
    end

    velocity = w*velocity + c1*R1.*(pbest-population) + c2*R2.*(gbest-population);
    
    velocity=(velocity<-vmax).*(-vmax)+(velocity>vmax).*(vmax)+(velocity>-vmax & velocity<vmax).*velocity;
    
    
    % Update the swarm particle
    population = population + velocity;
    
    % Prevent particles from flying outside search space
    population(population>UpperBound)=UpperBound(population>UpperBound);                % crop to upper range
    population(population<LowerBound)=LowerBound(population<LowerBound);                % crop to lower range   
    
     % plot best fitness
%      Best(iteration) =fbestval;
%      plot(log10(Best),'ro');xlabel('generation'); ylabel('log10(f(x))');
%      text(0.5,0.95,['Best = ', num2str(Best(iteration))],'Units','normalized');   
%      drawnow;    
   fprintf('%d\t%i\n',iteration,fbestval);
   his(iteration) = fbestval;
end  
   plot(his,'b');
   xlabel('Iteration');
   ylabel('Fvalue');
   hold on;
end




