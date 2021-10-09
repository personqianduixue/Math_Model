clear;
results=0;
M=50 ;  % 独立仿真次数，建议50次
his=zeros((M+2),1);

for i=1:M
    his(i)=PSO();
    results = results+ his(i);
end
avg= results/M  
Std=std(his(1:M))
his=[his',avg,Std]
