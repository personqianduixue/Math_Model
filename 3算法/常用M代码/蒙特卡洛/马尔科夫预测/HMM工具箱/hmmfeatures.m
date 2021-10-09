function y=hmmfeatures(s,N,deltaN,M,Q)
Ns=length(s);
T=1+fix((Ns-N)/deltaN);
a=zeros(Q,1);
gamma=zeros(Q,1);
gamma_w=zeros(Q,T);
win_gamma=1+(Q/2)*sin(pi/Q*(1:Q)');
for (t=1:T)
    idx=(deltaN*(t-1)+1):(deltaN*(t-1)+N);
    sw=s(idx).*hamming(N);
    [rs,eta]=xcorr(sw,M,'biased');
    %[a(1:M),xi,kappa]=durbin(rs(M+1:2*M+1),M);
     %[a,g]= lpc(rs(M+1:2*M+1),M);
   a=levinson(rs(M+1:2*M+1),M);
    %%
    a=a(2:M+1)';
    gamma(1)=a(1);
     for (i=2:Q)
         gamma(i)=a(i)+(1:i-1)*(gamma(1:i-1).*a(i-1:-1:1))/i;
     end
     gamma_w(:,t)=gamma.*win_gamma;
end
%%%%%%%
detla_gamma_w=gradient(gamma_w);
%%%%%%%ÌØÕ÷ÏòÁ¿
y=[gamma_w;detla_gamma_w];
         
         
         
         
         
         