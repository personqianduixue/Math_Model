function [ eta_in eta_out ] = expectationEtaLog( a, pi, q, alpha, beta, seq )

% Indizes aller states
[allY allX] = find(q(:,:,1)==1);

eta_in = -Inf(length(seq),size(q,1),size(q,2));
eta_out = -Inf(length(seq),size(q,1),size(q,2));

%% Eta_in
sArray = findSArray(q,1,1);
for i = sArray(1):sArray(end-1)
    for t = 1:length(seq)
        if t==1
            eta_in(t,2,i) = pi(1,i,1);
        else
            summ = NaN;
            jArray = findJArray(q,2,i);
            for j = jArray
                pro = logProd(alpha(1,t-1,2,j),a(j,i,1));
                summ = logSum(summ,pro);
            end
            eta_in(t,2,i) = summ;
        end
    end
end


for d = 3:max(allY)
	for i = 1:max(allX)
        if q(d,i,1)==1
            parent = find(cumsum(q(d-1,:,2))>=i,1);
            jArray = findJArray(q,d,i);
            for t = 1:length(seq)
                if t==1
                    eta_in(t,d,i) = logProd(eta_in(t,d-1,parent),pi(parent,i,d-1));
                else
                    outerSumm = NaN;
                    for ttick = 1:(t-1)
                        summ = NaN;
                        for j = jArray%(1:end-1)
                            pro = logProd(alpha(ttick,t-1,d,j),a(j,i,d-1));
                            summ = logSum(summ,pro);
                        end
                        outerSumm = logSum(outerSumm,logProd(summ,eta_in(ttick,d-1,parent)));
                    end
                    eta_in(t,d,i) = logSum(outerSumm,logProd(eta_in(t,d-1,parent),pi(parent,i,d-1)));
                end
            end
        end
    end
end

%% Eta_out
sArray = findSArray(q,1,1);
for i = sArray(1):sArray(end-1)
    for t = length(seq):-1:1
        if t==length(seq)
            ende = sArray(end);
            eta_out(t,2,i) = a(i,ende,1);
        else
            summ = NaN;
            jArray = findJArray(q,2,i);
            for j = jArray
                prod = logProd(beta(t+1,length(seq),2,j),a(i,j,1));
                summ = logSum(summ,prod);
            end
            eta_out(t,2,i) = summ;
        end
    end
end

for d = 3:max(allY)
	for i = 1:max(allX)
        if q(d,i,1)==1
            parent = find(cumsum(q(d-1,:,2))>=i,1);
            jArray = findJArray(q,d,i);
            e = find(q(d,i:end,1)==2,1) + i-1;
            for t = length(seq):-1:1
                if t==length(seq)
                    eta_out(t,d,i) = logProd(eta_out(t,d-1,parent),a(i,e,d-1));
                else
                    outerSumm = NaN;
                    for k = (t+1):length(seq)
                        summ = NaN;
                        for j = jArray
                            pro = logProd(beta(t+1,k,d,j),a(i,j,d-1));
                            summ = logSum(summ,pro);
                        end
                        outerSumm = logSum(outerSumm,logProd(summ,eta_out(k,d-1,parent)));
                    end
                    eta_out(t,d,i) = logSum(outerSumm,logProd(eta_out(t,d-1,parent),a(i,e,d-1)));
                end
            end
        end
    end
end


end
