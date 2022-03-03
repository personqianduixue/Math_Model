close

flag1=0;
flag2=0;
flag3=0;
flag4=0;
    
while(flag1==0)    
    var1 = input('Enter a value for the population growth rate r: ');
    if(var1 > 0)
        r = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: r must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for the carrying capacity K: ');
    if(var1 > 0)
        K = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: K must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('            ')
while(flag1==0)    
    var1 = input('Enter the proportion of park boundary connected with the forest (m_p): ');
    if((var1 > 0)&(var1 <= 1))
        mp = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: m_p must be positive and less than or equal to 1.')
        disp('         ')
    end
end
flag1=0;
disp('           ')
while(flag1==0)    
    var1 = input('Enter the proportion of forest boundary connected with the park (m_f): ');
    if((var1 > 0)&(var1 <= 1))
        mf = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: m_f must be positive and less than or equal to 1.')
        disp('         ')
    end
end
flag1=0;
disp('              ')
while(flag1==0)    
    var1 = input('Enter a value for the initial bear population density in the park (P_0): ');
    if(var1 >= 0)
        P0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: P_0 must be non-negative.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for the initial bear population density in the forest (F_0): ');
    if(var1 >= 0)
        F0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: F_0 must be non-negative.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for the initial bear population density in the outside region (O_0): ');
    if(var1 >= 0)
        O0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: O_0 must be non-negative.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for the weight parameter c_p: ');
    if(var1 > 0)
        cp = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: c_p must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for the weight parameter c_f: ');
    if(var1 > 0)
        cf = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: c_f must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)
    var1 = input('How many years would you like to run this system: ');
    if(var1>0)
        T=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: T must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('              ')
disp('One moment please...')
y1=code9(r,K,mp,mf,P0,F0,O0,cp,cf,T);
disp('               ')

while(flag2==0)
    disp('Would you like to vary any parameters?')
    disp('1. Yes')
    disp('2. No')
    var2=input('Type 1 or 2: ');
            
    if(var2==1)
        disp('         ')
        flag2=1;
        while(flag3==0)
            disp('Which parameter would you like to vary?')
            disp('1. r')
            disp('2. K')
            disp('3. m_p')
            disp('4. m_f')
            disp('5. P_0')
            disp('6. F_0')
            disp('7. O_0')
            disp('8. c_p')
            disp('9. c_f')
            disp('10. T')
            var3 = input('Type 1 - 10: ');
            if(var3==1)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second r value: ');
                    if(var4 > 0)
                        r2 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: r must be positive.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code9(r2,K,mp,mf,P0,F0,O0,cp,cf,T);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second K value: ');
                    if(var4 > 0)
                        K2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: K must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code9(r,K2,mp,mf,P0,F0,O0,cp,cf,T);
                flag3=1;
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second m_p value: ');
                    if((var4>0)&(var4<=1))
                        mp2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: m_p must be positive and less than or equal to 1.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code9(r,K,mp2,mf,P0,F0,O0,cp,cf,T);
                flag3=1; 
            elseif(var3==4)
                disp('        ')
                while(flag4==0)
                   var4=input('Enter a second m_f value: ');
                   if((var4>0)&(var4<=1))
                       mf2 = var4;
                       flag4 = 1;
                   else
                       disp('      ')
                       disp('ERROR: m_f must be positive and less than or equal to 1.')
                       disp('        ')
                   end
                end
                disp('            ')
                disp('One moment please...')
                y2=code9(r,K,mp,mf2,P0,F0,O0,cp,cf,T);
                flag3=1;
            elseif(var3==5)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second P_0 value: ');
                    if(var4 >= 0)
                        P02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: P_0 must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code9(r,K,mp,mf,P02,F0,O0,cp,cf,T);
                flag3=1;
            elseif(var3==6)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second F_0 value: ');
                    if(var4 >= 0)
                        F02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: F_0 must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code9(r,K,mp,mf,P0,F02,O0,cp,cf,T);
                flag3=1;
            elseif(var3==7)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second O_0 value: ');
                    if(var4 >= 0)
                        O02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: O_0 must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code9(r,K,mp,mf,P0,F0,O02,cp,cf,T);
                flag3=1;
            elseif(var3==8)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second c_p value: ');
                    if(var4 > 0)
                        cp2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: c_p must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code9(r,K,mp,mf,P0,F0,O0,cp2,cf,T);
                flag3=1;
            elseif(var3==9)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second c_f value: ');
                    if(var4 > 0)
                        cf2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: c_f must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code9(r,K,mp,mf,P0,F0,O0,cp,cf2,T);
                flag3=1;
            elseif(var3==10)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second T value: ');
                    if(var4 > 0)
                        T2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: T must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code9(r,K,mp,mf,P0,F0,O0,cp,cf,T2);
                flag3=1;
            else
                disp('         ')
                disp('Pardon?')
                disp('           ')
            end
        end
            
    elseif(var2==2)
            disp('            ')
            flag2=1;           
            subplot(3,2,1);plot(y1(1,:),y1(2,:))
            subplot(3,2,1);xlabel('Time')
            subplot(3,2,1);ylabel('Park Concentration')
            subplot(3,2,2);plot(y1(1,:),y1(5,:))
            subplot(3,2,2);xlabel('Time')
            subplot(3,2,2);ylabel('Park Harvesting Rate')
            subplot(3,2,3);plot(y1(1,:),y1(3,:))
            subplot(3,2,3);xlabel('Time')
            subplot(3,2,3);ylabel('Forest Concentration')
            subplot(3,2,4);plot(y1(1,:),y1(6,:))
            subplot(3,2,4);xlabel('Time')
            subplot(3,2,4);ylabel('Forest Harvesting Rate')
            subplot(3,2,5);plot(y1(1,:),y1(4,:))
            subplot(3,2,5);xlabel('Time')
            subplot(3,2,5);ylabel('Outside Concentration')
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)
    subplot(3,2,1);plot(y1(1,:),y1(2,:),'b',y2(1,:),y2(2,:),'g')
    subplot(3,2,1);xlabel('Time')
    subplot(3,2,1);ylabel('Park Concentration')
    subplot(3,2,1);legend('First value','Second value',0)
    subplot(3,2,2);plot(y1(1,:),y1(5,:),'b',y2(1,:),y2(5,:),'g')
    subplot(3,2,2);xlabel('Time')
    subplot(3,2,2);ylabel('Park Harvesting Rate')
    subplot(3,2,2);legend('First value','Second value',0)
    subplot(3,2,3);plot(y1(1,:),y1(3,:),'b',y2(1,:),y2(3,:),'g')
    subplot(3,2,3);xlabel('Time')
    subplot(3,2,3);ylabel('Forest Concentration')
    subplot(3,2,3);legend('First value','Second value',0)
    subplot(3,2,4);plot(y1(1,:),y1(6,:),'b',y2(1,:),y2(6,:),'g')
    subplot(3,2,4);xlabel('Time')
    subplot(3,2,4);ylabel('Forest Harvesting Rate')
    subplot(3,2,4);legend('First value','Second value',0)
    subplot(3,2,5);plot(y1(1,:),y1(4,:),'b',y2(1,:),y2(4,:),'g')
    subplot(3,2,5);xlabel('Time')
    subplot(3,2,5);ylabel('Outside Concentration')
    subplot(3,2,5);legend('First value','Second value',0)
end