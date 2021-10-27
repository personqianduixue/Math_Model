function y=sort1(data)  
%将各省数据按站点进行计算，既按Q的大小将数据排序
N=size(data);
    j=1;
    k(1)=1;
     for i=1:N-1
         if data(i,1)~=data(i+1,1)   %站名出现不同时转到下一个站点觉得统计和计算
           j=j+1;
           k(j)=i+1;
         end  
     end 
     j=j+1;
     k(j)=N(1)+1;
   for i=1:j-1          
       cdata(i).os=data(k(i):k(i+1)-1,1);   %数据统一赋值给cdata结构数组
       cdata(i).b(:,2)=data(k(i):k(i+1)-1,2);
       cdata(i).b(:,1)=data(k(i):k(i+1)-1,3); 
       p=0;
       for l=1:k(i+1)-k(i)                              %简单排序
           for c=l:k(i+1)-k(i)                     
              if cdata(i).b(l,1)>cdata(i).b(c,1)
                  p=cdata(i).b(l,:);
                  cdata(i).b(l,:)=cdata(i).b(c,:);
                  cdata(i).b(c,:)=p;
              end
           end
       end  
    if sum(cdata(i).b(:,1))~=0              %当所在站点所有年份，月份的沙尘暴天数和不为零时
       y(i,1:2)=polyfit(cdata(i).b(:,2)',cdata(i).b(:,1)',1);  %分别就各站点进行方程系数的拟合
       y(i,3)=cdata(i).os(1);
    else
       y(i,1:2)=[0 0];                         % 若天数为零，基本上不发生沙尘暴，无拟合的必要
       y(i,3)=cdata(i).os(1);
    end
   end
end

   
    