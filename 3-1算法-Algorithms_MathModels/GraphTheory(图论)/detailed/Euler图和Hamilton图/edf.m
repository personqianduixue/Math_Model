function [ flag ed ] = edf(matr,eds,vexs,ed,tem)
flag = 1;
for i = 2:eds
    [dvex f]=flecvexf(matr,i,vexs,eds,ed,tem);
    if f==1;
        flag = 0;
        break;
    end
    if dvex ~= 0
        ed(:,i)=[vexs(1,i) dvex];
        vexs(1,i+1)=dvex;
        matr(vexs(1,i+1),vexs(1,i))=0;
    else
        break;
    end
end


end

