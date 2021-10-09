function [ xi chi gamma_in gamma_out ] = expectationXiChiLog(a, pi, q, eta_in, eta_out, alpha, beta, seq)

POlambda = log(sum(exp(alpha(1,length(seq),2,:,1,1))));
[allY allX] = find(q(:,:,1)==1);

xi = -Inf(length(seq),size(q,1),size(q,2)-1,size(q,1),size(q,2));
chi = -Inf(length(seq),size(q,1),size(q,2)-1);
gamma_in = chi;
gamma_out= chi;

%% Xi
for t = 1:length(seq);
    sArray = findSArray(q,1,1);
    for i = sArray(1:end-1)
        jArray = findJArray(q,2,i);
        for k = jArray(1:end-1)
            if t==length(seq)
                temp = logProd(alpha(1,t,2,i),a(i,jArray(end),1));
                xi(t,2,i,2,jArray(end)) = logProd(temp, -POlambda);
            else
                temp = logProd(alpha(1,t,2,i),beta(t+1,length(seq),2,k));
                temp = logProd(temp,a(i,k,1));
                xi(t,2,i,2,k) = logProd(temp, -POlambda);
            end
        end
    end
end


for t = 1:(length(seq))
    for d = 3:max(allY)
    	for i = 1:max(allX)
            if q(d,i,1)==1
                parent = find(cumsum(q(d-1,:,2))>=i,1);
                jArray = findJArray(q,d,i);
                for j = jArray
                    if j == jArray(end)
                        summ = NaN;
                        for s = 1:t
                            pro = logProd(eta_in(s,d-1,parent),alpha(s,t,d,i));
                            summ = logSum(summ,pro);
                        end
                        temp = logProd(summ, a(i,j,d-1));
                        temp = logProd(temp, eta_out(t,d-1,parent));
                        xi(t,d,i,d,j) = logProd(temp, -POlambda);
                    else
                        if t ~= length(seq)
                            summ1 = NaN;
                            for s = 1:t
                                pro1 = logProd(eta_in(s,d-1,parent), alpha(s,t,d,i));
                                summ1 = logSum(summ1,pro1);
                            end

                            summ2 = NaN;
                            for e = (t+1):length(seq)
                                pro2 = logProd(eta_out(e,d-1,parent), beta(t+1,e,d,j));
                                summ2 = logSum(summ2,pro2);
                            end

                            temp = logProd(summ1,summ2);
                            temp = logProd(temp, a(i,j,d-1));
                            xi(t,d,i,d,j) = logProd(temp, -POlambda);
                        end
                    end
                end
            end
        end
    end
end



%% Chi
sArray = findSArray(q,1,1);
for i = sArray(1):sArray(end-1);
    temp = logProd(pi(1,i,1), beta(1,length(seq),2,i));
    chi(1,2,i) = logProd(temp, -POlambda);
end

for t=1:length(seq)
    for d = 3:max(allY)
    	for i = 1:max(allX)
            if q(d,i,1)==1
                parent = find(cumsum(q(d-1,:,2))>=i,1);
                
                summ = NaN;
                for m = t:length(seq)
                    pro = logProd(beta(t,m,d,i), eta_out(m,d-1,parent));
                    summ = logSum(summ,pro);
                end
                
                temp = logProd(summ, eta_in(t,d-1,parent));
                temp = logProd(temp, pi(parent,i,d-1));
                chi(t,d,i) = logProd(temp, -POlambda);
            end
        end
    end
end



%% Gamma
for d = 2:max(allY)
    for i = 1:max(allX)
        if q(d,i,1)==1
            jArray = findJArray(q,d,i);
            for t = 2:length(seq)
                summ = NaN;
                for k = jArray(1:end-1)
                    summ = logSum(summ, xi(t-1,d,k,d,i));
                end
                gamma_in(t,d,i) = summ;
            end
        end
    end
end

for d = 2:max(allY)
    for i = 1:max(allX)
        if q(d,i,1)==1
            jArray = findJArray(q,d,i);
            for t = 1:(length(seq))
                summ = NaN;
                for k = jArray
                    summ = logSum(summ, xi(t,d,i,d,k));
                end
                gamma_out(t,d,i)= summ;
            end
        end
    end
end


end
    