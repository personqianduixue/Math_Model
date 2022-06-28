function result=comparewithreal()
    mat = zeros(1,850);
    parfor j=1:100
            [count(j),add]=automata(850,1370,0.2387*3600); 
            mat = mat+add;
    end
    mat = mat/100;
    mean(count)
    for j=1:262
        result(j)=mat(3*j);
    end
    x=1:262;
    plot(x,result);
end