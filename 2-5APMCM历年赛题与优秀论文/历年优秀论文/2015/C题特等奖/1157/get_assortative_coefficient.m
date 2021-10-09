function r=get_assortative_coefficient(Nodes)
%get assortative coefficient,see Ref[Newman,Mixing patterns in networks]
%Input:Nodes--N*N adjacent matrix,Nodes(i,j)=1;i is outdegree,j is indegree
%Output:r--assortative coefficient
%
%Modified by Rock on 06.02.28 
%Modified by Rock on 06.12.10 for r=0
%%Modified 07.03.20 for edge_num=0
%%Modified 07.09.13 for Out/Indegree

TEST=0;

if TEST==1
    Nodes=[0,1,1;0,0,1;1,1,0];
    Nodes=[0,1,0,1;1,0,1,0;0,1,0,1;1,0,1,0];
    Nodes=sparse(Nodes);
end

N=length(Nodes);
edgeNum=nnz(Nodes);%include outEdge and inEdge,ave_degree=edgeNum/N

Outdegree=zeros(N,1);
Indegree=zeros(N,1);

%for i=1:N
%    Outdegree(i)=nnz(Nodes(i,:));
%    Indegree(i)=nnz(Nodes(:,i));
%end

Outdegree=sum(Nodes(1:end,:));
Indegree=sum(Nodes(:,1:end));

%sum1 is sum(i*j)
%sum2 is sum(i+j)
%sum3 is sum(i^2+j^2)
sum1=0;
sum2=0;
sum3=0;

[Row,Col,Weight]=find(Nodes);
Len=length(Row);

for temp=1:Len
    i=Row(temp);
    j=Col(temp);
    sum1=sum1+(Indegree(j)-1)*(Outdegree(i)-1);
    sum2=sum2+(Indegree(j)-1)+(Outdegree(i)-1);
    sum3=sum3+(Indegree(j)-1)^2+(Outdegree(i)-1)^2;    
end

%for i=1:N
%    for j=1:N
%        if Nodes(i,j)>0
%            sum1=sum1+(Indegree(j)-1)*(Outdegree(i)-1);
%            sum2=sum2+(Indegree(j)-1)+(Outdegree(i)-1);
%            sum3=sum3+(Indegree(j)-1)^2+(Outdegree(i)-1)^2;
%        end
%    end
%end

if edgeNum==0%Modified 07.03.20
    r=0;
else
    if ((sum1/edgeNum)-(sum2/(2*edgeNum))^2)*((sum3/(2*edgeNum))-(sum2/(2*edgeNum))^2)==0 %%Modified by Rock on 06.12.10 for r=0
        r=0;
    else
        r=((sum1/edgeNum)-(sum2/(2*edgeNum))^2)/((sum3/(2*edgeNum))-(sum2/(2*edgeNum))^2);
    end
end

return