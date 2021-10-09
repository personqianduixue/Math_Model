function [m, p, DistHist,minIndx]=vqsplit(X,L)
% Vector Quantization: K-Means Algorithm with Spliting Method for Training
% NOT TESTED FOR CODEBOOK SIZES OTHER THAN POWERS OF BASE 2, E.G. 256, 512, ETC
% (Saves output to a mat file (CBTEMP.MAT) after each itteration, so that if
% it is going too slow you can break it (CTRL+C) without losing your work
% so far.)
% [M, P, DH]=VQSPLIT(X,L)
% 
% or
% [M_New, P, DH]=VQSPLIT(X,M_Old)   In this case M_Old is a codebook and is
%                                   retrained on data X
% 
% inputs:
% X: a matrix each column of which is a data vector
% L: codebook size (preferably a power of 2 e.g. 16,32 256, 1024) (Never
% tested for other values!
% 
% Outputs:
% M: the codebook as the centroids of the clusters
% P: Weight of each cluster the number of its vectors divided by total
%       number of vectors
% DH: The total distortion history, a vector containing the overall
% distortion of each itteration
%
% Method:
% The mean vector is split to two. the model is trained on those two vectors
% until the distortion does not vary much, then those are split to two and
% so on. until the disired number of clusters is reached.
% Algorithm:
% 1. Find the Mean
% 2. Split each centroid to two
% 3. Assign Each Data to a centroid
% 4. Find the Centroids
% 5. Calculate The Total Distance
% 6. If the Distance has not changed much
%       if the number of Centroids is smaller than L2 Goto Step 2
%       else Goto 7
%    Else (the Distance has changed substantialy) Goto Step 3
% 7. If the number of Centroids is larger than L
%    Discard the Centroid with (highest distortion OR lowest population)
%    Goto 3
% 8. Calculate the Variances and Cluster Weights if required
% 9. End
%
% Esfandiar Zavarehei, Brunel University
% May-2006

e=.01; % X---> [X-e*X and X+e*X] Percentage for Spliting
eRed=0.75; % Rate of reduction of split size, e, after each spliting. i.e. e=e*eRed;
DT=.005; % The threshold in improvement in Distortion before terminating and spliting again
DTRed=0.75; % Rate of reduction of Improvement Threshold, DT, after each spliting
MinPop=0.10; % The population of each cluster should be at least 10 percent of its quota (N/LC)
             % Otherwise that codeword is replaced with another codeword


d=size(X,1); % Dimension
N=size(X,2); % Number of Data points
isFirstRound=1; % First Itteration after Spliting

if numel(L)==1
    M=mean(X,2); % Mean Vector
    CB=[M*(1+e) M*(1-e)]; % Split to two vectors
else
    CB=L; % If the codebook is passed to the function just train it
    L=size(CB,2);
    e=e*(eRed^fix(log2(L)));
    DT=DT*(DTRed^fix(log2(L)));
end

LC=size(CB,2); % Current size of the codebook

Iter=0;
Split=0;
IsThereABestCB=0;
maxIterInEachSize=20; % The maximum number of training itterations at each 
                      % codebook size (The codebook size starts from one 
                      % and increases thereafter)
EachSizeIterCounter=0;
while 1
    %Distance Calculation
    [minIndx, dst]=VQIndex(X,CB); % Find the closest codewords to each data vector

    ClusterD=zeros(1,LC);
    Population=zeros(1,LC);
    LowPop=[];
    % Find the Centroids (Mean of each Cluster)
    for i=1:LC
        Ind=find(minIndx==i);
        if length(Ind)<MinPop*N/LC % if a cluster has very low population just remember it
            LowPop=[LowPop i];
        else
            CB(:,i)=mean(X(:,Ind),2);
            Population(i)=length(Ind);
            ClusterD(i)=sum(dst(Ind));
        end        
    end
    if ~isempty(LowPop)
        [temp MaxInd]=maxn(Population,length(LowPop));
        CB(:,LowPop)=CB(:,MaxInd)*(1+e); % Replace low-population codewords with splits of high population codewords
        CB(:,MaxInd)=CB(:,MaxInd)*(1-e);
        
        %re-train
        [minIndx, dst]=VQIndex(X,CB);

        ClusterD=zeros(1,LC);
        Population=zeros(1,LC);
        
        for i=1:LC
            Ind=find(minIndx==i);
            if ~isempty(Ind)
                CB(:,i)=mean(X(:,Ind),2);
                Population(i)=length(Ind);
                ClusterD(i)=sum(dst(Ind));
            else %if no vector is close enough to this codeword, replace it with a random vector
                CB(:,i)=X(:,fix(rand*N)+1);
                disp('A random vector was assigned as a codeword.')
                isFirstRound=1;% At least another iteration is required
            end                
        end
    end
    Iter=Iter+1;
    if isFirstRound % First itteration after a split (dont exit)
        TotalDist=sum(ClusterD(~isnan(ClusterD)));
        DistHist(Iter)=TotalDist;
        PrevTotalDist=TotalDist;        
        isFirstRound=0;
    else
        TotalDist=sum(ClusterD(~isnan(ClusterD)));  
        DistHist(Iter)=TotalDist;
        PercentageImprovement=((PrevTotalDist-TotalDist)/PrevTotalDist);
        if PercentageImprovement>=DT %Improvement substantial
            PrevTotalDist=TotalDist; %Save Distortion of this iteration and continue training
            isFirstRound=0;
        else%Improvement NOT substantial (Saturation)
            EachSizeIterCounter=0;
            if LC>=L %Enough Codewords?
                if L==LC %Exact number of codewords
                    disp(TotalDist)
                    break
                else % Kill one codeword at a time
                    [temp, Ind]=min(Population); % Eliminate low population codewords
                    NCB=zeros(d,LC-1);
                    NCB=CB(:,setxor(1:LC,Ind(1)));
                    CB=NCB;
                    LC=LC-1;
                    isFirstRound=1;
                end
            else %If not enough codewords yet, then Split more
                CB=[CB*(1+e) CB*(1-e)];
                e=eRed*e; %Split size reduction
                DT=DT*DTRed; %Improvement Threshold Reduction
                LC=size(CB,2);
                isFirstRound=1;
                Split=Split+1;
                IsThereABestCB=0; % As we just split this codebook, there is no best codebook at this size yet
                disp(LC)
            end
        end
    end    
    if ~IsThereABestCB
        BestCB=CB;
        BestD=TotalDist;
        IsThereABestCB=1;
    else % If there is a best CB, check to see if the current one is better than that
        if TotalDist<BestD
            BestCB=CB;
            BestD=TotalDist;
        end
    end
    EachSizeIterCounter=EachSizeIterCounter+1;
    if EachSizeIterCounter>maxIterInEachSize % If too many itterations in this size, stop training this size
        EachSizeIterCounter=0;
        CB=BestCB; % choose the best codebook so far
        IsThereABestCB=0;
        if LC>=L %Enough Codewords?
            if L==LC %Exact number of codewords
                disp(TotalDist)
                break
            else % Kill one codeword at a time
                [temp, Ind]=min(Population);
                NCB=zeros(d,LC-1);
                NCB=CB(:,setxor(1:LC,Ind(1)));
                CB=NCB;
                LC=LC-1;
                isFirstRound=1;
            end
        else %Split
            CB=[CB*(1+e) CB*(1-e)];
            e=eRed*e; %Split size reduction
            DT=DT*DTRed; %Improvement Threshold Reduction
            LC=size(CB,2);
            isFirstRound=1;
            Split=Split+1;
            IsThereABestCB=0;
            disp(LC)
        end
    end        
    disp(TotalDist)
    p=Population/N;
    save CBTemp CB p DistHist
end
m=CB;

p=Population/N;

disp(['Iterations = ' num2str(Iter)]);
disp(['Split = ' num2str(Split)]);

function [v, i]=maxn(x,n)
% [V, I]=MAXN(X,N)
% APPLY TO VECTORS ONLY!
% This function returns the N maximum values of vector X with their indices.
% V is a vector which has the maximum values, and I is the index matrix,
% i.e. the indices corresponding to the N maximum values in the vector X

if nargin<2
    [v, i]=max(x); %Only the first maximum (default n=1)
else
    n=min(length(x),n);
    [v, i]=sort(x);
    v=v(end:-1:end-n+1);
    i=i(end:-1:end-n+1);    
end
        
function [I, dst]=VQIndex(X,CB) 
% Distance function
% Returns the closest index of vectors in X to codewords in CB
% In other words:
% I is a vector. The length of I is equal to the number of columns in X.
% Each element of I is the index of closest codeword (column) of CB to
% coresponding column of X

L=size(CB,2);
N=size(X,2);
LNThreshold=64*10000;

if L*N<LNThreshold
    D=zeros(L,N);
    for i=1:L
        D(i,:)=sum((repmat(CB(:,i),1,N)-X).^2,1);
    end
    [dst I]=min(D);
else
    I=zeros(1,N);
    dst=I;
    for i=1:N
        D=sum((repmat(X(:,i),1,L)-CB).^2,1);
        [dst(i) I(i)]=min(D);
    end
end
    
function [I, dist]=VQLSFSpectralIndex(X,CB,W)
% If your codewords are LSF coefficients, You can use this function instead of VQINDEX
% This is for speech coding
% I=VQLSFSPECTRALINDEX(X,CB,W)
% Calculates the nearest set of LSF coefficients in the codebook CB to each
% column of X by calculating their LP spectral distances.
% I is the index of the closest codeword, X is the set of LSF coefficients
% (each column is a set of coefficients) CB is the codebook, W is the
% weighting vector, if not provided it is assumed to be equal to ones(256,1)
% Esfandiar Zavarehei
% 9-Oct-05

if nargin<3
    L=256;
    W=ones(L,1);
else
    if isscalar(W)
        L=W;
        W=ones(L,1);
    elseif isvector(W)
        W=W(:);
        L=length(W);
    else
        error('Invalid input argument. W should be either a vector or a scaler!')
    end
end

NX=size(X,2);
NCB=size(CB,2);

AX=lsf2lpc(X);
ACB=lsf2lpc(CB);


D=zeros(NCB,1);

w=linspace(0,pi,L+1);
w=w(1:end-1);
N=size(AX,2)-1;
WFZ=zeros(N+1,L);
IMAGUNIT=sqrt(-1);
for k=0:N
    WFZ(k+1,:)=exp(IMAGUNIT*k*w);
end

SCB=zeros(L,NCB);
for i=1:NCB
    SCB(:,i)=(1./abs(ACB(i,:)*WFZ));
end

I=zeros(1,NX);
dist=zeros(1,NX);
for j=1:NX
    SX=(1./abs(AX(j,:)*WFZ))';    
    for i=1:NCB
        D(i)=sqrt(sum(((SX-SCB(:,i)).^2).*W));
    end
    [dist(j), I(j)]=min(D);
end