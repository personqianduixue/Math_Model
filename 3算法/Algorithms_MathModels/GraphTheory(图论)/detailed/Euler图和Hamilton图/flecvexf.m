function [dvex f] = flecvexf(matr,i,vexs,eds,ed,temp)
f = 0;
edd = find(matr(vexs(1,i),:)==1);
dvex = 0;
dvex1 = [];
ded=[];
if length(edd) == 1
    dvex = edd;
else
    dd = 1;dd1 = 0;kkk = 0;
    for kk = 1:length(edd)
        m1 = find(vexs==edd(kk));
        if sum(m1)==0
            dvex1(dd)=edd(kk);
            dd = dd+1;
            dd1=1;
        else
            kkk=kkk+1;
        end
    end
    if kkk == length(edd)
        tem = vexs(1,i)*ones(1,kkk);
        edd1 = [tem;edd];
        for l1 = 1:kkk
            lt = 0;ddd = 1;
            for l2 = 1:eds
                if edd1(1:2,l1)==ed(1:2,l2)
                    lt = lt +1;
                end
            end
            if lt == 0
                ded(ddd)=edd(l1);
                ddd = ddd+1;
            end
        end
    end
    
    if temp <= length(dvex1)
        dvex = dvex1(temp);
    elseif temp > length(dvex1) && temp <= length(ded)
        dvex = ded(temp);
    else
        f = 1;
    end
end


end

