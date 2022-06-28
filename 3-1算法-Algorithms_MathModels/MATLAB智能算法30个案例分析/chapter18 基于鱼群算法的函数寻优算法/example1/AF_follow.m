function [Xnext,Ynext]=AF_follow(X,i,visual,step,deta,try_number,LBUB,lastY)
% 追尾行为
%输入：
%X           所有人工鱼的位置
%i           当前人工鱼的序号
%visual      感知范围
%step        最大移动步长
%deta        拥挤度
%try_number  最大尝试次数
%LBUB        各个数的上下限
%lastY       上次的各人工鱼位置的食物浓度

%输出：
%Xnext       Xi人工鱼的下一个位置
%Ynext       Xi人工鱼的下一个位置的食物浓度
Xi=X(:,i);
D=AF_dist(Xi,X);
index=find(D>0 & D<visual);
nf=length(index);
if nf>0
    XX=X(:,index);
    YY=lastY(index);
    [Ymax,Max_index]=max(YY);
    Xmax=XX(:,Max_index);
    Yi=lastY(i);
    if Ymax/nf>deta*Yi;
        Xnext=Xi+rand*step*(Xmax-Xi)/norm(Xmax-Xi);
        for i=1:length(Xnext)
            if  Xnext(i)>LBUB(i,2)
                Xnext(i)=LBUB(i,2);
            end
            if  Xnext(i)<LBUB(i,1)
                Xnext(i)=LBUB(i,1);
            end
        end
        Ynext=AF_foodconsistence(Xnext);
    else
        [Xnext,Ynext]=AF_prey(X(:,i),i,visual,step,try_number,LBUB,lastY);
    end
else
    [Xnext,Ynext]=AF_prey(X(:,i),i,visual,step,try_number,LBUB,lastY);
end
