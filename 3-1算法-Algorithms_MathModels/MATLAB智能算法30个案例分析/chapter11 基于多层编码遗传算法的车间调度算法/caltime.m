function PVal=caltime(S,P,JmNumber,T,Jm)

% 功能说明：    根据调度工序,计算出调度工序时间
% 输入参数：
%        P     为调度工序  
%        JmNumber    为机器个数
%        T     为各工件各工序的加工时间 
%        Jm    为各工件各工序使用的机器 
% 输出参数:
%        PVal  为调度工序开始加工时间及完成时间


%  工件个数 工序个数 
[PNumber MNumber]=size(Jm);

%取机器基因，取基因的一半
 M=S(1,PNumber*MNumber+1:PNumber*MNumber*2); 
 
%工序总个数
WNumber=length(P);

%初始化
TM=zeros(1,JmNumber);
TP=zeros(1,PNumber);
PVal=zeros(2,WNumber);

%计算调度工序时间
for i=1: WNumber 
    
    % 取机器号
    val= P(1,i);
    a=(mod(val,100)); %工序
    b=((val-a)/100);  %工件
    Temp=Jm{b,a};
    m=Temp(M(1,i));
    
    %取加工时间
    Temp=T{b,a};
    t=Temp(M(1,i));
    
    %取机器加工本工序的开始时间和前面一道工序的完成时间
    TMval=TM(1,m);
    TPval=TP(1,b); 
    
    %机器加工本工序的开始时间 大于前面一道工序的完成时 ，取机器加工本工序的开始时间
    if TMval>TPval 
        val=TMval;
     %取前面一道工序的完成时间  
    else
        val=TPval;
    end
    
    %计算时间
    PVal(1,i)=val;
    PVal(2,i)=val+t;
    
    %记录本次工序的机器时间和工序时间
    TM(1,m)=PVal(2,i);
    TP(1,b)=PVal(2,i); 
end

