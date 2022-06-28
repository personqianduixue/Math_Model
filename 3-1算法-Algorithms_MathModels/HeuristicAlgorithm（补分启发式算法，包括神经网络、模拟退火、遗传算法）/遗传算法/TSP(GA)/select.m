function popselected = select(pop, fitness, nselected, method)
% SELECT
% popselected = SELECT(pop, fitness, nselected, method) select the fittest 
% individuals to survive to the next generation.
%

popSize = size(pop,1);

switch method
    
    case 'roulette'
        p=fitness/sum(fitness); % probabilities of select
        cump=cumsum(p);         % cumulative sum of probabilities
        I = interp1([0 cump],1:(popSize+1),rand(1,nselected),'linear');
        % random numbers from 1:nselected according probabilities
        I = floor(I); 
        
    case 'competition'
        % randomly generated two sets of population
        i1 = ceil( popSize*rand(1,nselected) );
        i2 = ceil( popSize*rand(1,nselected) );
        % compare the fitness and select the fitter
        I = i1.*( fitness(i1)>=fitness(i2) ) + ...
            i2.*( fitness(i1)< fitness(i2) );
        
end

popselected=pop(I,:);
