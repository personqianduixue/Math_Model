function pop = popinit(n,length)
%种群初始化函数(记忆库库为空，全部随机产生)
% n       input    种群数量
% length  input    抗体长度
% pop     output   初始种群
for i=1:n
    flag=0;
    while flag==0
        [a,b]=sort(rand(1,31));    
        pop(i,:)=b(1:length);
        flag=test(pop(i,:));
    end
end