function transmat = mk_rightleft_transmat(Q, p)
% MK_RIGHTLEFT_TRANSMAT Q = num states, p = prob on (i,i), 1-p on (i,i+1)
% function transmat = mk_rightleft_transmat(Q, p)

transmat = p*diag(ones(Q,1)) + (1-p)*diag(ones(Q-1,1),-1);
transmat(1,1)=1;
