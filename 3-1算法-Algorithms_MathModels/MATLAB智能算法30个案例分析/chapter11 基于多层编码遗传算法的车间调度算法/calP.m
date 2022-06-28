function P=calp(S,PNumber)

% 功能说明：          根据基因S,计算调度工序P
% 输入参数：
%        S           为基因  
%        PNumber     为工件个数 
% 输出参数: 
%        P           为输出的调度工序 
%                    比如数字1002表示工件10的工序03

WNumber=length(S);%工序总个数
WNumber=WNumber/2;

%取工序基因，取基因的一半
S=S(1,1:WNumber);

%初始化
temp=zeros(1,PNumber);
P=zeros(1,WNumber);

%解码生成调度工序
for i=1: WNumber 
    
   %工序加+1
  temp(S(i))=temp(S(i))+1; 
  
  P(i)=S(i)*100+temp(S(i));
  
end


