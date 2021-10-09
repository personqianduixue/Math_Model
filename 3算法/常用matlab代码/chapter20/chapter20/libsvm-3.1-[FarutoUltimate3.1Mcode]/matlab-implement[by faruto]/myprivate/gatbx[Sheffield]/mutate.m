% MUTATE.M       (MUTATion high-level function)
%
% This function takes a matrix OldChrom containing the 
% representation of the individuals in the current population,
% mutates the individuals and returns the resulting population.
%
% The function handles multiple populations and calls the low-level
% mutation function for the actual mutation process.
%
% Syntax:  NewChrom = mutate(MUT_F, OldChrom, FieldDR, MutOpt, SUBPOP)
%
% Input parameter:
%    MUT_F     - String containing the name of the mutation function
%    OldChrom  - Matrix containing the chromosomes of the old
%                population. Each line corresponds to one individual.
%    FieldDR   - Matrix describing the boundaries of each variable 
%                (real-values) or defining the base of the variables of 
%                each individual (discrete values).
%                optional for (binary) discrete values
%    MutOpt    - (optional) Vector containing mutation rate and shrink value
%                if omitted or NaN, MutOpt = NaN is assumed
%                MutOpt(1): MutR - number containing the mutation rate -
%                           probability for mutation of a variable
%                MutOpt(2): MutShrink - (optional) number for shrinking the
%                           mutation range in the range [0, 1], possibility to
%                           shrink the range of the mutation depending on,
%                           for instance actual generation (only for
%                           real-values).
%    SUBPOP    - (optional) Number of subpopulations
%                if omitted or NaN, 1 subpopulation is assumed
%
% Output parameter:
%    NewChrom  - Matrix containing the chromosomes of the population
%                after mutation in the same format as OldChrom.

% Author:     Hartmut Pohlheim
% History:    19.03.94     file created

function NewChrom = mutate(MUT_F, OldChrom, FieldDR, MutOpt, SUBPOP);

% Check parameter consistency
   if nargin < 2,  error('Not enough input parameter'); end

   % Identify the population size (Nind) and the number of variables (Nvar)
   [Nind,Nvar] = size(OldChrom);

   if nargin < 3, IsDiscret = 1; FieldDR = [];
   elseif isempty(FieldDR), IsDiscret = 1; FieldDR = [];
   elseif isnan(FieldDR), IsDiscret = 1; FieldDR = [];
   else 
      [mF, nF] = size(FieldDR);
      if nF ~= Nvar, error('FieldDR and OldChrom disagree'); end
      if mF == 2, IsDiscret = 0;
      elseif mF == 1, IsDiscret = 1;
      else error('FieldDR must be a matrix with 1 or 2 rows'); end
   end

   if nargin < 4, MutOpt = NaN; end

   if nargin < 5, SUBPOP = 1;
   elseif nargin > 4,
      if isempty(SUBPOP), SUBPOP = 1;
      elseif isnan(SUBPOP), SUBPOP = 1;
      elseif length(SUBPOP) ~= 1, error('SUBPOP must be a scalar'); end
   end

   if (Nind/SUBPOP) ~= fix(Nind/SUBPOP), error('OldChrom and SUBPOP disagree'); end
   Nind = Nind/SUBPOP;  % Compute number of individuals per subpopulation

% Select individuals of one subpopulation and call low level function
   NewChrom = [];
   for irun = 1:SUBPOP,
      ChromSub = OldChrom((irun-1)*Nind+1:irun*Nind,:);  
      if IsDiscret == 1, NewChromSub = feval(MUT_F, ChromSub, MutOpt, FieldDR);
      elseif IsDiscret == 0, NewChromSub = feval(MUT_F, ChromSub, FieldDR, MutOpt); end
      NewChrom=[NewChrom; NewChromSub];
   end


% End of function

