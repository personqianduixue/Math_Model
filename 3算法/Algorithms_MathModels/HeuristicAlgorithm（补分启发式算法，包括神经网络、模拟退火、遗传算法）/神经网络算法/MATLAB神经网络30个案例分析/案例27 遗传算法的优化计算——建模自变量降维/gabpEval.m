function[sol,val]=gabpEval(sol,options)
global s
for i=1:s
x(i)=sol(i);
end;
[W1,B1,W2,B2,val]=gadecod(x);
