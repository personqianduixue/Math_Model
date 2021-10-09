% MIGRATE.M      (MIGRATion of individuals between subpopulations)
%
% This function performs migration of individuals.
%
% Syntax:  [Chrom, ObjV] = migrate(Chrom, SUBPOP, MigOpt, ObjV)
%
% Input parameters:
%    Chrom     - Matrix containing the individuals of the current
%                population. Each row corresponds to one individual.
%    SUBPOP    - Number of subpopulations
%    MigOpt    - (optional) Vector containing migration parameters
%                MigOpt(1): MIGR - Rate of individuals to be migrated per
%                           subpopulation (% of subpopulation)
%                           if omitted or NaN, 0.2 (20%) is assumed
%                MigOpt(2): Select - number indicating the selection method
%                           of replacing individuals
%                           0 - uniform selection
%                           1 - fitness-based selection (replace worst 
%                                  individuals)
%                           if omitted or NaN, 0 is assumed
%                MigOpt(3): Structure - number indicating the structure
%                           of the subpopulations for migration
%                           0 - net structure (unconstrained migration)
%                           1 - neighbourhood structure
%                           2 - ring structure
%                           if omitted or NaN, 0 is assumed
%    ObjV      - (optional) Column vector containing the objective values
%                of the individuals in the current population, needed for
%                fitness-based migration, this saves the
%                recalculation of objective values for population.
%
% Output parameters:
%    Chrom     - Matrix containing the individuals of the current
%                population after migration.
%    ObjV      - if ObjV is input parameter, than column vector containing
%                the objective values of the individuals of the current
%                generation after migration.
           
% Author:     Hartmut Pohlheim
% History:    16.02.94     file created
%             18.02.94     comments at the beginning added
%                          exchange of ObjV too
%             25.02.94     clean up
%             26.02.94     ObjV optional input parameter
%                          Select and Structure added, parameter reordered
%             17.03.94     renamed to migrate.m, more parameter checks

function [Chrom, ObjV] = migrate(Chrom, SUBPOP, MigOpt, ObjV);


% Check parameter consistency
   if nargin < 2, error('Input parameter SUBPOP missing'); end
   if (nargout == 2 & nargin < 4), error('Input parameter ObjV missing'); end

   [Nind, Nvar] = size(Chrom);
   if length(SUBPOP) ~= 1, error('SUBPOP must be a scalar'); end
   if SUBPOP == 1, return; end
   if (Nind/SUBPOP) ~= fix(Nind/SUBPOP), error('Chrom and SUBPOP disagree'); end
   NIND = Nind/SUBPOP;  % Compute number of individuals per subpopulation
   
   if nargin > 3, 
      [mO, nO] = size(ObjV);
      if nO ~= 1, error('ObjV must be a column vector'); end
      if Nind ~= mO, error('Chrom and ObjV disagree'); end
      IsObjV = 1;
   else IsObjV = 0; ObjV = [];
   end

   if nargin < 3, MIGR = 0.2; Select = 0; Structure = 0; end   
   if nargin > 2,
      if isempty(MigOpt), MIGR = 0.2; Select = 0; Structure = 0;
      elseif isnan(MigOpt), MIGR = 0.2; Select = 0; Structure = 0;
      else
         MIGR = NaN; Select = NaN; Structure = NaN;
         if length(MigOpt) > 3, error('Parameter MigOpt is too long'); end
         if length(MigOpt) >= 1, MIGR = MigOpt(1); end
         if length(MigOpt) >= 2, Select = MigOpt(2); end
         if length(MigOpt) >= 3, Structure = MigOpt(3); end
         if isnan(MIGR), MIGR =0.2; end
         if isnan(Select), Select = 0; end
         if isnan(Structure), Structure = 0; end
      end
   end
   
   if (MIGR < 0 | MIGR > 1), error('Parameter for migration rate must be a scalar in [0 1]'); end
   if (Select ~= 0 & Select ~= 1), error('Parameter for selection method must be 0 or 1'); end
   if (Structure < 0 | Structure > 2), error ('Parameter for structure must be 0, 1 or 2'); end
   if (Select == 1 & IsObjV == 0), error('ObjV for fitness-based migration needed');end

   if MIGR == 0, return; end
   MigTeil = max(floor(NIND * MIGR), 1);    % Number of individuals to migrate

% Perform migration between subpopulations --> create a matrix for migration
% in every subpopulation from best individuals of the other subpopulations

   % Clear storing matrices
      ChromMigAll = [];
      if IsObjV == 1, ObjVAll = []; end

   % Create matrix with best/uniform individuals of all subpopulations
      for irun = 1:SUBPOP
         % sort ObjV of actual subpopulation
            if Select == 1,              % fitness-based selection
               [Dummy, IndMigSo]=sort(ObjV((irun-1)*NIND+1:irun*NIND));
            else     % if Select == 0    % uniform selection
               [Dummy, IndMigSo]=sort(rand(NIND, 1));
            end
         % take MigTeil (best) individuals, copy individuals and objective values
            IndMigTeil=IndMigSo(1:MigTeil)+(irun-1)*NIND;
            ChromMigAll = [ChromMigAll; Chrom(IndMigTeil,:)];
            if IsObjV == 1, ObjVAll = [ObjVAll; ObjV(IndMigTeil,:)]; end
      end

   % perform migration
      for irun = 1:SUBPOP
            ChromMig = ChromMigAll;
            if IsObjV == 1, ObjVMig = ObjVAll; end
            if Structure == 1,       % neighbourhood 
               % select individuals of neighbourhood subpopulations for ChromMig and ObjVMig
               popnum = [SUBPOP 1:SUBPOP 1];
               ins1 = popnum(irun); ins2 = popnum(irun + 2);
               InsRows = [(ins1-1)*MigTeil+1:ins1*MigTeil (ins2-1)*MigTeil+1:ins2*MigTeil];
               ChromMig = ChromMig(InsRows,:);
               if IsObjV == 1, ObjVMig = ObjVMig(InsRows,:); end
            elseif Structure == 2,   % ring
               % select individuals of actual-1 subpopulation for ChromMig and ObjVMig
               popnum = [SUBPOP 1:SUBPOP 1];
               ins1 = popnum(irun);
               InsRows = (ins1-1)*MigTeil+1:ins1*MigTeil;
               ChromMig = ChromMig(InsRows,:);
               if IsObjV == 1, ObjVMig = ObjVMig(InsRows,:); end
            else                     % if Structure == 0,  % complete net
               % delete individuals of actual subpopulation from ChromMig and ObjVMig
               DelRows = (irun-1)*MigTeil+1:irun*MigTeil;
               ChromMig(DelRows,:) = [];
               if IsObjV == 1, ObjVMig(DelRows,:) = []; end
            end
         % Create an index from a sorted vector with random numbers   
            [Dummy,IndMigRa]=sort(rand(size(ChromMig,1),1));
         % Take MigTeil numbers from the random vector
            IndMigN=IndMigRa((1:MigTeil)');
         % copy MigTeil individuals into Chrom and ObjV
            Chrom((1:MigTeil)+(irun-1)*NIND,:) = ChromMig(IndMigN,:);
            if IsObjV == 1, ObjV((1:MigTeil)+(irun-1)*NIND,:) = ObjVMig(IndMigN,:); end
      end


% End of function
