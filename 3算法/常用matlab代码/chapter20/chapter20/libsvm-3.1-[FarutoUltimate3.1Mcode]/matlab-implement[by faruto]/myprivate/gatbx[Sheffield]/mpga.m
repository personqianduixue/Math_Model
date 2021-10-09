% mpga         multi population genetic algorithm
%
% This script implements the Multi Population Genetic Algorithm.
% A real-valued representation of the individuals is used.
%

% Author:     Andrew Chipperfield
% History:    30-Mar-94     file created

NVAR = 20;		% No. of decision variables (control steps)
RANGE = [0;200];	% Bounds on decision variables

% Set field descriptor
   FieldD = rep(RANGE,[1,NVAR]);

% Define GA Parameters
   GGAP = .8;		% Generation gap, how many new individuals are created
   XOVR =  1;		% Crossover rate
   MUTR = 1/NVAR;	% Mutation rate depending on NVAR
   MAXGEN = 1200;	% Maximum number of generations
   TERMEXACT = 1e-4;    % Value for termination if minimum reached
   INSR = .9;		% Insertion rate, how many of the offspring are inserted
   SUBPOP = 8;		% Number of subpopulations
   MIGR = 0.2;		% Migration rate between subpopulations
   MIGGEN = 20;		% Number of generations between migration
   NIND = 20;		% Number of individuals per subpopulation

% Specify other routines as strings
   SEL_F = 'sus';       % Name of selection function
   XOV_F = 'recdis';    % Name of recombination function for individuals
   MUT_F = 'mutbga';    % Name of mutation function
   OBJ_F = 'objharv';   % Name of function for objective values


% Get value of minimum, defined in objective function
   GlobalMin = feval(OBJ_F,[],3);

% Get title of objective function, defined in objective function
   FigTitle = [feval(OBJ_F,[],2) '   (' int2str(SUBPOP) ':' int2str(MAXGEN) ') '];

% Clear Best  and storing matrix
   % Initialise Matrix for storing best results
      Best = NaN * ones(MAXGEN,3);
      Best(:,3) = zeros(size(Best,1),1);
   % Matrix for storing best individuals
      IndAll = [];

% Create real population
   Chrom = crtrp(SUBPOP*NIND,FieldD);

% reset count variables
   gen = 0;

% Calculate objective function for population
   ObjV = feval(OBJ_F,Chrom);
   % count number of objective function evaluations
   Best(gen+1,3) = Best(gen+1,3) + NIND;

% Generational loop
   while gen < MAXGEN,

   % Save the best and average objective values and the best individual
      [Best(gen+1,1),ix] = min(ObjV);
      Best(gen+1,2) = mean(ObjV);
      IndAll = [IndAll; Chrom(ix,:)];

   % Fitness assignment to whole population
      FitnV = ranking(ObjV,2 ,SUBPOP);
            
   % Select individuals from population
      SelCh = select(SEL_F, Chrom, FitnV, GGAP, SUBPOP);
      
   % Recombine selected individuals
      SelCh=recombin(XOV_F, SelCh, XOVR, SUBPOP);

   % Mutate offspring
      SelCh=mutate(MUT_F, SelCh, FieldD, [MUTR], SUBPOP);

   % Calculate objective function for offsprings
      ObjVOff = feval(OBJ_F,SelCh);
      Best(gen+1,3) = Best(gen+1,3) + size(SelCh,1);

   % Insert best offspring in population replacing worst parents
      [Chrom, ObjV] = reins(Chrom, SelCh, SUBPOP, [1 INSR], ObjV, ObjVOff);

      gen=gen+1;

   % Plot some results, rename title of figure for graphic output
      if ((rem(gen,20) == 1) | (rem(gen,MAXGEN) == 0)),
         set(gcf,'Name',[FigTitle ' in ' int2str(gen)]);
         resplot(Chrom(1:2:size(Chrom,1),:),...
                 IndAll(max(1,gen-39):size(IndAll,1),:),...
                 [ObjV; GlobalMin], Best(max(1,gen-19):gen,[1 2]), gen);
      end


   % migrate individuals between subpopulations
      if (rem(gen,MIGGEN) == 0)
         [Chrom, ObjV] = migrate(Chrom, SUBPOP, [MIGR, 1, 0], ObjV);
      end

   end


% Results
   % add number of objective function evaluations
   Results = cumsum(Best(1:gen,3));
   % number of function evaluation, mean and best results
   Results = [Results Best(1:gen,2) Best(1:gen,1)];
   
% Plot Results and show best individuals => optimum
   figure('Name',['Results of ' FigTitle]);
   subplot(2,1,1), plot(Results(:,1),Results(:,2),'-',Results(:,1),Results(:,3),':');
   subplot(2,1,2), plot(IndAll(gen-4:gen,:)');
 

% End of script

