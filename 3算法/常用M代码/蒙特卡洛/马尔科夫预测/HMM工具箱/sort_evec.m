function [evec, evals] = sort_evec(temp_evec, temp_evals, N)

if ~isvector(temp_evals)
  temp_evals = diag(temp_evals);
end

% Eigenvalues nearly always returned in descending order, but just
% to make sure.....
[evals perm] = sort(-temp_evals);
evals = -evals(1:N);
if evals == temp_evals(1:N)
  % Originals were in order
  evec = temp_evec(:, 1:N);
  return
else
  fprintf('sorting evec\n');
  % Need to reorder the eigenvectors
  for i=1:N
    evec(:,i) = temp_evec(:,perm(i));
  end
end

