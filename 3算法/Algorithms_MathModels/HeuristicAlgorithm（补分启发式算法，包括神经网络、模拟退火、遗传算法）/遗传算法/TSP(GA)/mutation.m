function children = mutation(parents, probmutation)
% MUTATION
% children = MUTATION(parents, probmutation) Replicate mutation in the 
% population by  selecting an individual with probability probmutation
%     
% swap:    _         _    slide:    _ _________    flip:     ---------->
%     [1 2|3 4 5 6 7 8|9]      [1 2|3 4 5 6 7 8|9]      [1 2|3 4 5 6 7 8|9] 
%                                   _________ _              <----------
%     [1 2|8 4 5 6 7 3|9]      [1 2|4 5 6 7 8 3|9]      [1 2|8 7 6 5 4 3|9]
%

[popSize, numberofcities] = size(parents);
children = parents;
for k=1:popSize
    if rand < probmutation
       InsertPoints = ceil(numberofcities*rand(1,2));
       I = min(InsertPoints);  J = max(InsertPoints);
       switch ceil(rand*6)
           case 1    % swap
             children(k,[I J]) = parents(k,[J I]);
           case 2    % slide
             children(k,[I:J]) = parents(k,[I+1:J I]);
           otherwise % flip
             children(k,[I:J]) = parents(k,[J:-1:I]);
       end
    end
end
