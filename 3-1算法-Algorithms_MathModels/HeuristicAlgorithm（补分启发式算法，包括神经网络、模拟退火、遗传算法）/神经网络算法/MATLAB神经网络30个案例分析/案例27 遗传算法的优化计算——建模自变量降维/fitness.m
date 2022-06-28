function [sol,Val]=fitness(sol,options)
global S
for i=1:S
    x(i)=sol(i);
end
Val=de_code(x);
end