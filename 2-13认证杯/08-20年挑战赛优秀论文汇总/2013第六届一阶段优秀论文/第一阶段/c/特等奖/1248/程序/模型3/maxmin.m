function y=maxmin(p)
n=length(p);
pp=sort(p);
maxx=pp(floor(0.98*n));
minn=min(p);
for i=1:n
    if(p(i)>maxx)
        y(i)=1;
    else 
        y(i)=(p(i)-minn)/(maxx-minn);
    end
end