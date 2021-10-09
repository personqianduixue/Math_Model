function jArr = findJArray(q,d,i)
    jArr = find(q(d,:,1)==2);
    preJ = find(jArr<i);
    if isempty(preJ)==1 
        preJ(1) = 0; 
        postJ= find(jArr>=i,1);
        jArr = (preJ(end))+1:jArr(postJ);
    else
        postJ= find(jArr>=i,1);
        jArr = jArr(preJ(end))+1:jArr(postJ);
    end
end