function [ alpha, beta ] = expectationAlphaBetaLog( a, pi, q, b, seq )

% Indizes der production states
[prodY prodX] = find(q(:,:,1)==1 & q(:,:,2)==0);
% Indizes der internal states
[intY intX] = find(q(:,:,2)~=0);

alpha = -Inf(length(seq),length(seq),size(q,1),size(q,2));
 beta = -Inf(length(seq),length(seq),size(q,1),size(q,2));


% Alpha
for t = length(seq):-1:1
    for k = 0:(length(seq)-t)
        for d = max(prodY):-1:2
            for i = 1:max(prodX)
                if q(d,i,2)==0 && q(d,i,1)==1
                    parent = find(cumsum(q(d-1,:,2))>=i,1);
                    jArray = findJArray(q,d,i);
                    if k==0
                        alpha(t,t,d,i) = logProd(pi(parent,i,d-1), b(d,i,seq(t)));
                    else
                        summ = NaN;
                        for j = jArray(1:end-1)         % Produktionstates unter Parentknoten
                            pro = logProd(alpha(t,t+k-1,d,j), a(j,i,d-1));
                            summ = logSum(summ,pro);
                        end
                        alpha(t,t+k,d,i) = logProd(summ, b(d,i,seq(t+k)));
                    end
                end
            end
        end
        
        for d = max(intY):-1:2
            for i = 1:max(intX)
                if q(d,i,2)~=0
                    parent = find(cumsum(q(d-1,:,2))>=i,1);
                    jArray = findJArray(q,d,i);
                    sArray = findSArray(q,d,i);
                    if k==0
                        summ = NaN;
                        for s = sArray(1:end-1)
                            pro = logProd(alpha(t,t,d+1,s), a(s,sArray(end),d));
                            summ = logSum(summ,pro);
                        end
                        alpha(t,t,d,i) = logProd(summ, pi(parent,i,d-1));
                    else
                        outerSumm = NaN;
                        for l = 0:(k-1)
                            summ1 = NaN;
                            for j = jArray(1:end-1)
                                pro1 = logProd(alpha(t,t+l,d,j), a(j,i,d-1));
                                summ1 = logSum(summ1,pro1);
                            end

                            summ2 = NaN;
                            for s = sArray(1:end-1)
                                pro2 = logProd(alpha(t+l+1,t+k,d+1,s), a(s,sArray(end),d));
                                summ2 = logSum(summ2,pro2);
                            end
                            outerSumm = logSum(outerSumm,logProd(summ1,summ2));
                        end

                        summ3 = NaN;
                        for s = sArray(1:end-1);
                            pro3 = logProd(alpha(t,t+k,d+1,s), a(s,sArray(end),d));
                            summ3 = logSum(summ3,pro3);
                        end
                        alpha(t,t+k,d,i) = logSum(outerSumm,logProd(summ3,pi(parent,i,d-1)));
                    end
                end
            end
        end

%% Beta
        for d = max(prodY):-1:2
            for i = 1:max(prodX)
                if q(d,i,2)==0 && q(d,i,1)==1
                    jArray = findJArray(q,d,i);
                    jArray = jArray(1:end-1);
                    e = find(q(d,i:end,1)==2,1) + i-1;
                    if k==0
                        beta(t,t,d,i) = logProd(b(d,i,seq(t)),a(i,e,d-1));
                    else
                        summ = NaN;
                        for j = jArray
                            pro = logProd(beta(t+1,t+k,d,j),a(i,j,d-1));
                            summ = logSum(summ,pro);
                        end
                        beta(t,t+k,d,i) = logProd(summ,b(d,i,seq(t)));
                    end
                end
            end
        end
        
        for d = max(intY):-1:2
            for i = 1:max(intX)
                if q(d,i,2)~=0
                    jArray = findJArray(q,d,i);
                    sArray = findSArray(q,d,i);
                    if k==0
                        summ = NaN;
                        for s = sArray(1:end-1)
                            pro = logProd(beta(t,t,d+1,s), pi(i,s,d));
                            summ = logSum(summ,pro);
                        end
                        beta(t,t,d,i) = logProd(summ, a(i,jArray(end),d-1));
                    else
                        outerSumm = NaN;
                        for i1 = 0:k-1
                            summ1 = NaN;
                            for s = sArray(1:end-1)
                                pro1 = logProd(beta(t,t+i1,d+1,s),pi(i,s,d));
                                summ1 = logSum(summ1,pro1);
                            end

                            summ2 = NaN;
                            for j = jArray(1:end-1)
                                pro2 = logProd(beta(t+i1+1,t+k,d,j),a(i,j,d-1));
                                summ2 = logSum(summ2,pro2);
                            end
                            outerSumm = logSum(outerSumm,logProd(summ1,summ2));
                        end

                        summ3 = NaN;
                        for s = sArray(1:end-1)
                            pro3 = logProd(beta(t,t+k,d+1,s), pi(i,s,d));
                            summ3 = logSum(summ3,pro3);
                        end
                        beta(t,t+k,d,i) = logSum(outerSumm,logProd(summ3, a(i,jArray(end),d-1)));
                    end
                end
            end
        end
    end
end

end