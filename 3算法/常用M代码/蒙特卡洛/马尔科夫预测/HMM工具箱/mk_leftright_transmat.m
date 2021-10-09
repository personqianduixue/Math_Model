function transmat = mk_leftright_transmat(Q, p)
% MK_LEFTRIGHT_TRANSMAT Q = num states, p = prob on (i,i), 1-p on (i,i+1)
% function transmat = mk_leftright_transmat(Q, p)

transmat = p*diag(ones(Q,1)) + (1-p)*diag(ones(Q-1,1),1);
transmat(Q,Q)=1;
