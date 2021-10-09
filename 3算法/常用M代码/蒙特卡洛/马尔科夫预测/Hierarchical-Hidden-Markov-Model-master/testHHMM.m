clc;
clear all;
close all;
addpath(genpath('../Graph'))

%% Parameters
maxIter = 40;
maxError = 1e-03;

%% HHMM Structure
q(:,:,1) = [1 0 0 0 0 0 0 0;        % 1 State, 2 Endstate
            1 1 2 0 0 0 0 0;
            1 1 2 1 1 2 0 0;
            1 1 1 2 1 1 1 2];
q(:,:,2) = [3 0 0 0 0 0 0 0;
            3 3 0 0 0 0 0 0;
            0 0 0 4 4 0 0 0;
            0 0 0 0 0 0 0 0];
        
testSeq = [ 1 3 1 3 2 5 8 4 2 5 4 6 7 2 8; 
            7 3 5 8 3 5 2 3 7 5 4 6 3 2 5];     
% testSeq = [ 1 2 3 1 2; 
%             1 2 4 1 2];        
alphabet = 1:8;

%[y x] = find(q(:,:,1)==1 & q(:,:,2)==0);
[prodY prodX] = find(q(:,:,1)==1 & q(:,:,2)==0);
[allY allX] = find(q(:,:,1)==1);
[intY intX] = find(q(:,:,2)~=0);
% Vertical Transitions
PI = zeros(size(q,2),size(q,2),size(q,1)-1);
for i=1:length(allX)
    if allY(i)~=1
        parent_i = find(cumsum(q(allY(i)-1,:,2))>=allX(i),1);
        PI(parent_i,allX(i),allY(i)-1)= 1+(rand(1)-0.5)/5;
    end
end

% Horizontal Transitions
A = zeros(size(q,2),size(q,2),size(q,1)-1);
for i=1:length(allX)
    if allY(i)~=1
        parent_i = find(cumsum(q(allY(i)-1,:,2))>=allX(i),1);
        jArray = find(PI(parent_i,:,allY(i)-1)~=0);
        jArray = [jArray jArray(end)+1];
        A(allX(i),jArray,allY(i)-1)= 1+(rand(size(jArray,2),1)-0.5)/5;
    end
end

% Emissions
for i=1:length(prodX);
    r = ones(1,length(alphabet))+(rand(1,length(alphabet))-0.5)/5; 
    B(prodY(i),prodX(i),1:length(alphabet)) = r/sum(r);
end;

%% Normierung
for zeile = 1:size(q,2)
    for tiefe = 1:(size(q,1)-1)
        A(zeile,:,tiefe) = A(zeile,:,tiefe)/sum(A(zeile,:,tiefe));
        PI(zeile,:,tiefe) = PI(zeile,:,tiefe)/sum(PI(zeile,:,tiefe));
    end
end
A(isnan(A))=0;
PI(isnan(PI))=0;

initA = A;
initB = B;
initPI = PI;

Palt = 0;
stop = 0;
for iter = 1:maxIter

    ergA = zeros(size(initA));
    ergB = zeros(size(initB));
    ergPI = zeros(size(initPI));

    ergAVis = zeros(size(initA));
    ergBVis = zeros(size(initB));
    ergPIVis = zeros(size(initPI));

    Pact = 0;
    for s=1:2
        seq = testSeq(s,:);
        tic;
            [PI, A, B, P] = HHMM_EM(q, seq, initA, initPI, initB, alphabet, 0);
            Pact = Pact+P;
            B(isnan(B))=0;
            A(isnan(A))=0;
            PI(isnan(PI))=0;
        toc;

        ergA = ergA+A;
        ergB = ergB+B;
        ergPI = ergPI+PI;
    end

    for i=1:length(prodX);
       ergBVis(prodY(i),prodX(i),:) = ergB(prodY(i),prodX(i),:)/sum(ergB(prodY(i),prodX(i),:));
    end;
    for zeile = 1:size(q,2)
        for tiefe = 1:(size(q,1)-1)
            ergAVis(zeile,:,tiefe) = ergA(zeile,:,tiefe)/sum(ergA(zeile,:,tiefe));
            ergPIVis(zeile,:,tiefe) = ergPI(zeile,:,tiefe)/sum(ergPI(zeile,:,tiefe));
        end
    end
    ergAVis(isnan(ergAVis))=0;
    ergPIVis(isnan(ergPIVis))=0;
    ergBVis(isnan(ergBVis))=0;
    set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 30 20])
    drawHHMM(q, ergAVis, ergPIVis, ergBVis);
    axis tight;
    V = AXIS;
    axis([V(1) V(2) V(3)-2 V(4)])
    title(sprintf('Iteration %d',iter));
    hold off;
    drawnow;
    
    if (abs(Pact-Palt)/(1+abs(Palt))) < maxError
        states = q(:,:,1)==1;
        if norm(ergAVis(:)-initA(:),inf)/sum(states(:)) < maxError
            fprintf('Konvergenz nach %d Iterationen\n', iter)
            stop = 1;
        end
    end                    
    if stop == 0
        Palt = Pact;
        initA = ergAVis;
        initB = ergBVis;
        initPI = ergPIVis;
    else
        break;
    end
end