function [t,g]=gaodu(A) %%%按照76列一行的节点计算
H=A(:,3);
B=sort(H,'ascend');
g=B(76:76:1919)+2;

for  i=1:25
    
    t(i)=sum(A(:,3)<=g(i)-2);
end
for i=2:25
    t(25+2-i)=t(25+2-i)-t(25+1-i);
end