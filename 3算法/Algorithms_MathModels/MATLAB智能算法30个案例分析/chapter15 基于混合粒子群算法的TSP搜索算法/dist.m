function dist=dist(x,D)
n=size(x,2);
dist=0;
for i=1:n-1
    dist=dist+D(x(i),x(i+1));
end
dist=dist+D(x(1),x(n));
    