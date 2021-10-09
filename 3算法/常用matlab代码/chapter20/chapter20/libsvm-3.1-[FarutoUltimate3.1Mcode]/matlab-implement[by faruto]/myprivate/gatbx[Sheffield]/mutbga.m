% MUTBGA.M       (real-value MUTation like Breeder Genetic Algorithm)
%
% This function takes a matrix OldChrom containing the real
% representation of the individuals in the current population,
% mutates the individuals with probability MutR and returns
% the resulting population.
%
% This function implements the mutation operator of the Breeder Genetic
% Algorithm. (Muehlenbein et. al.)
%
% Syntax:  NewChrom = mutbga(OldChrom, FieldDR, MutOpt)
%
% Input parameter:
%    OldChrom  - Matrix containing the chromosomes of the old
%                population. Each line corresponds to one individual.
%    FieldDR   - Matrix describing the boundaries of each variable.
%    MutOpt    - (optional) Vector containing mutation rate and shrink value
%                MutOpt(1): MutR - number containing the mutation rate -
%                           probability for mutation of a variable
%                           if omitted or NaN, MutR = 1/variables per individual
%                           is assumed
%                MutOpt(2): MutShrink - (optional) number for shrinking the
%                           mutation range in the range [0 1], possibility to
%                           shrink the range of the mutation depending on,
%                           for instance actual generation.
%                           if omitted or NaN, MutShrink = 1 is assumed
%
% Output parameter:
%    NewChrom  - Matrix containing the chromosomes of the population
%                after mutation in the same format as OldChrom.

% Author:     Hartmut Pohlheim
% History:    23.11.93     file created
%             24.11.93     function optimised (for,for-loop to for-loop)
%                          mutation rate included
%                          style improved
%             06.12.93     change of function name
%                          check of boundaries after mutation out of loop
%             16.12.93     NewMutMat and OldMutMat included for compability
%             16.02.94     preparation for multi-subpopulations at once
%             25.02.94     NewMutMat and OldMutMat removed (now in mutran10.m)
%                          clean up
%                          change of function name in mutbga.m
%             03.03.94     Lower and Upper directly used (less memory)
%             19.03.94     multipopulation support removed
%                          more parameter checks
%             27.03.94     Delta exact calculated, for loop saved


function NewChrom = mutbga(OldChrom, FieldDR, MutOpt);

% Check parameter consistency
   if nargin < 2,  error('Not enough input parameter'); end

   % Identify the population size (Nind) and the number of variables (Nvar)
   [Nind,Nvar] = size(OldChrom);

   [mF, nF] = size(FieldDR);
   if mF ~= 2, error('FieldDR must be a matrix with 2 rows'); end
   if Nvar ~= nF, error('FieldDR and OldChrom disagree'); end

   if nargin < 3, MutR = 1/Nvar; MutShrink = 1;
   elseif isempty(MutOpt), MutR = 1/Nvar; MutShrink = 1;
   elseif isnan(MutOpt), MutR = 1/Nvar; MutShrink = 1;
   else   
      if length(MutOpt) == 1, MutR = MutOpt; MutShrink = 1;
      elseif length(MutOpt) == 2, MutR = MutOpt(1); MutShrink = MutOpt(2);
      else, error(' Too many parameter in MutOpt'); end
   end

   if isempty(MutR), MutR = 1/Nvar;
   elseif isnan(MutR), MutR = 1/Nvar;
   elseif length(MutR) ~= 1, error('Parameter for mutation rate must be a scalar');
   elseif (MutR < 0 | MutR > 1), error('Parameter for mutation rate must be a scalar in [0, 1]'); end

   if isempty(MutShrink), MutShrink = 1;
   elseif isnan(MutShrink), MutShrink = 1;
   elseif length(MutShrink) ~= 1, error('Parameter for shrinking mutation range must be a scalar');
   elseif (MutShrink < 0 | MutShrink > 1), 
      error('Parameter for shrinking mutation range must be a scalar in [0, 1]');
   end
     
% the variables are mutated with probability MutR
% NewChrom = OldChrom (+ or -) * Range * MutShrink * Delta
% Range = 0.5 * (upperbound - lowerbound)
% Delta = Sum(Alpha_i * 2^-i) from 0 to ACCUR; Alpha_i = rand(ACCUR,1) < 1/ACCUR

% Matrix with range values for every variable
   Range = rep(0.5 * MutShrink *(FieldDR(2,:)-FieldDR(1,:)),[Nind 1]);

% zeros and ones for mutate or not this variable, together with Range
   Range = Range .* (rand(Nind,Nvar) < MutR);

% compute, if + or - sign 
   Range = Range .* (1 - 2 * (rand(Nind,Nvar) < 0.5));

% used for later computing, here only ones computed
   ACCUR = 20;
   Vect = 2 .^ (-(0:(ACCUR-1))');
   Delta = (rand(Nind,ACCUR) < 1/ACCUR) * Vect;
   Delta = rep(Delta, [1 Nvar]);

% perform mutation 
   NewChrom = OldChrom + Range .* Delta;

% Ensure variables boundaries, compare with lower and upper boundaries
   NewChrom = max(rep(FieldDR(1,:),[Nind 1]), NewChrom);
   NewChrom = min(rep(FieldDR(2,:),[Nind 1]), NewChrom);


% End of function

