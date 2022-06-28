% This is a reference for writing evaluation, operator, selection and
% termination functions for the genetic optimization toolbox.

% Binary and Real-Valued Simulation Evolution for Matlab 
% Copyright (C) 1996 C.R. Houck, J.A. Joines, M.G. Kay 
%
% C.R. Houck, J.Joines, and M.Kay. A genetic algorithm for function
% optimization: A Matlab implementation. ACM Transactions on Mathmatical
% Software, Submitted 1996.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 1, or (at your option)
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. A copy of the GNU 
% General Public License can be obtained from the 
% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

echo off
done =0;
while ~done
  K = menu('Choose a topic','Evaluation','Operators','Selection',...
    'Termination','Quit');
  
  if(K==1)
    clc;
    disp('EVALUATION');
    disp(' The evaluation function is the driving force behind the GA.  The');
    disp(' evaluation function is called from the GA to determine the');
    disp(' fitness of each solution string generated during the search.  An');
    disp(' example evaluation function is given below:');
    disp(' ');
    disp(' function [x, val] = gaDemo1Eval(sol,options)');
    disp(' x=sol(1);');
    disp(' val = x + 10*sin(5*x)+7*cos(4*x);    ');
    disp(' ');
    disp(' Note that the evaluation function must take two parameters,');
    disp(' sol and options.  Sol is a row vector of n+1 elements where');
    disp(' the first n elements are the parameters of interest.  The');
    disp(' n+1th element is the value of this solution.  The options');
    disp(' matrix is a row matrix of');
    disp(' ');
    disp(' [current generation, options]');
    disp(' ');
    disp(' The eval function must return both the value of the string,');
    disp(' val and the string itself, sol.  This is done so that');
    disp(' your evaluation can repair or improve the string.');
    disp(' ');
    disp(' An evaluation function is unique to the optimization of the');
    disp(' problem at hand, therefore, every time the ga is used for a');
    disp(' different problem, an evaluation function must be developed to');
    disp(' determine the fitness of the individuals.');
  end
  if(K==2)
    clc;    
    disp('OPERATORS');
    disp(' Operators provide the search mechanism of the GA.  The');
    disp(' operators are used to create new solutions based on existing');
    disp('solutions in the population.  There are two basic types of');
    disp(' operators, crossover and mutation.  Crossover takes two');
    disp(' individuals and produces two new individuals while mutation');
    disp(' alters one individual to produce a single new solution.  The');
    disp(' ga function calls each of the operators to produce new');
    disp(' solutions.  The function call for crossovers is as follows:');
    disp('');
    disp(' function [c1,c2] =crossover(p1,p2,bounds,Ops)'); 
    disp('');
    disp('where');
    disp(' p1 is the first parent ([solution_string function_value])');
    disp(' p2 is the second parent ([solution_string function_value])');
    disp(' bounds is the bounds matrix for the solution space');        
    disp(' ops is a vector of information, i.e. ');
    disp('[current_generation crossover_ops]');
    disp(' while the mutation function call is');
    disp(' similar but only takes one parent and returns one child.');
    disp(' function [c1] = mutation(p1,bounds,Ops)');
    disp(' ');
    disp(' The crossover operator must take all 4 arguments,');
    disp(' the two parents, the bounds of the search space,');
    disp(' the information on how much of the evolution has');
    disp(' taken place and any other special options required,');
    disp(' and similarly mutations must all take the three');
    disp(' arguments and return the resulting');
    disp(' child. ');
  end
  if(K==3)
    clc;    
    disp('SELECTION')
    disp(' The selection function determines which');
    disp(' of the individuals will survive and continue');
    disp(' on to the next generation.  The ga function');
    disp(' calls the selection function each generation');
    disp(' after all the new children have been');
    disp(' evaluated to determine their fitness using');
    disp(' the user provided evaluation function.');
    disp(' ');
    disp(' The basic function call used in the ga for');
    disp(' selection is: ');
    disp(' ');
    disp(' function[newPop] = selectFunction(oldPop,options) ');
    disp(' ');
    disp(' where newPop is the new population selected, ');
    disp(' oldPop is the current population, ');
    disp(' options is a vector for any other optional parameters.');
    disp(' ');
    disp(' Notice that all selection routines must take');
    disp(' three parameters, the old population from');
    disp(' which to select members from, and any');
    disp(' specific options to that particular selection');
    disp(' routine.  The function must return the new');
    disp(' population.');
  end
  if(K==4)
    clc;
    disp('TERMINATION')
    disp(' The termination function determines when to');
    disp(' stop the simulated evolution and return the');
    disp(' resulting population.  The ga function calls');
    disp(' the termination function once every');
    disp(' generation after the application of all of');
    disp(' the operator functions and the evaluation');
    disp(' function for the resulting children.  The');
    disp(' function call is of the format:');
    disp(' ');
    disp(' done = terminateFunction(options,bestPop,pop)');
    disp(' ');
    disp(' options is a vector of termination options');
    disp(' the first of which is always the current generation');
    disp(' bestPop is a matrix of the best individuals and the respective');
    disp(' generation it was found.  ');
    disp(' pop is the current population.');
  end
  if(K==5)
    done=1;
  end
end


