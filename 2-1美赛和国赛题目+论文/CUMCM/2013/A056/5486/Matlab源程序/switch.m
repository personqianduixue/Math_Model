function 
prob = 0.8;
    for i = 2:4
       for j = 2:length
          if flag(i,j)==1&&rand<=prob&&flag1(i,j) == 0
             if rand>0.5 
                 if road(i-1,j) == TONG
                    road(i,j) = TONG;
                    road(i-1,j) = DU;
                    flag1(i-1,j) = 1;
                 elseif road(i+1,j) == TONG
                    road(i,j) = TONG;
                    road(i+1,j) = DU;    
                    flag1(i+1,j) = 1;
                 end
                
             else
                 if road(i+1,j) == TONG
                    road(i,j) = TONG;
                    road(i+1,j) = DU; 
                    flag1(i+1,j) = 1;
                 elseif road(i-1,j) == TONG
                    road(i,j) = TONG;
                    road(i-1,j) = DU;    
                    flag1(i-1,j) = 1;
                 end             
             end 
             flag(i,j) = 0;
          end
       end
    end