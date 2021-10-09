function b = fc03(b,e)
m = size(b);t = 1;
p = ones(m(1),1);
q = zeros(m(1),1);
inp = e(:,1)~=0;
p(e(inp,1))=0;
while t~=0
    tp = sum(p+q);
    inp = find(p==1);
    n = size(inp);
    for i=1:n(1)
        inq = b(inp(i),:)==0;
        q(inq)=1;
    end
    inp = find(q==1);
    n = size(inp);
    for i = 1:n(1)
        if all(e(:,2)-inp(i))==0
            inq = find((e(:,2)-inp(i))==0);
            p(e(inq))=1;
        end
    end
    tq = sum(p+q);
    t = tq-tp;
end
inp = find(p==1);
inq = find(q==0);
cmin = min(min(b(inp,inq))');
inq = find(q==1);
b(inp,:)=b(inp,:)-cmin;
b(:,inq)=b(:,inq)+cmin;
end