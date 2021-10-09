function [obs, hidden] = dhmm_sample_endstate(startprob, transmat, obsmat, endprob, numex)
% SAMPLE_DHMM Generate random sequences from an HMM with discrete outputs.
% function [obs, hidden] = sample_dhmm_endstate(startprob, transmat, obsmat, endprob, numex)
%
% We sample until we have have entered the end state
% obs{m} and hidden{m} are the m'th sequence

hidden = cell(1,numex);
obs = cell(1,numex);

for m=1:numex
  hidden{m} = mc_sample_endstate(startprob, transmat, endprob);
  T = length(hidden{m});
  obs{m} = zeros(1,T);
  for t=1:T
    h = hidden{m}(t);
    obs{m}(t) = sample_discrete(obsmat(h,:));
  end
end
