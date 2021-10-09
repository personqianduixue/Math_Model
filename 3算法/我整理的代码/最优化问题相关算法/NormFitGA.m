function [xv,fv]=NormFitGA(fitness,a,b,NP,NG,ksi0,c,Pc,Pm,eps)
%待优化的目标函数：fitness
%自变量下界：a
%自变量上界：b
%种群个体数：NP
%最大进化代数：NG
%选择压力调节值的初始值：q
%选择压力调节值的收缩系数：c
%杂交概率：Pc
%变异概率：Pm
%自变量离散精度：eps
%目标函数取最小值时的自变量值：xm
%目标函数的最小值：f

L=ceil(log2((b-a)/eps+1));          %根据离散精度，确定二进制编码需要的码长
x=zeros(NP,L);
for i=1:NP
    x(i,:)=Initial(L);                  %种群初始化
    fx(i)=fitness(Dec(a,b,x(i,:),L));   %个性适应值
end
ksi=ksi0;                               %选择压力调节值的初始值
for k=1:NG
    fmin=min(fx);                       %群体适应值的最小值
    Normfx=fx-fmin*ones(size(fx))+ksi;  %适应值变换
    sumfx=sum(Normfx);                  %所有个体适应值之和
    Px=Normfx/sumfx;                    %所有个体适应值的平均值
    PPx=0;
    PPx(1)=Px(1);
    for i=2:NP
        PPx(i)=PPx(i-1)+Px(i);          %用轮盘赌策略概率累加
    end
    for i=1:NP
        sita=rand();
        for n=1:NP
            if sita<=PPx(n)
                SelFather=n;            %根据轮盘赌策略确定的父亲
                break;
            end
        end
        Selmother=floor(rand()*(NP-1))+1;   %随机选择母亲
        posCut=floor(rand()*(L-2))+1;       %随机确定交叉点
        r1=rand();
        if r1<=Pc                           %交叉
            nx(i,1:posCut)=x(SelFather,1:posCut);
            nx(i,(posCut+1):L)=x(Selmother,(posCut+1):L);
            r2=rand();
            if r2<=Pm
                posMut=round(rand()*(L-1)+1);
                nx(i,posMut)=~nx(i,posMut);
            end
        else
            nx(i,:)=x(SelFather,:);
        end
    end
    x=nx;
    for i=1:NP
        fx(i)=fitness(Dec(a,b,x(i,:),L));
    end
    ksi=ksi*c;                          %选择压力调节值的收缩
end
fv=-inf;
for i=1:NP
    fitx=fitness(Dec(a,b,x(i,:),L));
    if fitx>fv
        fv=fitx;                        %取个体中的最好值作为最终结果
        xv=Dec(a,b,x(i,:),L);
    end
end
function result=Initial(length)         %初始化函数
for i=1:length
    r=rand();
    result(i)=round(r);
end
function y=Dec(a,b,x,L)                 %二进制编码转换为十进制编码
base=2.^((L-1):-1:0);
y=dot(base,x);
y=a+y*(b-a)/(2^L-1);