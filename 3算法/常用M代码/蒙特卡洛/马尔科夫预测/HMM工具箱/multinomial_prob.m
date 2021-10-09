function B = eval_pdf_cond_multinomial(data, obsmat)
% EVAL_PDF_COND_MULTINOMIAL Evaluate pdf of conditional multinomial 
% function B = eval_pdf_cond_multinomial(data, obsmat)
%
% Notation: Y = observation (O values), Q = conditioning variable (K values)
%
% Inputs:
% data(t) = t'th observation - must be an integer in {1,2,...,K}: cannot be 0!
% obsmat(i,o) = Pr(Y(t)=o | Q(t)=i)
%
% Output:
% B(i,t) = Pr(y(t) | Q(t)=i)

[Q O] = size(obsmat);
T = prod(size(data)); % length(data);
B = zeros(Q,T);

for t=1:T
  B(:,t) = obsmat(:, data(t));
end
