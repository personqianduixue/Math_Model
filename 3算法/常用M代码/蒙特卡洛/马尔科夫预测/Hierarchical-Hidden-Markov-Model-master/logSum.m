function d = logSum(a, b)
    if (isnan(a)) || (isnan(b))
        if (isnan(a))
            d = b;
        else
            d = a;
        end
    else
        if a>b
            d = a + log(1 + exp(b-a));
        else
            d = b + log(1 + exp(a-b));
        end
    end
    if a==-inf && b==-inf
        d = -inf;
    end
end