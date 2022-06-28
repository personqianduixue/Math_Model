%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%Nagel-Schreckenberg模型的改进形式%%%%%%%%%%%%%%%%
%%%%输入step，也就是时间，输出车辆流的性态与最后车流长度变化%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [count,queue]=lengthplot(step,pa,in)
    %road_length = 48;  
    road_length = 16;                        %道路总长度
    road = zeros(3,road_length);             %车辆速度矩阵，有车辆处矩阵数值大于0，为车辆速度，无车辆处矩阵数值小于0
    %estate_in = 92;
    right_in = 180-75;
    pa = pa/3600;
    queuemax = 0;
    count = 0;
    for i=2:3
        road(i,1) = 7;                       %事故位置，二，三车道设置为不畅通
    end
    
    road_next = road;                        %新建车辆位置矩阵
    for t=1:step
       time(t)=t;                            %时间，用于作排队长度-时间图用

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%判断是否通过事故截面%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%在一车道最前位置的车辆以0.4的概率1s内通过事故截面%%%%%%%%%
%%%%%%%%%%%在第二车道最前位置的车有0.1的机会改道到一车道%%%%%%%%%%
%%%%%%%%%%%在第三车道最前位置的车有0.1的机会改道到二车道%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       pass = rand(1);

       if(pass<pa)
           road_next(1,2)=0;
           if(rand(1)>0.9)&&(road_next(2,2)>0)
               road_next(1,2)=1;            %改道后速度为1，以下相同
               road_next(2,2)=0;
           elseif (rand(1)>0.8)&&(road_next(3,2)>0)&&(road_next(2,2)==0)
               road_next(2,2)=1;
               road_next(3,2)=0;
           end
       end
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%车辆的加速与减速%%%%%%%%%%%%%%%%%%%%%%%%%
%%在碰撞到其他车辆前，司机选择减速至j-k(相差距离)或者某个固定值2%%%
%%%%%如果在道路一快要到达队首，司机会加速冲过事故或者减速慢行%%%%%%
%%%如果在一段路内没有碰到其他人，司机选择加速通过，直至速度达到4%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       for j=3:road_length 
           for i=1:3
           if(road_next(i,j)>0)
           if(j-road_next(i,j)<2)           %如果车速足够通过无障碍下的事故结点
              note = true;                  %note查看是否会撞到其他车辆
              for  k=j-1:-1:2 
                  if(road_next(i,k)>0)
                     road_next(i,j)=0; 
                     if(rand(1)>0.9)
                     road_next(i,k+1)=j-k;  %减速到(j-k)*5 m/s的车辆
                      else
                     road_next(i,k+1)=min(j-k,1);    
                      end
                     note = false;
                     break;
                  end
              end
              if ((note)&&(i==1))           %如果是第一道，可以冲过去或减速慢行
                  pass = rand(1);
                  if(pass>0.5)
                  road_next(i,j)=0;
                  else
                  road_next(i,j)=0;
                  road_next(i,2)=1;   
                  end
              elseif ((note)&&(i>1))        %如果是第二，三道，只能到达道的队首，等待改道
                  road_next(i,j)=0;
                  road_next(i,2)=1;
              end
           else
               note = true;                 %note查看是否会撞到其他车辆
               for k=j-1:-1:j-road_next(i,j)
                   if road_next(i,k)>0
                       road_next(i,j)=0;
                       road_next(i,k+1)=j-k;
                       note = false;
                       break;
                   end
               end
               if(note)                    %未撞到其他车辆，选择加速，加速到4则不变
                   if(road_next(i,j)<4)
                       road_next(i,j-road_next(i,j)) = road_next(i,j)+1;
                   else
                       road_next(i,j-road_next(i,j)) = road_next(i,j);
                   end
                   road_next(i,j)=0;
               end
           end
           end
           end
       end
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%车辆的随机改道%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%由于通行速度不同或其他原因，司机会选择车辆的改道%%%%%%%%
%%其中改道的概率分别是P(1,2)=.1,P(2,1)=.3,P(2,3)=.1,P(3,2)=.2%%%
%%%%%%%%%%%%%%%其中P(i,j)指从i车道改道j车道的概率%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       for j=3:road_length                
           if (road_next(1,j)>0)&&(road_next(2,j)==0)&&(road_next(1,j-1)||road_next(1,j-2)||road_next(1,max(j-3,1)))  %一道到二道
               temp = rand(1);
               if(temp>0.9)
                   road_next(2,j)=1;
                   road_next(1,j)=0;
               end
               for k=j:min(j+3,road_length)
                   if(road_next(2,k)>0)
                       road_next(2,k)=min(road_next(2,k),1);
                   end
               end
           end
           
           if (road_next(2,j)>0)&&(road_next(1,j)==0)&&(road_next(2,j-1)||road_next(2,j-2)||road_next(2,max(j-3,1)))  %二道到一道
               temp = rand(1);
               if(temp>0.85)
                   road_next(1,j)=1;
                   road_next(2,j)=0;
               end
               for k=j:min(j+3,road_length)
                   if(road_next(1,k)>0)
                       road_next(1,k)=min(road_next(1,k),1);
                   end
               end
           end
           
           if (road_next(2,j)>0)&&(road_next(3,j)==0)&&(road_next(2,j-1)||road_next(2,j-2)||road_next(2,max(j-3,1)))  %二道到三道
               temp = rand(1);
               if(temp>0.9)
                   road_next(3,j)=1;
                   road_next(2,j)=0;
               end
               for k=j:min(j+3,road_length)
                   if(road_next(3,k)>0)
                       road_next(3,k)=min(road_next(3,k),3);
                   end
               end
           end
           
           if (road_next(3,j)>0)&&(road_next(2,j)==0)&&(road_next(3,j-1)||road_next(3,j-2)||road_next(3,max(j-3,1)))  %三道到二道
               temp = rand(1);
               if(temp>0.85)
                   road_next(2,j)=1;
                   road_next(3,j)=0;
               end
               for k=j:min(j+3,road_length)
                   if(road_next(2,k)>0)
                       road_next(2,k)=min(road_next(2,k),2);
                   end
               end
           end
           
       end
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%车辆的随机变速，谨慎司机与拥堵%%%%%%%%%%%%%%%%%%
%%驾驶中，车辆可能处于各种原因变速，这里车辆每秒可能加1，也可能减1%%
%%%%%谨慎司机看到车祸现场会选择慢行，相应车速在车祸附近有所变化%%%%
%%%%%%%%%%拥堵的车道中很难改变自身速度，因而车速会减少至1%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       for j=3:road_length                          %随机变速模块
           for i=1:3
               temp=rand(1);
               if(temp>0.8)&&(temp<0.85)&&(road_next(i,j)>0)&&(road_next(i,j)<4)
                   road_next(i,j) = road_next(i,j)+1;
               elseif(temp>0.8)&&(road_next(i,j)>1)&&(road_next(i,j)<=4)
                   road_next(i,j) = road_next(i,j)-1;
               end
           end
           
           for i=1:3                              %谨慎司机
           if (j<=8)&&(road_next(i,j)>0)
              road_next(i,j)=2;
           end
           end
           
           for i=1:3                             %拥堵车流无法前行
           if (road_next(i,j-1)>0)&&(road_next(i,j)>0)
               temp = rand(1);
                road_next(i,j)=min(road_next(i,j-1),2*(temp>0.85)+1*(temp<=0.85));
           end
           end
       end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%上游来车数量%%%%%%%%%%%%%%%%%%%%%%%%%%     
%%%%%%%%假定上游来车数量是一个随机数，30s内大于0，30s小于0%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

          
          sflow = in/3600;
          %sflow = in/3600;
          v0 = 2;
         for i=1:3 
           if (road_next(i,road_length)==0)&(mod(t,60)<10)
               temp = rand(1);
               if(temp<(right_in*(i==1)/3600+sflow./3.*2)*2.1)
              road_next(i,road_length-1)=v0;
              count = count+1;
               end
           elseif (road_next(i,road_length)==0)&(mod(t,60)<20)&(mod(t,60)>=10)
               temp = rand(1);
               if(temp<(right_in*(i==1)/3600+sflow./3.*2)*0.45)
              road_next(i,road_length)=v0;
              count = count+1;
               end
           elseif (road_next(i,road_length)==0)&(mod(t,60)<30)&(mod(t,60)>=20)
               temp = rand(1);
               if(temp<(right_in*(i==1)/3600+sflow./3.*2)*0.45)
              road_next(i,road_length)=v0;
              count = count+1;
               end
           end
         end  
       if(road_next(1,road_length)==0)&(mod(t,60)>=30)
               temp = rand(1);
               if(temp<right_in/3600)
              road_next(1,road_length)=v0;
              count = count+1;
               end
       end
            
       
       
       %temp = rand(1);
       %if(road_next(1,20)==0)&(temp<estate_in/3600)
       %    road_next(1,20) = 2;
       %end
    
       road = road_next;
       
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%作出流量图像%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       %imagesc(road_next);
       %title(['t=',num2str(t)]);
       %drawnow
       %pause(0.001)
       %f=getframe;
       %f=frame2im(f);
       %[X,map]=rgb2ind(f,256);
       %if t==1
       %     imwrite(X,map,'ex_imwrite.gif','DelayTime',0.1);
       %else
       %     imwrite(X,map,'ex_imwrite.gif','WriteMode','Append','DelayTime',0.1);
       %end
       
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%作出排队长度-时间关系图%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       for i=1:3
          length(i)=0;
        for j=2:road_length 
           if(road_next(i,j)>0)
            length(i) = length(i)+1;
           else
            break;
           end
        end
       end
       queue(t)=4*sum(length);
    
    %plot(time,queue)
    %ylabel('排队汽车长度(m)')
    %xlabel('事故持续时间(s)')
end