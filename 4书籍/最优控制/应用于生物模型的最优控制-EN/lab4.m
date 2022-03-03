close

flag1=0;
flag2=0;
flag3=0;
flag4=0;

while(flag1==0)
    var1 = input('Enter a non-negative value for the weight parameter A: ');
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
disp('        ')
C = input('Enter a value for the weight parameter C: ');
disp('          ')
while(flag1==0)
    var1 = input('Enter the initial condition of the state (x_0): ');
    if(var1>-2)
        flag1 = 1;
        x0 = var1;
    else
        disp('         ')
        disp('ERROR: x_0 must be greater than -2.')
        disp('           ')
    end
end
flag1 = 0;
disp('           ')
M1 = input('Enter a value for the lower bound M_1: ');
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the upper bound M_2: ');
    if(var1 >= M1)
        flag1 = 1;
        M2 = var1;
    else
        disp('         ')
        disp('ERROR: M_2 must be greater than or equal to M_1.')
        disp('           ')
    end
end
disp('             ')
disp('One moment please...')
y1=code4(A,C,x0,M1,M2);
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
            disp('1. A')
            disp('2. C')
            disp('3. x_0')
            disp('4. M_1')
            disp('5. M_2')
            var3=input('Type 1, 2, 3, 4, or 5: ');
            if(var3==1)
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
                y2=code4(A2,C,x0,M1,M2);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                C2 = input('Enter a second C value: ');
                disp('            ')
                disp('One moment please...')
                y2=code4(A,C2,x0,M1,M2);
                flag3=1; 
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second x_0 value: ');
                    if(var4 > -2)
                        x02 = var4;
                        flag4 = 1;
                    else
                        disp('        ')
                        disp('ERROR: x_0 must be greater than -2.')
                        disp('          ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code4(A,C,x02,M1,M2);
                flag3=1;     
            elseif(var3==4)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second M_1 value: ');
                    if(var4 <= M2)
                        M12 = var4;
                        flag4 = 1;
                    else
                        disp('        ')
                        disp('ERROR: M_1 must be less than or equal to M_2.')
                        disp('          ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code4(A,C,x0,M12,M2);
                flag3=1;         
            elseif(var3==5)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second M_2 value: ');
                    if(var4 >= M1)
                        M22 = var4;
                        flag4 = 1;
                    else
                        disp('        ')
                        disp('ERROR: M_2 must be greater than or equal to M_1.')
                        disp('          ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code4(A,C,x0,M1,M22);
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
            subplot(3,1,1);plot(y1(1,:),y1(2,:))
            subplot(3,1,1);xlabel('Time')
            subplot(3,1,1);ylabel('State')
            subplot(3,1,2);plot(y1(1,:),y1(3,:))
            subplot(3,1,2);xlabel('Time')
            subplot(3,1,2);ylabel('Adjoint')
            subplot(3,1,3);plot(y1(1,:),y1(4,:))
            subplot(3,1,3);xlabel('Time')
            subplot(3,1,3);ylabel('Control')
                
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)         
    subplot(3,1,1);plot(y1(1,:),y1(2,:),'b-',y2(1,:),y2(2,:),'g-')
    subplot(3,1,1);xlabel('Time')
    subplot(3,1,1);ylabel('State')
    subplot(3,1,1);legend('First value','Second value',0)
    subplot(3,1,2);plot(y1(1,:),y1(3,:),'b-',y2(1,:),y2(3,:),'g-')
    subplot(3,1,2);xlabel('Time')
    subplot(3,1,2);ylabel('Adjoint')
    subplot(3,1,2);legend('First value','Second value',0)
    subplot(3,1,3);plot(y1(1,:),y1(4,:),'b-',y2(1,:),y2(4,:),'g-')
    subplot(3,1,3);xlabel('Time')
    subplot(3,1,3);ylabel('Control')
    subplot(3,1,3);legend('First value','Second value',0)
end