clc
clear

p=xlsread('book1.xls');
n=[16.84,16.64,18.7,16.5,14.98,15.11,16.21,16.39,15.98,14.8,15.98,15.2,14.99,6.99,6.17,6.35,5.84,6.49,3.63,3.63,3.66,3.66,4.13,4.27]/100;
for i=1:6
    for z=1:6
        s(i,z)=0;
        for j=1:8759
            if p(j,z)>80&p(j,z)<200
                s(i,z)=s(i,z)+p(j,z)*0.95;
            end
            if p(j,z)>=200
                s(i,z)=s(i,z)+p(j,z);
            end   
        end
    end
    s(i,:)=s(i,:)*n(i)
end


for i=7:13
    for z=1:6
        s(i,z)=0;
        for j=1:8759
            if p(j,z)>80
                s(i,z)=s(i,z)+p(j,z);
            end
        end
    end
    s(i,:)=s(i,:)*n(i)
end

for i=14:24
    for z=1:6
        s(i,z)=0;
        for j=1:8759
            if p(j,z)>30&p(j,z)<200
                s(i,z)=s(i,z)+p(j,z)*1.01;
            end
            if p(j,z)>=200
                s(i,z)=s(i,z)+p(j,z);
            end
        end
    end
    s(i,:)=s(i,:)*n(i)
end
