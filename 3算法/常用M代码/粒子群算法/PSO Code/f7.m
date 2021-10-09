function f7=f7(x)

Bound=[-1.28 1.28];

if nargin==0
    f7 = Bound;
else
[row col]=size(x);
onematrix=ones(row,col);
i=cumsum(onematrix);
f7=sum(i.*x.^4)+rand(1,col);
end