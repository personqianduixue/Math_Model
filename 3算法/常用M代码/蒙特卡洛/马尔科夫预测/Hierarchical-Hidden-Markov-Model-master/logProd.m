function d = logProd(a, b)
	if (isnan(a)) || (isnan(b))
        d = NaN;
    else
        d = a+b;
    end
    if a==-inf && b==-inf
        d = -inf;
    end
end