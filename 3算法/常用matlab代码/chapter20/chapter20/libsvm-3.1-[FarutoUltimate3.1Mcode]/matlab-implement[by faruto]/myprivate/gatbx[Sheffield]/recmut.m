% RECLIN.M       (line RECombination with MUTation features)
%
% This function performs line recombination with mutation features between
% pairs of individuals and returns the new individuals after mating.
%
% Syntax:  NewChrom = recmut(OldChrom, FieldDR, MutOpt)
%
% Input parameters:
%    OldChrom  - Matrix containing the chromosomes of the old
%                population. Each line corresponds to one individual
%    FieldDR   - Matrix describing the boundaries of each variable.
%    MutOpt    - (optional) Vector containing recombination rate and shrink value
%                MutOpt(1): MutR - number containing the recombination rate -
%                           probability for recombine a pair of parents
%                           if omitted or NaN, MutOpt(1) = 1 is assumed
%                MutOpt(2): MutShrink - (optional) number for shrinking the
%                           recombination range in the range [0 1], possibility to
%                           shrink the range of the recombination depending on,
%                           for instance actual generation.
%                           if omitted or NaN, MutOpt(2) = 1 is assumed
%
% Output parameter:
%    NewChrom - Matrix containing the chromosomes of the population
%               after mating, ready to be mutated and/or evaluated,
%               in the same format as OldChrom.

%  Author:    Hartmut Pohlheim
%  History:   27.03.94     file created

function NewChrom = recmut(OldChrom, FieldDR, MutOpt);

% Check parameter consistency
   if nargin < 2,  error('Not enough input parameter'); end

   % Identify the population size (Nind) and the number of variables (Nvar)
   [Nind,Nvar] = size(OldChrom);

   [mF, nF] = size(FieldDR);
   if mF ~= 2, error('FieldDR must be a matrix with 2 rows'); end
   if Nvar ~= nF, error('FieldDR and OldChrom disagree'); end

   if nargin < 3, MutR = 1; MutShrink = 1;
   elseif isempty(MutOpt), MutR = 1; MutShrink = 1;
   elseif isnan(MutOpt), MutR = 1; MutShrink = 1;
   else   
      if length(MutOpt) == 1, MutR = MutOpt; MutShrink = 1;
      elseif length(MutOpt) == 2, MutR = MutOpt(1); MutShrink = MutOpt(2);
      else, error(' Too many parameter in MutOpt'); end
   end

   if isempty(MutR), MutR = 1;
   elseif isnan(MutR), MutR = 1;
   elseif length(MutR) ~= 1, error('Parameter for recombination rate must be a scalar');
   elseif (MutR < 0 | MutR > 1), error('Parameter for recombination rate must be a scalar in [0, 1]'); end

   if isempty(MutShrink), MutShrink = 1;
   elseif isnan(MutShrink), MutShrink = 1;
   elseif length(MutShrink) ~= 1, error('Parameter for shrinking recombination range must be a scalar');
   elseif (MutShrink < 0 | MutShrink > 1), 
      error('Parameter for shrinking recombination range must be a scalar in [0, 1]');
   end

% Identify the number of matings
   Xops = floor(Nind/2);

% NewChrom = OldChrom (+ or -) * Range * MutShrink * Delta * ChromDiff
% - with probability 0.9, + with probability 0.1
% Range = 0.5 * (upperbound - lowerbound), given by FieldDR
% Delta = Sum(Alpha_i * 2^-i) from 0 to ACCUR; Alpha_i = rand(ACCUR,1) < 1/ACCUR
% ChromDiff = (individual1 - individual2) / Distance between individuals 

% Matrix with range values for every variable
   Range = rep(0.5 * MutShrink *(FieldDR(2,:)-FieldDR(1,:)),[Xops 1]);

% zeros and ones for recombine or not this variable, together with Range
   if MutR < 1, Range = Range .* rep((rand(Xops,1) < MutR), [1 Nvar]); end

% compute, if + or - sign 
   Range = Range .* (1 - 2 * (rand(Xops,Nvar) < 0.9));

% compute distance between mating pairs
   NormO = zeros(Xops,1);
   for irun = 1:Xops,
      NormO(irun) = max(realmin,abs(norm(OldChrom(2*irun,:)) - norm(OldChrom(2*irun-1,:))));
   end

% compute difference between variables divided by distance
   ChromDiff = zeros(Xops,Nvar);
   for irun = 1:Xops
      ChromDiff(irun,:) = diff([OldChrom(2*irun-1,:); OldChrom(2*irun,:)]) / NormO(irun);
   end

% compute delta value for all individuals
   ACCUR = 20;
   Vect = 2 .^ (-(0:(ACCUR-1))');
   Delta = (rand(Xops,ACCUR) < 1/ACCUR) * Vect;
   Delta = rep(Delta, [1 Nvar]);

% Performs recombination
   odd = 1:2:Nind-1;
   even= 2:2:Nind;

   % recombination
   NewChrom(odd,:)  = OldChrom(odd,:) + Range .* Delta .* (ChromDiff);
   NewChrom(even,:)  = OldChrom(even,:) + Range .* Delta .* (-ChromDiff);

% If the number of individuals is odd, the last individual cannot be mated
% but must be included in the new population
   if rem(Nind,2),  NewChrom(Nind,:)=OldChrom(Nind,:); end

% Ensure variables boundaries, compare with lower and upper boundaries
   NewChrom = max(rep(FieldDR(1,:),[Nind 1]), NewChrom);
   NewChrom = min(rep(FieldDR(2,:),[Nind 1]), NewChrom);


% End of function

