function [Xnext,Ynext]=AF_prey(Xi,ii,visual,step,try_number,LBUB,lastY)
%觅食行为
%输入：
%Xi          当前人工鱼的位置
%ii          当前人工鱼的序号
%visual      感知范围
%step        最大移动步长
%try_number  最大尝试次数
%LBUB        各个数的上下限
%lastY       上次的各人工鱼位置的食物浓度

%输出：
%Xnext       Xi人工鱼的下一个位置  
%Ynext       Xi人工鱼的下一个位置的食物浓度

Xnext=[];
Yi=lastY(ii);
for i=1:try_number
    Xj=Xi+(2*rand(length(Xi),1)-1)*visual;
    Yj=AF_foodconsistence(Xj);
    if Yi<Yj
        Xnext=Xi+rand*step*(Xj-Xi)/norm(Xj-Xi);
        for i=1:length(Xnext)
            if  Xnext(i)>LBUB(i,2)
                Xnext(i)=LBUB(i,2);
            end
            if  Xnext(i)<LBUB(i,1)
                Xnext(i)=LBUB(i,1);
            end
        end
        Xi=Xnext;
        break;
    end
end

%随机行为
if isempty(Xnext)
    Xj=Xi+(2*rand(length(Xi),1)-1)*visual;
    Xnext=Xj;
    for i=1:length(Xnext)
        if  Xnext(i)>LBUB(i,2)
            Xnext(i)=LBUB(i,2);
        end
        if  Xnext(i)<LBUB(i,1)
            Xnext(i)=LBUB(i,1);
        end
    end
end
Ynext=AF_foodconsistence(Xnext);
