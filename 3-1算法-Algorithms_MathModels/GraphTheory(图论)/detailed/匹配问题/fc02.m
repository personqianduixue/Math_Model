function [ e,total ] = fc02(d)

total = 0;m = size(d);
e = zeros(m(1),2);
t = sum(sum(d)');
nump = sum(d');
while t~=0
    [s inp]=sort(nump);
    inq = find(s);
    ep = inp(inq(1));
    inp = find(d(ep,:));
    numq = sum(d(:,inp));
    [s,inq]=sort(numq);
    eq = inp(inq(1));
    total = total + 1;
    e(total,:)=[ep,eq];
    inp = find(d(:,eq));
    nump(inp)=nump(inp)-1;
    nump(ep)=0;
    t = t- sum(d(ep,:))-sum(d(:,eq))+1;
    d(ep,:)=0*d(ep,:);
    d(:,eq)=0*d(:,eq);
end

end

