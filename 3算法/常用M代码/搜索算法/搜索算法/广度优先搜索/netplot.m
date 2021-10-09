%函数名netplot
%使用方法输入请help netplot
%无返回值
%函数只能处理无向图
%作者：tiandsp
%最后修改：2012.12.26
function netplot(A,flag)
    %调用方法输入netplot(A,flag)，无返回值
    %A为邻接矩阵或关联矩阵
    %flag=1时处理邻接矩阵
    %flag=2时处理关联矩阵
    %函数只能处理无向图
    if flag==1      %邻接矩阵表示无向图
        ND_netplot(A);
        return;
    end
    
    if flag==2      %关联矩阵表示无向图
        [m n]=size(A);      %关联矩阵变邻接矩阵
        W=zeros(m,m);
        for i=1:n
            a=find(A(:,i)~=0);
            W(a(1),a(2))=1;
            W(a(2),a(1))=1;
        end
        ND_netplot(W);
        return;
    end
           
    function ND_netplot(A)
        [n n]=size(A);
        w=floor(sqrt(n));       
        h=floor(n/w);        
        x=[];
        y=[];
        for i=1:h           %使产生的随机点有其范围，使显示分布的更广
            for j=1:w
                x=[x 10*rand(1)+(j-1)*10];
                y=[y 10*rand(1)+(i-1)*10];
            end
        end
        ed=n-h*w;
        for i=1:ed
           x=[x 10*rand(1)+(i-1)*10]; 
           y=[y 10*rand(1)+h*10];
        end
        plot(x,y,'r*');    
        
        title('网络拓扑图'); 
        for i=1:n
            for j=i:n
                if A(i,j)~=0
                    c=num2str(A(i,j));                      %将A中的权值转化为字符型              
                    text((x(i)+x(j))/2,(y(i)+y(j))/2,c,'Fontsize',10);  %显示边的权值
                    line([x(i) x(j)],[y(i) y(j)]);      %连线
                end
                text(x(i),y(i),num2str(i),'Fontsize',14,'color','r');   %显示点的序号            
                hold on;
            end
        end  
    end
    
end