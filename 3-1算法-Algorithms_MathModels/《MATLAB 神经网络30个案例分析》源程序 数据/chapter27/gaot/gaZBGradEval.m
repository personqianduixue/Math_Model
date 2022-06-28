function [nsol, val] = gaZBGradEval(sol,options)

% This evaluation function takes in a potential solution and two options
% options(3) is the percent of time to perform the gradient heuristic to the
% potential solution
% options(4) is the percentage of time to update the solution based on the
% outcome of the gradient heuristic
% options [currentGen maxGen eval_with_constr update_with_constr]
nsol=sol;
if (rand<options(2))
  % Perform a gradient search
  global bounds;
  [x opt]=constr('gaZBGrad',sol(1:2),[],bounds(:,1),bounds(:,2));
  % opt(8) is the objective val...
      val=-opt(8);
  if (rand<options(3))
    nsol(1:2)=x;
  end
else
  val=-gaTestEval(sol(1:2),[]);
end

