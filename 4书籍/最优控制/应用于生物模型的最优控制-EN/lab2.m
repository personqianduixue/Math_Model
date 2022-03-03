close

flag1=0;
flag2=0;
flag3=0;
flag4=0;
    
while(flag1==0)    
    var1 = input('Enter a value for the growth rate r: ');
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
    var1 = input('Enter a value for the carrying capacity M: ');
    if(var1 > 0)
        M = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: M must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('            ')
while(flag1==0)    
    var1 = input('Enter a value for the weight parameter A: ');
    if(var1 > 0)
        A = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: A must be non-negative.')
        disp('         ')
    end
end
flag1=0;
disp('            ');
while(flag1==0)    
    var1 = input('Enter a value for the initial population x_0: ');
    if(var1 > 0)
        x0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: x_0 must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)
    var1 = input('How many days would you like to run this system: ');
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
y1=code2(r,M,A,x0,T);
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
            disp('2. M')
            disp('3. A')
            disp('4. x_0')
            disp('5. T')
            var3 = input('Type 1 - 5: ');
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
                y2=code2(r2,M,A,x0,T);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second M value: ');
                    if(var4 > 0)
                        M2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: M must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code2(r,M2,A,x0,T);
                flag3=1;
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second A value: ');
                    if(var4 >= 0)
                        A2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: A must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code2(r,M,A2,x0,T);
                flag3=1; 
            elseif(var3==4)
                disp('        ')
                while(flag4==0)
                   var4=input('Enter a second x_0 value: ');
                   if(var4 > 0)
                       x02 = var4;
                       flag4 = 1;
                   else
                       disp('      ')
                       disp('ERROR: x_0 must be positive.')
                       disp('        ')
                   end
                end
                disp('            ')
                disp('One moment please...')
                y2=code2(r,M,A,x02,T);
                flag3=1;
            elseif(var3==5)
                disp('        ')
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
                y2=code2(r,M,A,x0,T2);
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
            subplot(2,1,1);plot(y1(1,:),y1(2,:))
            subplot(2,1,1);xlabel('Time')
            subplot(2,1,1);ylabel('Mold')
            subplot(2,1,2);plot(y1(1,:),y1(3,:))
            subplot(2,1,2);xlabel('Time')
            subplot(2,1,2);ylabel('Fungicide')
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)
    subplot(2,1,1);plot(y1(1,:),y1(2,:),'b',y2(1,:),y2(2,:),'g')
    subplot(2,1,1);xlabel('Time')
    subplot(2,1,1);ylabel('Mold')
    subplot(2,1,1);legend('First value','Second value',0)
    subplot(2,1,2);plot(y1(1,:),y1(3,:),'b',y2(1,:),y2(3,:),'g')
    subplot(2,1,2);xlabel('Time')
    subplot(2,1,2);ylabel('Fungicide')
    subplot(2,1,2);legend('First value','Second value',0)
end