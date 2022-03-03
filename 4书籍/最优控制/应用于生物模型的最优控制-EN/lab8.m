close

flag1=0;
flag2=0;
flag3=0;
flag4=0;
var1=0;
var2=0;
var3=0;
var4=0;

while(flag1==0)
    var1 = input('Enter a value for the source term s: ');
    if(var1>0)
        s=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: s must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for natural death rate of T cells (m_1): ');
    if(var1>0)
        m1=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: m_1 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for death rate of infected T cells (m_2): ');
    if(var1>0)
        m2=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: m_2 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for viral death rate (m_3): ');
    if(var1>0)
        m3=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: m_3 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the T cell growth rate (r): ');
    if(var1>0)
        r=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: r must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a maximum T cell level (T_max): ');
    if(var1>0)
        Tmax = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: T_max must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for infection rate (k): ');
    if(var1>0)
        k = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: k must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter the average number of virus cells produced (N): ');
    if(var1>0)
        N = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: N must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter an initial uninfected T cell concentration (T_0): ');
    if(var1>0)
        T0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: T_0 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter an initial infected T cell concentration (T_i0): ');
    if(var1>0)
        Ti0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: T_i0 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter an initial free virus concentration (V_0): ');
    if(var1>0)
        V0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: V_0 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the weight parameter A: ');
    if(var1>=0)
        A = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: A must be non-negative.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter the number of days you would like to run this model (t_final): ');
    if(0<var1);
        time=var1;
        flag1=1;
    else
        disp('            ')
        disp('ERROR: t_final must be positive.')
        disp('            ')
    end
end
disp('           ')
disp('One moment please...')
y1=code8(s,m1,m2,m3,r,Tmax,k,N,T0,Ti0,V0,A,time);

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
            disp('1. s')
            disp('2. m_1')
            disp('3. m_2')
            disp('4. m_3')
            disp('5. r')
            disp('6. T_max')
            disp('7. k')
            disp('8. N')
            disp('9. T_0')
            disp('10. T_i0')
            disp('11. V_0')
            disp('12. A')
            disp('13. t_final')
            var3=input('Type 1 - 13: ');
            if(var3==1)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second s value: ');
                    if(var4 > 0)
                        s2 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: s must be positive.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code8(s2,m1,m2,m3,r,Tmax,k,N,T0,Ti0,V0,A,time);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second m_1 value: ');
                    if(var4 > 0)
                        m12 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: m_1 must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code8(s,m12,m2,m3,r,Tmax,k,N,T0,Ti0,V0,A,time);
                flag3=1;
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second m_2 value: ');
                    if(var4 > 0)
                        m22 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: m_2 must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code8(s,m1,m22,m3,r,Tmax,k,N,T0,Ti0,V0,A,time);
                flag3=1; 
            elseif(var3==4)
                disp('        ')
                while(flag4==0)
                   var4=input('Enter a second m_3 value: ');
                   if(var4 > 0)
                       m32 = var4;
                       flag4 = 1;
                   else
                       disp('      ')
                       disp('ERROR: m_3 must be positive.')
                       disp('        ')
                   end
                end
                disp('            ')
                disp('One moment please...')
                y2=code8(s,m1,m2,m32,r,Tmax,k,N,T0,Ti0,V0,A,time);
                flag3=1;
            elseif(var3==5)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second r value: ');
                    if(var4 > 0)
                        r2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: r must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code8(s,m1,m2,m3,r2,Tmax,k,N,T0,Ti0,V0,A,time);
                flag3=1;
            elseif(var3==6)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second T_max value: ');
                    if(var4 > 0)
                        Tmax2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: T_max must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code8(s,m1,m2,m3,r,Tmax2,k,N,T0,Ti0,V0,A,time);
                flag3=1;
            elseif(var3==7)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second k value: ');
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
                y2=code8(s,m1,m2,m3,r,Tmax,k2,N,T0,Ti0,V0,A,time);
                flag3=1;
            elseif(var3==8)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second N value: ');
                    if(var4 > 0)
                        N2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: N must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code8(s,m1,m2,m3,r,Tmax,k,N2,T0,Ti0,V0,A,time);
                flag3=1;
            elseif(var3==9)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second T_0 value: ');
                    if(var4 > 0)
                        T02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: T_0 must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code8(s,m1,m2,m3,r,Tmax,k,N,T02,Ti0,V0,A,time);
                flag3=1;
            elseif(var3==10)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second T_i0 value: ');
                    if(var4 > 0)
                        Ti02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: T_i0 must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code8(s,m1,m2,m3,r,Tmax,k,N,T0,Ti02,V0,A,time);
                flag3=1;
            elseif(var3==11)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second V_0 value: ');
                    if(var4 > 0)
                        V02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: V_0 must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code8(s,m1,m2,m3,r,Tmax,k,N,T0,Ti0,V02,A,time);
                flag3=1;
            elseif(var3==12)
                disp('           ')
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
                y2=code8(s,m1,m2,m3,r,Tmax,k,N,T0,Ti0,V0,A2,time);
                flag3=1;
            elseif(var3==13)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second t_final value: ');
                    if(var4 > 0)
                        time2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: t_final must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code8(s,m1,m2,m3,r,Tmax,k,N,T0,Ti0,V0,A,time2);
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
            subplot(4,1,1);plot(y1(1,:),y1(2,:))
            subplot(4,1,1);xlabel('Days')
            subplot(4,1,1);ylabel('T')
            subplot(4,1,2);plot(y1(1,:),y1(3,:))
            subplot(4,1,2);xlabel('Days')
            subplot(4,1,2);ylabel('T_i')
            subplot(4,1,3);plot(y1(1,:),y1(4,:))
            subplot(4,1,3);xlabel('Days')
            subplot(4,1,3);ylabel('V')
            subplot(4,1,4);plot(y1(1,:),y1(5,:))
            subplot(4,1,4);xlabel('Days')
            subplot(4,1,4);ylabel('u^*')
            subplot(4,1,4);axis([0 time -0.1 1.1])
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)
    subplot(4,1,1);plot(y1(1,:),y1(2,:),'b',y2(1,:),y2(2,:),'g')
    subplot(4,1,1);xlabel('Days')
    subplot(4,1,1);ylabel('T')
    subplot(4,1,1);legend('First value','Second value',0)
    subplot(4,1,2);plot(y1(1,:),y1(3,:),'b',y2(1,:),y2(3,:),'g')
    subplot(4,1,2);xlabel('Days')
    subplot(4,1,2);ylabel('T_i')
    subplot(4,1,2);legend('First value','Second value',0)
    subplot(4,1,3);plot(y1(1,:),y1(4,:),'b',y2(1,:),y2(4,:),'g')
    subplot(4,1,3);xlabel('Days')
    subplot(4,1,3);ylabel('V')
    subplot(4,1,3);legend('First value','Second value',0)
    subplot(4,1,4);plot(y1(1,:),y1(5,:),'b',y2(1,:),y2(5,:),'g')
    subplot(4,1,4);xlabel('Days')
    subplot(4,1,4);ylabel('u^*')
    subplot(4,1,4);legend('First value','Second value',0)
    if(var3==13)
        subplot(4,1,4);axis([0 max(time,time2) -0.1 1.1])
    else    
        subplot(4,1,4);axis([0 time -0.1 1.1])
    end
end