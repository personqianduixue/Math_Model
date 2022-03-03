close

flag1=0;
flag2=0;
flag3=0;
flag4=0;
flag5=0;

while(flag1==0)
    var1 = input('Enter an initial timber production level (x_0): ');
    if(var1>0)
        flag1=1;
        x0=var1;
    else
        disp('           ')
        disp('ERROR: x_0 must be positive.')
        disp('            ')
    end    
end
disp('           ')
flag1=0;
while(flag1==0)
    var1 = input('Enter a value for the return constant k: ');
    if(var1>0)
        flag1=1;
        k=var1;
    else
        disp('       ')
        disp('ERROR: k must be positive.')
        disp('       ')
    end
end
disp('      ')
flag1=0;
while(flag1==0)
    var1 = input('Enter a value for the interest rate r: ');
    if(var1>=0)
        flag1=1;
        r=var1;
    else
        disp('       ')
        disp('ERROR: r must be non-negative.')
        disp('       ')
    end
end
disp('      ')
flag1=0;
while(flag1==0)
    var1 = input('Enter a value for T: ');
    if(var1>0)
        flag1=1;
        T=var1;
    else
        disp('      ')
        disp('ERROR: T must be positive.')
        disp('        ')
    end
end
disp('           ')
disp('One moment please...')
y1=code11(x0,k,r,T);
disp('           ')

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
            disp('1. x_0')
            disp('2. k')
            disp('3. r')
            disp('4. T')
            var3=input('Type 1, 2, 3, or 4: ');
            if(var3==1)
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
                y2=code11(x02,k,r,T);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second k value: ');
                    if(var4 > 0)
                        k2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: k must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code11(x0,k2,r,T);
                flag3=1; 
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second r value: ');
                    if(var4 >= 0)
                        r2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: r must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code11(x0,k,r2,T);
                flag3=1;     
            elseif(var3==4)
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
                y2=code11(x0,k,r,T2);
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
            subplot(2,1,1);ylabel('Timber Produced')
            subplot(2,1,2);plot(y1(1,:),y1(3,:))
            subplot(2,1,2);xlabel('Time')
            subplot(2,1,2);ylabel('Reinvestment Percentage')
            axis([0 T -0.3 1.3])     
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)
    subplot(2,1,1);plot(y1(1,:),y1(2,:),'b',y2(1,:),y2(2,:),'g')
    subplot(2,1,1);legend('First value','Second value',0)
    subplot(2,1,1);xlabel('Time')
    subplot(2,1,1);ylabel('Timber Produced')
    subplot(2,1,2);plot(y1(1,:),y1(3,:),'b',y2(1,:),y2(3,:),'g')
    if(var3==4)
        subplot(2,1,2);axis([0 max(T,T2) -0.3 1.3])
    else
        subplot(2,1,2);axis([0 T -0.3 1.3])
    end
    subplot(2,1,2);xlabel('Time')
    subplot(2,1,2);ylabel('Reinvestment Percentage')    
    subplot(2,1,2);legend('First value','Second value',0)
end