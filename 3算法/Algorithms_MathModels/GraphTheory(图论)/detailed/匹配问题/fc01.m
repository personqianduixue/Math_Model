function [ e s ] = fc01(a,flag)

if nargin == 1
    flag = 0;
end
b = a;
if flag == 0
    cmax = max(max(b)');
    b = cmax - b;
end

m = size(b);
for i = 1:m(1)
    b(i,:) = b(i,:)-min(b(i,:));
end
for j = 1:m(1)
    b(:,j)=b(:,j)-min(b(:,j));
end
d=(b==0);
[e total] = fc02(d);
while total ~= m(1)
    b = fc03(b,e);
    d=(b==0);
    [e,total]=fc02(d);
end
inx = sub2ind(size(a),e(:,1),e(:,2));
e = [e,a(inx)];
s = sum(a(inx));
end

