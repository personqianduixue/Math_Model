% RESPLOT.M       (RESult PLOTing)
%
% This function plots some results during computation.
%
% Syntax:  resplot(Chrom,IndAll,ObjV,Best,gen)
%
% Input parameters:
%    Chrom     - Matrix containing the chromosomes of the current
%                population. Each line corresponds to one individual.
%    IndAll    - Matrix containing the best individual (variables) of each
%                generation. Each line corresponds to one individual.
%    ObjV      - Vector containing objective values of the current
%                generation
%    Best      - Matrix containing the best and average Objective values of 
%                each generation, [best value per generation,average value 
%                per generation]
%    gen       - Scalar containing the number of the current generation
%
% Output parameter:
%    no output parameter

%  Author:    Hartmut Pohlheim
%  History:   27.11.93     file created
%             29.11.93     decision, if plot or not deleted
%                          yscale not log
%             15.12.93     MutMatrix as parameter and plot added
%             16.03.94     function cleaned, MutMatrix removed, IndAll added

function resplot(Chrom,IndAll,ObjV,Best,gen);

   % plot of best and mean value per generation
      subplot(2,2,1), plot(Best);
      title('Best and mean objective value');
      xlabel('generation'), ylabel('objective value');

   % plot of best individuals in all generations
      subplot(2,2,2), plot(IndAll);
      title(['Best individuals']);
      xlabel('generation'), ylabel('value of variable');

   % plot of variables of all individuals in current generation
      subplot(2,2,3), plot(Chrom');
      title(['All individuals in gen ',num2str(gen)]);
      xlabel('number of variable'), ylabel('value of variable');

   % plot of all objective values in current generation
      subplot(2,2,4), plot(ObjV,'y.');
      title(['All objective values']);
      xlabel('number of individual'), ylabel('objective value');

   drawnow;


% End of function

