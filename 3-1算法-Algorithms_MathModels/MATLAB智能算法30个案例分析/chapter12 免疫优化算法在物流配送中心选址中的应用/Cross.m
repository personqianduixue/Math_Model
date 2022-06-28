function ret=Cross(pcross,chrom,sizepop,length)
% 交叉操作
% pcorss                input  : 交叉概率
% chrom                 input  : 抗体群
% sizepop               input  : 种群规模
% length                input  : 抗体长度
% ret                   output : 交叉得到的抗体群

% 每一轮for循环中，可能会进行一次交叉操作，随机选择染色体是和交叉位置，是否进行交叉操作则由交叉概率（continue）控制
for i=1:sizepop  
    
    % 随机选择两个染色体进行交叉
    pick=rand;
    while prod(pick)==0
        pick=rand(1);
    end
    
    if pick>pcross
        continue;
    end
    
    % 找出交叉个体
    index(1)=unidrnd(sizepop);
    index(2)=unidrnd(sizepop);
    while index(2)==index(1)
        index(2)=unidrnd(sizepop);
    end
    
    % 选择交叉位置
    pos=ceil(length*rand);
    while pos==1
        pos=ceil(length*rand);
    end

    % 个体交叉
    chrom1=chrom(index(1),:);
    chrom2=chrom(index(2),:);
    
    k=chrom1(pos:length);
    chrom1(pos:length)=chrom2(pos:length);
    chrom2(pos:length)=k; 
    
    % 满足约束条件赋予新种群
    flag1=test(chrom(index(1),:));
    flag2=test(chrom(index(2),:));
    
    if flag1*flag2==1
        chrom(index(1),:)=chrom1;
        chrom(index(2),:)=chrom2;
    end
    
end

ret=chrom;
end