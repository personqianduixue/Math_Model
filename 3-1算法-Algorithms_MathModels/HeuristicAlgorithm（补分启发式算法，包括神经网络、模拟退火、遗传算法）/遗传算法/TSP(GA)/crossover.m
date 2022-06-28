function children = crossover(parents)
% CROSSOVER
% children = CROSSOVER(parents) Replicate the mating process by crossing 
% over randomly selected parents. 
%
% Mapped Crossover (PMX) example:     
%           _                          _                          _
%    [1 2 3|4 5 6 7|8 9]  |-> [4 2 3|1 5 6 7|8 9]  |-> [4 2 3|1 8 6 7|5 9]
%    [3 5 4|1 8 7 6|9 2]  |   [3 5 1|4 8 7 6|9 2]  |   [3 8 1|4 5 7 6|9 2]
%           |             |            |           |              |            
%           V             |            V           |              |  
%    [* 2 3|1 5 6 7|8 9] _|   [4 2 3|1 8 6 7|* 9] _|              V
%    [3 5 *|4 8 7 6|9 2]      [3 * 1|4 5 7 6|9 2]           ... ... ...
%

[popSize, numberofcities] = size(parents);    
children = parents; % childrens

for i = 1:2:popSize % pairs counting
    parent1 = parents(i+0,:);  child1 = parent1;
    parent2 = parents(i+1,:);  child2 = parent2;
    % chose two random points of cross-section
    InsertPoints = sort(ceil(numberofcities*rand(1,2)));
    for j = InsertPoints(1):InsertPoints(2)
        if parent1(j)~=parent2(j)
            child1(child1==parent2(j)) = child1(j);
            child1(j) = parent2(j);
            
            child2(child2==parent1(j)) = child2(j);
            child2(j) = parent1(j);
        end
    end
    % two childrens:
    children(i+0,:)=child1;     children(i+1,:)=child2;
end

