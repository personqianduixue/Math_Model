close

flag1=0;
flag2=0;
flag3=0;
flag4=0;

while(flag1==0)
    var1 = input('Enter a positive value for d_1: ');
    if(var1>0)
        d1=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: d_1 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a positive value for d_2: ');
    if(var1>0)
        d2=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: d_2 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a positive value for the initial prey/pest population N_10: ');
    if(var1>0)
        N10=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: N_1(0) must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a positive value for the initial predator population N_20: ');
    if(var1>0)
        N20=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: N_2(0) must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the upper bound M: ');
    if(var1>=0)
        M = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: M must be non-negative.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the weight parameter A: ');
    if(var1>0)
        A = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: A must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the total amount of pesticide B: ');
    if(var1>=0)
        B = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: B must be non-negative.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a positive value for the time T: ');
    if(var1>=B/M);
        T=var1;
        flag1=1;
    else
        disp('            ')
        disp('ERROR: T must be compatible with B and M.')
        disp('            ')
    end
end
disp('           ')
a = input('Enter your first guess a: ');    
disp('          ')
b = input('Enter your second guess b: ');
disp('          ')
disp('One moment please...')
y1=code13(a,b,A,B,d1,d2,M,N10,N20,T);

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
            disp('1. d_1')
            disp('2. d_2')
            disp('3. N_10')
            disp('4. N_20')
            disp('5. M')
            disp('6. A')
            disp('7. B')
            disp('8. T')
            var3=input('Type 1 - 8: ');
            if(var3==1)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second d_1 value: ');
                    if(var4 > 0)
                        d12 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: d_1 must be positive.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code13(a,b,A,B,d12,d2,M,N10,N20,T);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second d_2 value: ');
                    if(var4 > 0)
                        d22 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: d_2 must be positive.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code13(a,b,A,B,d1,d22,M,N10,N20,T);
                flag3=1;
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second N_10 value: ');
                    if(var4 > 0)
                        N102 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: N_10 must be positive.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code13(a,b,A,B,d1,d2,M,N102,N20,T);
                flag3=1;    
            elseif(var3==4)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second N_20 value: ');
                    if(var4 > 0)
                        N202 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: N_20 must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code13(a,b,A,B,d1,d2,M,N10,N202,T);
                flag3=1;
            elseif(var3==5)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second M value: ');
                    if(var4 >= B/T)
                        M2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: M must be compatible with B and T.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code13(a,b,A,B,d1,d2,M2,N10,N20,T);
                flag3=1;
            elseif(var3==6)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second A value: ');
                    if(var4 > 0)
                        A2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: A must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code13(a,b,A2,B,d1,d2,M,N10,N20,T);
                flag3=1;
            elseif(var3==7)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second B value: ');
                    if(M*T >= var4 >= 0)
                        B2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: B must be non-negative and compatible with M and T.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code13(a,b,A,B2,d1,d2,M,N10,N20,T);
                flag3=1;    
            elseif(var3==8)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second T value: ');
                    if(var4 >= B/M)
                        T2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: T must be compatible wiht B and M.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code13(a,b,A,B,d1,d2,M,N10,N20,T2);
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
            subplot(3,1,1);ylabel('Prey/Pest Population')
            subplot(3,1,2);plot(y1(1,:),y1(3,:))
            subplot(3,1,2);xlabel('Time')
            subplot(3,1,2);ylabel('Predator Population')
            subplot(3,1,3);plot(y1(1,:),y1(4,:))
            subplot(3,1,3);xlabel('Time')
            subplot(3,1,3);ylabel('Pesticide')
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)
    subplot(3,1,1);plot(y1(1,:),y1(2,:),'b',y2(1,:),y2(2,:),'g')
    subplot(3,1,1);xlabel('Time')
    subplot(3,1,1);ylabel('Prey/Pest Population')
    subplot(3,1,1);legend('First value','Second value',0)
    subplot(3,1,2);plot(y1(1,:),y1(3,:),'b',y2(1,:),y2(3,:),'g')
    subplot(3,1,2);xlabel('Time')
    subplot(3,1,2);ylabel('Predator Population')
    subplot(3,1,2);legend('First value','Second value',0)
    subplot(3,1,3);plot(y1(1,:),y1(4,:),'b',y2(1,:),y2(4,:),'g')
    subplot(3,1,3);xlabel('Time')
    subplot(3,1,3);ylabel('Pesticide')
    subplot(3,1,3);legend('First value','Second value',0)
end