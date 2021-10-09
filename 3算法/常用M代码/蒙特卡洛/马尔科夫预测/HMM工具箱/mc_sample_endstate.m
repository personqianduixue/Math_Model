function S = sample_mc_endstate(startprob, trans, endprob)
% SAMPLE_MC_ENDSTATE Generate a random sequence from a Markov chain until enter the endstate.
% seq = sample_mc(startprob, trans, endprob)

% add an end state
Q = size(trans,1);
transprob = zeros(Q,Q+1);
end_state = Q+1;
for i=1:Q
  for j=1:Q
    transprob(i,j) = (1-endprob(i)) * trans(i,j);
  end
  transprob(i,end_state) = endprob(i);
  %assert(approxeq(sum(transprob(i,:)), 1))
end                  

S = [];
S(1) = sample_discrete(startprob);
t = 1;
p = endprob(S(t));
stop = (S(1) == end_state);
while ~stop
  S(t+1) = sample_discrete(transprob(S(t),:));
  stop = (S(t+1) == end_state);
  t = t + 1;
end
S = S(1:end-1); % don't include end state
