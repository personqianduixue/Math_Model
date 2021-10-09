%GADEMO1 Introduction to the Genetic Optimization Toolbox

clf;
figure(gcf);
more on
echo on
clc
%    ==========================================================
%    GADEMO 1
%    ==========================================================

%    INITIALIZE - Initialize a poplutaton of solutions
%    GA         - Simulates evolution

pause % Strike any key for the introduction to Genetic Algorithms
clc

%    Genetic algorithms

%    A genetic algorithm is a simulation of evolution where the
%    rule of survival of the fittest is applied to a population
%    of individuals.
%    The basic genetic algorithm is as follows:
%      1. Create an initial population (usually a randomly
%         generated string)
%      2. Evaluate all of the individuals (apply some function
%         or formula to the individuals)
%      3. Select a new population from the old population based
%         on the fittness of the individuals as given by the
%         evaluation function.
%      4. Apply some genetic operators (mutation & crossover)
%         to members of the population to create new solutions.
%      5. Evaluate these newly created individuals.
%      6. Repeat steps 3-6 (one generation) until the
%         termination criteria has been satisfied (usually
%         perform for a certain fixed number of generations)
%
%    Let's look at an example

pause % Strike any key to define the problem...
clc

%   Let's consider the maximization of the following function:
%   f(x) = x + 10*sin(5*x)+7*cos(4*x) over the interval (0,9)
fplot('x + 10*sin(5*x)+7*cos(4*x)',[0 9])

%   Now, let's set up a genetic algorithm to find the maximum
%   of this problem.  First, we need to create the evaluation
%   function .m file, here is gademo1eval1.m

pause 				% Strike any key to look at gademo1eval1.m
type gademo1eval1.m
pause 					% Strike any key to continue
clc

%   Note that the evaluation function must take two parameters,
%   sol and options.  Sol is a row vector of n+1 elements where
%   the first n elements are the parameters of interest.  The
%   n+1'th element is the value of this solution.  The options
%   matrix is a row matrix of 
%   [current generation, eval options]
%   The eval function must return both the value of the sting,
%   val and the string itself, sol.  This is done so that
%   your evaluation can repair and/or improve the string.

pause 					% Strike any key to continue
clc

%   Now that we have defined the evaluation function, we now
%   have to create an initial population.  The most common way
%   to generate an initial population is to randomly generate
%   solutions within the range of interest, in this case 0-9.
%   The initialize routine will do this for you.

pause 				% Strike any key for help on initialize
clc
help initializega
pause 					% Strke any key to continue.
clc
%   Let's create a random starting popluation of size 10.
initPop=initializega(10,[0 9],'gademo1eval1');
pause 					% Strke any key to continue.

%   We can now take a look at this population.
hold on
plot (initPop(:,1),initPop(:,2),'g+')
pause % Strike any key to continue 
clc
%  We can now run the evolutionary procedure on this
%  population.
help ga
pause 					% Strike any key to continue

% Now let's run the ga for one generation.
[x endPop] = ga([0 9],'gademo1eval1',[],initPop,[1e-6 1 1],'maxGenTerm',1,...
  'normGeomSelect',[0.08],['arithXover'],[2 0],'nonUnifMutation',[2 1 3]);

x %The best found
%And plot the resulting the resulting population
plot (endPop(:,1),endPop(:,2),'ro')
pause 					% Strike any key to continue

% Now let's run the ga for 25 generations
[x endPop bpop trace] = ga([0 9],'gademo1eval1',[],initPop,[1e-6 1 1],'maxGenTerm',25,...
  'normGeomSelect',[0.08],['arithXover'],[2],'nonUnifMutation',[2 25 3]);
x %The best found
% And plot the resulting the resulting population
plot (endPop(:,1),endPop(:,2),'y*')

figure(2)
%Lets take a look at the performance of the ga during the run
plot(trace(:,1),trace(:,3),'y-')
hold on
plot(trace(:,1),trace(:,2),'r-')
xlabel('Generation'); ylabel('Fittness');
%The red line is a track of the best solution, the yellow is a track of the
%average of the population

pause %Any key to continue
% End of gademo1