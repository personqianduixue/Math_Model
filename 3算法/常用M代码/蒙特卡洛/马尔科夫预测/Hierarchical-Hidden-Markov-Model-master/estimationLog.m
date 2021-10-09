function [PI_new A_new B_new] = estimationLog(q, xi, chi, gamma_in, gamma_out, seq, B, alph)


[prodY prodX] = find(q(:,:,1)==1 & q(:,:,2)==0);
[allY allX] = find(q(:,:,1)==1);
PI_new = -Inf(size(q,2),size(q,2),size(q,1)-1);
A_new = -Inf(size(q,2),size(q,2),size(q,1)-1);
B_new = -Inf(size(B));


%% Vertical Transitions
sArray = findSArray(q,1,1);
for i = sArray(1):sArray(end-1)
    summ = NaN;
    for k = sArray(1):sArray(end-1)
        summ = logSum(summ, chi(1,2,k));
    end
    PI_new(1,i,1)  = logProd(chi(1,2,i),-summ);
end
for d = 3:max(allY)
    for i = 1:max(allX)
        if q(d,i,1)==1
            parent = find(cumsum(q(d-1,:,2))>=i,1);
            jArray = findJArray(q,d,i);
            jArray = jArray(1):jArray(end-1);
            summOben = NaN;
            for t = 1:length(seq)
                summOben = logSum(summOben, chi(t,d,i));
            end
            summUnten = NaN;
            for m = jArray
                summ = NaN;
                for t = 1:length(seq)
                    summ = logSum(summ, chi(t,d,m));
                end
                summUnten = logSum(summUnten, summ);
            end
            PI_new(parent,i,d-1) = logProd(summOben, -summUnten);
        end
    end
end

%% Horizontal Transitions
for d = 2:max(allY)
    for i = 1:max(allX)
        if q(d,i,1)==1
            jArray = findJArray(q,d,i);
            for j = jArray
                oben = NaN;
                for t = 1:length(seq)
                    oben = logSum(oben, xi(t,d,i,d,j));
                end
                
                unten = NaN;
                for t = 1:length(seq)
                    unten = logSum(unten, gamma_out(t,d,i));
                end
                A_new(i,j,d-1) = logProd(oben,-unten);
                if isinf(A_new(i,j,d-1))
                    A_new(i,j,d-1) = log(eps);
                end
            end
        end
    end
end

%% Emissions
for v = alph
    for d = 2:max(prodY)
        for i = 1:max(prodX)
            if q(d,i,2)==0 && q(d,i,1)==1
                d1 = NaN;
                for n = 1:length(seq)
                    if seq(n)==v
                        d1 = logSum(d1, chi(n,d,i));
                    end
                end
                d2 = NaN;
                for n = 2:length(seq)
                    if seq(n)==v
                        d2 = logSum(d2, gamma_in(n,d,i));
                    end
                end

                d3 = NaN;
                for n = 1:length(seq)
                    d3 = logSum(d3, chi(n,d,i));
                end
                d4 = NaN;
                for n = 2:length(seq)
                    d4 = logSum(d4, gamma_in(n,d,i));
                end
                x1 = logSum(d1,d2);
                x2 = logSum(d3,d4);
                B_new(d,i,v) = logProd(x1,-x2);
            end
        end
    end
end

%% Normierung
A_new = exp(A_new);
PI_new = exp(PI_new);
B_new = exp(B_new);


end
