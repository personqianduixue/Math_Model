function sArr = findSArray(q,d,i)
    if i == 1
        sArr = 1:cumsum(q(d,1:i,2));
    else
        start = cumsum(q(d,1:(i-1),2));
        ende = cumsum(q(d,1:i,2));
        sArr = start(end)+1:ende(end);
    end
end