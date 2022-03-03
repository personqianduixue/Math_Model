close

flag1=0;
flag2=0;
flag3=0;
flag4=0;

while(flag1==0)
    var1 = input('Enter a value for the growth rate r: ');
    if(var1>0)
        flag1 = 1;
        r = var1;
    else
        disp('         ')
        disp('ERROR: r must be positive.')
        disp('         ')
    end
end
flag1 = 0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the chemical strength A: ');
    if(var1>=0)
        flag1 = 1;
        A = var1;
    else
        disp('         ')
        disp('ERROR: A must be non-negative.')
        disp('         ')
    end
end
flag1 = 0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the by-product strength B: ');
    if(var1>=0)
        flag1 = 1;
        B = var1;
    else
        disp('         ')
        disp('ERROR: B must be non-negative.')
        disp('         ')
    end
end
flag1 = 0;
disp('        ')
while(flag1==0)
    var1 = input('Enter a positive value for the weight parameter C: ');
    if(var1>=0)
        flag1 = 1;
        C = var1;
    else
        disp('         ')
        disp('ERROR: C must be non-negative.')
        disp('         ')
    end
end
flag1 = 0;
disp('        ')
while(flag1==0)
    var1 = input('Enter the initial bacteria concentration (x_0): ');
    if(var1>0)
        flag1 = 1;
        x0 = var1;
    else
        disp('         ')
        disp('ERROR: x_0 must be positive.')
        disp('           ')
    end
end
disp('           ')
disp('One moment please...')
y1=code3(r,A,B,C,x0);

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
            disp('2. A')
            disp('3. B')
            disp('4. C')
            disp('5. x_0')
            var3=input('Type 1, 2, 3, 4, or 5: ');
            if(var3==1)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second r value: ');
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
                y2=code3(r2,A,B,C,x0);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second A value: ');
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
                y2=code3(r,A2,B,C,x0);
                flag3=1;
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second B value: ');
                    if(var4 >= 0)
                        B2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: B must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code3(r,A,B2,C,x0);
                flag3=1;
            elseif(var3==4)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second C value: ');
                    if(var4 > 0)
                        C2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: C must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code3(r,A,B,C2,x0);
                flag3=1;    
            elseif(var3==5)
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
                y2=code3(r,A,B,C,x02);
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
            subplot(2,1,1);ylabel('Bacteria')
            subplot(2,1,2);plot(y1(1,:),y1(3,:))
            subplot(2,1,2);xlabel('Time')
            subplot(2,1,2);ylabel('Chemical Agent')
                
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)         
    subplot(2,1,1);plot(y1(1,:),y1(2,:),'b-',y2(1,:),y2(2,:),'g-')
    subplot(2,1,1);xlabel('Time')
    subplot(2,1,1);ylabel('Bacteria')
    subplot(2,1,1);legend('First value','Second value',0)
    subplot(2,1,2);plot(y1(1,:),y1(3,:),'b-',y2(1,:),y2(3,:),'g-')
    subplot(2,1,2);xlabel('Time')
    subplot(2,1,2);ylabel('Chemical Agent')
    subplot(2,1,2);legend('First value','Second value',0)
end