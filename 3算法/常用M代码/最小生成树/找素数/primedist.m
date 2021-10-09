clear all

i = input('How many interations?\n');
a = zeros(i,i);
a(1,1) = 1;
for n = 2:i
    a(n,1) = a(n-1,1)+n;
end
for v = 1:i
    for u = 2:i
        a(v,u) = a(v,u-1)+(u+v-2);
    end
end
p = zeros(i,i);
for v = 1:i
    for u = 1:i
        p(v,u) = isprime(a(v,u));
    end
end

numprimes = 0;
for v = 1:i
    for u = 1:i
        if p(v,u) == 1
            numprimes = numprimes+1;
        end
    end
end

x = zeros(1,numprimes);
y = zeros(1,numprimes);
pos = 1;
for v = 1:i
    for u = 1:i
        if p(v,u) == 1
            x(1,pos) = u;
            y(1,pos) = v;
            pos = pos+1;
        end
    end
end

upper = 0;
lower = 0;
for v = 1:i
    for u = 1:i
        if p(v,u) == 1
            if v/u >= 1
                lower = lower+1;
            end
            if v/u <= 1
                upper = upper+1;
            end
        end
    end
end

upper/lower
upper-lower

scatter(x,y,3,'blue','filled')
