function ChromNew=aberranceJm(Chrom,MUTR,Jm,T)

%初始化
[NIND,WNumber]=size(Chrom);
WNumber=WNumber/2;

ChromNew=Chrom;

[PNumber MNumber]=size(Jm);
Number=zeros(1,PNumber);
for i=1:PNumber
  Number(i)=1;
end

for i=1:NIND    
                
    %取一个个体
    S=Chrom(i,:);
            
       WPNumberTemp=Number; 
        
       for j=1:WNumber
           
          JMTemp=Jm{S(j), WPNumberTemp(S(j))};
          SizeTemp=length(JMTemp);
          
            %是否变异
          if MUTR>rand;
              
%               选择机器（随机选择）
%                S(j+WNumber)=unidrnd(SizeTemp); 
          
                %选择机器（ 加工时间少的选择几率大）
                if SizeTemp==1      
                       S(j+WNumber)=1;
                else
                    S(j+WNumber)=selectJm(S(j++WNumber),T{S(j),WPNumberTemp(S(j))});
                end
          end
          
            WPNumberTemp(S(j))=WPNumberTemp(S(j))+1;
        end         
   
  
    %数据放入新群
    ChromNew(i,:)=S;
end
