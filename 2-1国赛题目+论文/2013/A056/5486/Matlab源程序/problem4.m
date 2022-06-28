% 问题4
clear;
close all;
clc;
load('problem4.mat');
disp('程序运行需要较长时间，请稍后。');
for ss = 1:50
%% 元胞自动机进行模拟 1.只区分小车和大车 2. 出现大车相当于同时出现两辆小车 3.车辆匀速
length_car = 4.8;
global length;length = floor(140/length_car);%车道单位长度
global DU TONG; DU = 0; TONG = 255;
% 建道路(255表示畅通，0表示堵塞)
global road ;
road= zeros(5,length); road(2,1) = 255;road(2,:) = 255;road(3,:) = 255;road(4,:) = 255;
road(1,:) = 0;road(5,:) = 0;
road(3,1) = 0;road(4,1) = 0;
flag = zeros(size(road));

 imshow(road);
% axis off      

% 统计上游车辆不同类型车的比例
shangyou = sum(shangyou1,1)+sum(shangyou2,1);
per_s = shangyou(1)/sum(shangyou);
per_l = shangyou(3)/sum(shangyou);

per_s = per_s/(per_s+per_l);
per_l = 1-per_s;

% 概率方面
weight = [1,2];%车型/当量
shangyou = 1500;%上游车流量
per_newcar = 1500/1800;%每一秒更新的当量数

per_sec = [0.21,0.44,0.35];% 选择车道
v1 = 2;v2 = 1;%道路分为两部分，分别的步进长度（30km/h 1m/s)。
l = 0;%更新的时候选择了大车

% 先要在路段上生成车辆，当量为12

pcu = 12;
while pcu >0
    %选择车辆,轮盘赌   
      if rand<=per_s
            pcu = pcu-1;     
            num = 1;
      else
            pcu = pcu-2;
            num = 2;
      end
    %生成坐标和车型
    while num >0
        while road(ceil(rand*3)+1,ceil(rand*length)) == DU end
        x = ceil(rand*length);
        y = ceil(rand*3);
        road(y+1,x) = DU;           
        num = num-1;
    end
end


% 每一秒钟进行车辆更新、车辆前进、车辆换道
t = 0;
while size(find(road(2,:)== 255),2)>2&&size(find(road(2,:)== 255),2)>2&&size(find(road(2,:)== 255),2)>2%三条道没有一条塞满
    %前进 
    for i = 2:4   
       for j = 2:length
            prob = 0.18*j;
            if road(i,j) == DU&&flag(i,j) == 0&&rand<prob
                if road(i,j-1) == TONG                    
                   road(i,j) = TONG; 
                   road(i,j-1) = DU;
                   flag(i,j) = 1;
                   if road(2,1) == DU
                       road(2,1) = TONG;
                   end                               
                else 
                    %换道
                    huandao(i,j);
                end
            end            
       end       
    end    
    
    
    %更新车辆  
    if mod(fix(t/30),2)
        if l==1
            l = 0;
            continue;
        end
        if rand<=per_newcar
           %更新什么车           
           if rand <=per_s
               num = 1;           
           else 
               num = 2;           
               l = 1;
           end       

           %在哪条行车道
            while num>0
               if rand<=0.44                
                    road(3,length) = DU;
               elseif rand<=0.44+0.35
                    road(4,length) = DU;
               else
                    road(2,length) = DU;
               end
               num = num-1;
            end
        end    
    end
    t = t+1;
    cal(t) = calline(road);
    %imshow(road);
% % %     set(gcf,'units','normalized','position',[0,0,1,0.9]);       
    %pause(0.1);       
    flag = zeros(size(flag));    
end
log(ss) = t;
plot(cal);
grid on;
legend('队长随时间的变化（单位车长）');
end
t = mean(log)/60