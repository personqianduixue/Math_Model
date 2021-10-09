function fval=fGAPLP(x)
% options is required by the format of GAOT ver 5.

fval=1; dfo=0;
r=25;

n=6;lamdao=1e30;
for i=1:(n-1)
    for j=(i+1):n
        rtmp=sqrt((x(i)-x(j)).^2+(x(n+i)-x(n+j)).^2);
        if rtmp > 2*r
             fval=fval*rtmp;
             dfo=dfo+1;
        end
    end
end
fval=fval-dfo*lamdao;