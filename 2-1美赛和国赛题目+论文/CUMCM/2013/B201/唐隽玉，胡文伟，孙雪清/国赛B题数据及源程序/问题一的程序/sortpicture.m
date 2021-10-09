org=bound{1};ord=[1];
while length(ord)<19
    pfh1=10000;pfh2=10000;
    [raw,col]=size(org);
    for i=2:19
        temp1=bound{i};
        p1=sum(abs(org(:,col)-temp1(:,1)));%right
        if p1<pfh1
            pfh1=p1;
            cn1=i;
        end
    end
    for j=2:19
        temp2=bound{j};
        p2=sum(abs(org(:,1)-temp2(:,2)));   %left     
        if p2<pfh2
            pfh2=p2;
            cn2=j;
        end
    end
    if p1<=p2
        org=[org,bound{cn1}];ord=[ord,cn1];
    end
    if p1>p2
        org=[bound{cn2},org];ord=[cn2,ord];
    end
end
ord-1