% Test program for GrTheory functions
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

clear all

% select test:
% ntest=1 - grBase
% ntest=2 - grCoBase
% ntest=3 - grCoCycleBasis
% ntest=4 - grColEdge
% ntest=5 - grColVer
% ntest=6 - grComp
% ntest=7 - grCycleBasis
% ntest=8 - grDecOrd
% ntest=9 - grDistances
% ntest=10 - grEccentricity
% ntest=11 - grIsEulerian
% ntest=12 - grMaxComSu
% ntest=13 - grMaxFlows
% ntest=14 - grMaxMatch
% ntest=15 - grMaxStabSet
% ntest=16 - grMinAbsEdgeSet
% ntest=17 - grMinAbsVerSet
% ntest=18 - grMinCutSet
% ntest=19 - grMinEdgeCover
% ntest=20 - grMinSpanTree
% ntest=21 - grMinVerCover
% ntest=22 - grPERT
% ntest=23 - grPlot
% ntest=24 - grShortPath
% ntest=25 - grTravSale
ntest=23;

switch ntest % selected test
  case 1, % grBase test
    disp('The grBase test')
    V=[0 4;4 4;0 0;4 0;8 4;8 0;12 4;12 0;...
      -2 8;-4 4;0 -4;-4 -4;-4 0];
    E=[1 2;3 4;2 4;2 5;4 6;5 6;5 7;6 8;8 7;...
       1 9;9 10;10 1;3 11;11 12;12 13;13 3;3 12;13 11];
    grPlot(V,E,'d','%d','');
    title('\bfThe initial digraph')
    BG=grBase(E);
    disp('The bases of digraph:')
    disp(' N    vertexes')
    for k1=1:size(BG,1),
      fprintf('%2.0f    ',k1)
      fprintf('%d  ',BG(k1,:))
      fprintf('\n')
    end
  case 2, % grCoBase test
    disp('The grCoBase test')
    V=[0 4;4 4;0 0;4 0;8 4;8 0;12 4;12 0;...
      -2 8;-4 4;0 -4;-4 -4;-4 0];
    E=[2 1;3 4;2 4;2 5;4 6;5 6;5 7;6 8;8 7;...
       1 9;9 10;10 1;3 11;11 12;12 13;13 3;3 12;13 11];
    grPlot(V,E,'d','%d','');
    title('\bfThe initial digraph')
    CBG=grCoBase(E);
    disp('The contrabasis of digraph:')
    disp(' N    vertexes')
    for k1=1:size(CBG,1),
      fprintf('%2.0f    ',k1)
      fprintf('%d  ',CBG(k1,:))
      fprintf('\n')
    end
  case 3, % grCoCycleBasis test
    disp('The grCoCycleBasis test')
    V=[0 0;1 1;1 0;1 -1;2 1;2 0;2 -1;3 1;...
       3 0;3 -1;4 0]; % vertexes coordinates
    E=[1 2;1 3;1 4;2 3;3 4;2 5;2 6;3 6;3 7;4 7;5 6;6 7;...
       5 8;6 8;6 9;7 9;7 10;8 9;9 10;8 11;9 11;10 11]; % edges
    E=[E [1:size(E,1)]']; % edges with numbers
    grPlot(V,E,'g','','%d'); % the initial graph
    title('\bfThe initial graph')
    CoCycles=grCoCycleBasis(E); % all independences cut-sets
    for k1=1:size(CoCycles,2),
      grPlot(V,E(find(~CoCycles(:,k1)),:),'g','','%d'); % one cocycle
      title(['\bfCocycle N' num2str(k1)]);
    end
  case 4, % grColEdge test
    disp('The grColEdge test')
    V=[0 0;1 1;1 0;1 -1;2 1;2 0;2 -1;3 1;...
       3 0;3 -1;4 0]; % vertexes coordinates
    E=[1 2;1 3;1 4;2 3;3 4;2 5;2 6;3 6;3 7;4 7;5 6;6 7;...
       5 8;6 8;6 9;7 9;7 10;8 9;9 10;8 11;9 11;10 11]; % edges
    grPlot(V,E,'g','','%d'); % the initial graph
    title('\bfThe initial graph')
    mCol=grColEdge(E); % the color problem for edges
    fprintf('The colors of edges\n N edge    N col\n');
    fprintf('  %2.0f        %2.0f\n',[1:length(mCol);mCol']);
    grPlot(V,[E,mCol],'g','','%d'); % plot the colored graph
    title('\bfThe graph with colored edges')
  case 5, % grColVer test
    disp('The grColVer test')
    t=[0:4]';
    V=[[5*sin(2*pi*t/5) 5*cos(2*pi*t/5)];...
       [4*sin(2*pi*(t-0.5)/5) 4*cos(2*pi*(t-0.5)/5)];...
       [2*sin(2*pi*(t-0.5)/5) 2*cos(2*pi*(t-0.5)/5)];[0 0]];
    E=[1 7;7 2;2 8;8 3;3 9;9 4;4 10;10 5;5 6;6 1;...
      1 10;2 6;3 7;4 8;5 9;1 12;2 13;3 14;4 15;5 11;...
      6 14;7 15;8 11;9 12;10 13;...
      11 12;12 13;13 14;14 15;15 11;1 16;2 16;3 16;4 16;5 16];
    grPlot(V,E,'g','%d',''); % the initial graph
    title('\bfThe initial graph')
    nCol=grColVer(E); % the color problem for vertexes
    fprintf('The colors of vertexes\n N ver     N col\n');
    fprintf('  %2.0f        %2.0f\n',[1:length(nCol);nCol']);
    grPlot([V,nCol],E,'g','%d',''); % plot the colored graph
    title('\bfThe graph with colored vertexes')
  case 6, % grComp test
    disp('The grComp test')
    V=[0 4;4 4;0 0;4 0;8 4;8 0;12 4;12 0;...
      -2 8;-4 4;0 -4;-4 -4;-4 0];
    E=[1 2;3 4;2 4;2 5;4 6;5 6;5 7;6 8;8 7;...
       1 9;9 10;10 1;3 11;11 12;12 13;13 3;3 12;13 11];
    ncV=grComp(E);
    grPlot([V ncV],E,'g','%d','');
    title(['\bfThis graph have ' num2str(max(ncV)) ' component(s)'])
    E=[2 4;2 5;4 6;5 6;5 7;6 8;8 7;...
       1 9;9 10;10 1;3 11;11 12;12 13;13 3;3 12;13 11];
    ncV=grComp(E);
    grPlot([V ncV],E,'g','%d','');
    title(['\bfThis graph have ' num2str(max(ncV)) ' component(s)'])
    E=[2 4;2 5;4 6;5 6;5 7;6 8;8 7;...
       1 9;9 10;10 1;3 11;11 12;3 12];
    ncV=grComp(E,size(V,1));
    grPlot([V ncV],E,'g','%d','');
    title(['\bfThis graph have ' num2str(max(ncV)) ' component(s)'])
  case 7, % grCycleBasis test
    disp('The grCycleBasis test')
    V=[0 0;1 1;1 0;1 -1;2 1;2 0;2 -1;3 1;...
       3 0;3 -1;4 0]; % vertexes coordinates
    E=[1 2;1 3;1 4;2 3;3 4;2 5;2 6;3 6;3 7;4 7;5 6;6 7;...
       5 8;6 8;6 9;7 9;7 10;8 9;9 10;8 11;9 11;10 11]; % edges
    grPlot(V,E,'g','%d',''); % the initial graph
    title('\bfThe initial graph')
    Cycles=grCycleBasis(E); % all independences cycles
    for k1=1:size(Cycles,2),
      grPlot(V,E(find(Cycles(:,k1)),:),'g','%d',''); % one cycle
      title(['\bfCycle N' num2str(k1)]);
    end
  case 8, % grDecOrd test
    disp('The grDecOrd test')
    V=[0 4;1 4;2 4;3 4;4 4;0 3;1 3;2 3;3 3;4 3;...
       0 2;1 2;2 2;3 2;4 2;0 1;1 1;2 1;3 1;4 1;...
       0 0;1 0;2 0;3 0;4 0];
    E=[1 2;3 2;4 3;5 4;6 1;2 7;8 2;3 8;9 4;9 5;10 5;7 6;8 7;...
       8 9;10 9;11 6;7 12;13 8;14 9;15 10;12 11;13 12;13 14;...
       14 13;15 14;16 11;12 17;13 18;20 15;17 16;17 18;18 17;...
       19 18;19 20;21 16;17 22;18 22;22 18;18 23;19 24;20 25;...
       21 22;22 21;23 24;24 23;24 25];
    grPlot(V,E,'d');
    title('\bfThe initial digraph')
    [Dec,Ord]=grDecOrd(E); % solution
    disp('The classes of mutually connected vertexes:')
    disp(' N    vertexes')
    for k1=1:size(Dec,2),
      fprintf('%2.0f    ',k1)
      fprintf('%d  ',find(Dec(:,k1)))
      fprintf('\n')
    end
    fprintf('The partial ordering of the classes:\n  ')
    fprintf('%3.0f',1:size(Ord,2))
    fprintf('\n')
    for k1=1:size(Ord,1), % the matrix of partial ordering
      fprintf('%2.0f ',k1)
      fprintf(' %1.0f ',Ord(k1,:))
      fprintf('\n')
    end
    V1=V;
    for k1=1:size(Dec,2),
      V1(find(Dec(:,k1)),3)=k1; % weight = number of the class
    end
    grPlot(V1,E,'d','%d','');
    title('\bfThe classes of mutually connected vertexes')
  case 9, % grDispances test
    disp('The grDispances test')
    V=[0 4;1 4;2 4;3 4;4 4;0 3;1 3;2 3;3 3;4 3;...
       0 2;1 2;2 2;3 2;4 2;0 1;1 1;2 1;3 1;4 1;...
       0 0;1 0;2 0;3 0;4 0];
    E=[1 2 1;3 2 2;4 3 3;5 4 4;6 1 5;2 7 6;8 2 7;3 8 1;...
       9 4 9;9 5 8;10 5 7;7 6 6;8 7 5;8 9 4;10 9 3;11 6 2;...
       7 12 1;13 8 2;14 9 3;15 10 4;12 11 5;13 12 6;13 14 7;...
       14 13 8;5 5 10;15 14 9;16 11 8;12 17 7;13 18 6;...
       20 15 5;17 16 4;17 18 3;18 17 2;19 18 1;19 20 2;...
       5 5 8; 21 16 3;17 22 4;18 22 5;22 18 6;18 23 7;...
       19 24 8;20 25 9;21 22 8;22 21 7;23 24 6;10 10 8;...
       24 23 5;24 25 4];
    s=1; % one vertex
    t=25; % other vertex
    grPlot(V,E); % the initial graph
    title('\bfThe initial graph with weighed edges')
    [dSP,sp]=grDistances(E(:,1:2),s,t); % the nonweighted task
    fprintf('The steps number between all vertexes:\n   ')
    fprintf('%4.0f',1:size(dSP,2))
    fprintf('\n')
    for k1=1:size(dSP,1), % the matrix of distances
      fprintf('%3.0f ',k1)
      fprintf(' %2.0f ',dSP(k1,:))
      fprintf('\n')
    end
    grPlot(V(:,1:2),[sp(1:end-1);sp(2:end)]','d','%d','')
    title(['\bfThe shortest way between vertex ' ...
      num2str(s) ' and vertex ' num2str(t)])
    [dSP,sp]=grDistances(E,1,25); % the weighted task
    fprintf('The distances between all vertexes:\n   ')
    fprintf('%4.0f',1:size(dSP,2))
    fprintf('\n')
    for k1=1:size(dSP,1), % the matrix of distances
      fprintf('%3.0f ',k1)
      fprintf(' %2.0f ',dSP(k1,:))
      fprintf('\n')
    end
    grPlot(V(:,1:2),[sp(1:end-1);sp(2:end)]','d','%d','')
    title(['\bfThe way with minimal weight between vertex ' ...
      num2str(s) ' and vertex ' num2str(t)])
  case 10, % grEccentricity test
    disp('The grEccentricity test')
    V=[0 4;1 4;2 4;3 4;4 4;0 3;1 3;2 3;3 3;4 3;...
       0 2;1 2;2 2;3 2;4 2;0 1;1 1;2 1;3 1;4 1;...
       0 0;1 0;2 0;3 0;4 0];
    E=[1 2 1;3 2 2;4 3 3;5 4 4;6 1 5;2 7 6;8 2 7;3 8 1;...
       9 4 9;9 5 8;10 5 7;7 6 6;8 7 5;8 9 4;10 9 3;11 6 2;...
       7 12 1;13 8 2;14 9 3;15 10 4;12 11 5;13 12 6;13 14 7;...
       14 13 8;5 5 10;15 14 9;16 11 8;12 17 7;13 18 6;...
       20 15 5;17 16 4;17 18 3;18 17 2;19 18 1;19 20 2;...
       5 5 8; 21 16 3;17 22 4;18 22 5;22 18 6;18 23 7;...
       19 24 8;20 25 9;21 22 8;22 21 7;23 24 6;10 10 8;...
       24 23 5;24 25 4];
    grPlot(V,E); % the initial graph
    title('\bfThe initial graph with weighed edges')
    [Ec,Rad,Diam,Cv,Pv]=grEccentricity(E(:,1:2)); % the nonweighted task
    fprintf('The nonweighted eccentricities of all vertexes:\n N ver  Ecc\n')
    fprintf('%4.0f  %4.0f\n',[1:size(V,1);Ec])
    fprintf('The radius of graph Rad=%d\n',Rad)
    fprintf('The diameter of graph Diam=%d\n',Diam)
    fprintf('The center vertexes is:')
    fprintf('  %d',Cv)
    fprintf('\nThe periphery vertexes is:')
    fprintf('  %d',Pv)
    fprintf('\n')
    [Ec,Rad,Diam,Cv,Pv]=grEccentricity(E); % the weighted task
    fprintf('The weighted eccentricities of all vertexes:\n N ver  Ecc\n')
    fprintf('%4.0f  %4.0f\n',[1:size(V,1);Ec])
    fprintf('The radius of graph Rad=%d\n',Rad)
    fprintf('The diameter of graph Diam=%d\n',Diam)
    fprintf('The center vertexes is:')
    fprintf('  %d',Cv)
    fprintf('\nThe periphery vertexes is:')
    fprintf('  %d',Pv)
    fprintf('\n')
  case 11, % grIsEulerian test
    disp('The grIsEulerian test')
    V=[0 4;1 4;2 4;3 4;4 4;0 3;1 3;2 3;3 3;4 3;...
       0 2;1 2;2 2;3 2;4 2;0 1;1 1;2 1;3 1;4 1;...
       0 0;1 0;2 0;3 0;4 0];
    E=[1 2;3 2;4 3;5 4;6 1;2 7;8 2;3 8;9 4;9 5;10 5;7 6;8 7;...
       8 9;10 9;11 6;7 12;13 8;14 9;15 10;12 11;13 12;13 14;...
       14 13;15 14;16 11;12 17;13 18;20 15;17 16;17 18;18 17;...
       19 18;19 20;21 16;17 22;18 22;22 18;18 23;19 24;20 25;...
       21 22;22 21;23 24;24 23;24 25];
    [eu,cEu]=grIsEulerian(E);
    switch eu,
      case 1,
        st='';
        E=[E(cEu,1:2), [1:size(E,1)]'];
      case 0.5,
        st='semi-';
        E=[E(cEu,1:2), [1:size(E,1)]'];
      otherwise,
        st='not ';
        E=[E(:,1:2), [1:size(E,1)]'];
    end
    grPlot(V,E,'g','','%d');
    title(['\bf This graph is ' st 'Eulerian'])
    V=[0 4;1 4;2 4;3 3.7;4 4;0 3;1 3.3;2 3.3;3 3;4 3;...
       0 2;1 2;2 2;3 2;4 2;0 1;1 1;2 1;3 1;4 1;...
       0 0;1 0;2 0;3 0;4 0];
    E=[1 2;3 2;4 3;5 4;3 5;6 1;2 7;8 2;3 8;9 4;9 5;...
       10 4;10 5;7 6;8 7;6 9;20 15;11 16;21 18;19 23;...
       8 9;10 9;11 6;7 12;14 9;15 10;12 11;13 12;13 14;...
       14 13;15 14;16 11;12 17;13 18;20 15;17 16;17 18;...
       19 18;19 20;21 16;17 22;18 22;18 23;19 24;20 25;...
       21 22;22 21;23 24;24 23;24 25];
    [eu,cEu]=grIsEulerian(E);
    switch eu,
      case 1,
        st='';
        E=[E(cEu,1:2), [1:size(E,1)]'];
      case 0.5,
        st='semi-';
        E=[E(cEu,1:2), [1:size(E,1)]'];
      otherwise,
        st='not ';
        E=[E(:,1:2), [1:size(E,1)]'];
    end
    grPlot(V,[E,[1:size(E,1)]'],'g','');
    title(['\bf This graph is ' st 'Eulerian'])
    V=[0 4;1 4;2 4;3 3.7;4 4;0 3;1 3.3;2 3.3;3 3;4 3;...
       0 2;1 2;2 2;3 2;4 2;0 1;1 1;2 1;3 1;4 1;...
       0 0;1 0;2 0;3 0;4 0];
    E=[1 2;3 2;4 3;5 4;3 5;6 1;2 7;8 2;3 8;9 4;9 5;...
       10 4;10 5;7 6;8 7;6 9;20 15;11 16;21 18;19 23;...
       8 9;10 9;11 6;7 12;14 9;15 10;12 11;13 12;13 14;...
       14 13;15 14;16 11;12 17;13 18;20 15;17 16;17 18;...
       19 18;19 20;21 16;17 22;18 22;18 23;19 24;20 25;...
       21 22;22 21;23 24;24 25];
    [eu,cEu]=grIsEulerian(E);
    switch eu,
      case 1,
        st='';
        E=[E(cEu,1:2), [1:size(E,1)]'];
      case 0.5,
        st='semi-';
        E=[E(cEu,1:2), [1:size(E,1)]'];
      otherwise,
        st='not ';
        E=[E(:,1:2), [1:size(E,1)]'];
    end
    grPlot(V,[E,[1:size(E,1)]'],'g','');
    title(['\bf This graph is ' st 'Eulerian'])
  case 12, % grMaxComSu test
    disp('The grMaxComSu test')
    V=[0 0 2;1 1 3;1 0 3;1 -1 4;2 1 1;2 0 2;2 -1 3;3 1 4;...
       3 0 5;3 -1 1;4 0 5]; % vertexes coordinates and weights
    E=[1 2;1 3;1 4;2 3;3 4;2 5;2 6;3 6;3 7;4 7;5 6;6 7;...
       5 8;6 8;6 9;7 9;7 10;8 9;9 10;8 11;9 11;10 11]; % edges
    grPlot(V(:,1:2),E,'g','%d',''); % the initial graph
    title('\bfThe initial graph')
    grPlot(V,E,'g','%d',''); % the initial graph
    title('\bfThe initial graph with weighed vertexes')
    nMS=grMaxComSu(E); % the maximal complete sugraph
    fprintf('Number of vertexes on the maximal complete sugraph = %d\n',...
      length(nMS));
    disp('In a maximal complete sugraph is the vertexes with numbers:');
    fprintf('%d  ',nMS);
    fprintf('\nThe total weight = %d\n',sum(V(nMS,3)));
    nMS=grMaxComSu(E,V(:,3)); % the weightd maximal complete sugraph
    fprintf(['Number of vertexes on the weighed maximal complete sugraph '...
      '= %d\n'],length(nMS));
    disp('In a weighed maximal complete sugraph is the vertexes with numbers:');
    fprintf('%d  ',nMS);
    fprintf('\nThe total weight = %d\n',sum(V(nMS,3)));
  case 13, % grMaxFlows test
    disp('The grMaxFlows test')
    V=[0 0;1 1;1 0;1 -1;2 1;2 0;2 -1;3 1;...
       3 0;3 -1;4 0]; % vertexes coordinates
    E=[1 2 5;1 3 5;1 4 5;2 3 2;3 4 2;2 5 3;...
       2 6 2;3 6 5;3 7 2;4 7 3;5 6 1;6 7 1;...
       5 8 5;6 8 2;6 9 3;7 9 2;7 10 3;8 9 2;...
       9 10 2;8 11 5;9 11 4;10 11 4]; % arrows and weights
    s=1; % the network source
    t=11; % the network sink
    fprintf('The source of the net s=%d\nThe sink of the net t=%d\n',s,t)
    grPlot(V,E,'d','','%d'); % the initial digraph
    title('\bfThe digraph of the net')
    [v,mf]=grMaxFlows(E,s,t); % the maximal flow
    disp('The solution of the maximal flows problem')
    disp('  N arrow       flow')
    fprintf('   %2.0f      %12.8f\n',[[1:length(v)];v'])
    fprintf('The maximal flow =%12.8f\n',mf)
    grPlot(V,[E(:,1:2),v],'d','','%6.4f'); % plot the digraph
    title('\bfThe flows on the arrows')
  case 14, % grMaxMatch test
    disp('The grMaxMatch test')
    V=[0 0;1 1;1 0;1 -1;2 1;2 0;2 -1;3 1;...
       3 0;3 -1;4 0]; % vertexes coordinates
    E=[1 2 5;1 3 5;1 4 5;2 3 2;3 4 2;2 5 3;...
       2 6 2;3 6 5;3 7 2;4 7 3;5 6 1;6 7 1;...
       5 8 5;6 8 2;6 9 3;7 9 2;7 10 3;8 9 2;...
       9 10 2;8 11 5;9 11 4;10 11 4]; % arrows and weights
    grPlot(V,E,'g','','%d'); % the initial graph
    title('\bfThe initial graph with weighed edges')
    nMM=grMaxMatch(E(:,1:2)); % the maximal matching
    fprintf('Number of edges on the maximal matching = %d\n',...
      length(nMM));
    disp('In a maximal matching is the edges with numbers:');
    fprintf('%d  ',nMM);
    fprintf('\nThe total weight = %d\n',sum(E(nMM,3)));
    grPlot(V,E(nMM,:),'g','','%d'); % the maximal matching
    title('\bfThe maximal matching')
    nMM=grMaxMatch(E); % the weighed maximal matching
    fprintf('Number of edges on the weighed maximal matching = %d\n',...
      length(nMM));
    disp('In a weighed maximal matching is the edges with numbers:');
    fprintf('%d  ',nMM);
    fprintf('\nThe total weight = %d\n',sum(E(nMM,3)));
    grPlot(V,E(nMM,:),'g','','%d'); % the weighed maximal matching
    title('\bfThe weighed maximal matching')
  case 15, % grMaxStabSet test
    disp('The grMaxStabSet test')
    V=[0 0 2;1 1 3;1 0 3;1 -1 4;2 1 1;2 0 2;2 -1 3;3 1 4;...
       3 0 5;3 -1 1;4 0 5]; % vertexes coordinates and weights
    E=[1 2;1 3;1 4;2 3;3 4;2 5;2 6;3 6;3 7;4 7;5 6;6 7;...
       5 8;6 8;6 9;7 9;7 10;8 9;9 10;8 11;9 11;10 11]; % edges
    grPlot(V(:,1:2),E,'g','%d',''); % the initial graph
    title('\bfThe initial graph')
    nMS=grMaxStabSet(E); % the maximal stable set
    fprintf('Number of vertexes on the maximal stable set = %d\n',...
      length(nMS));
    disp('In a maximal stable set is the vertexes with numbers:');
    fprintf('%d  ',nMS);
    fprintf('\nThe total weight = %d\n',sum(V(nMS,3)));
    grPlot(V,E,'g','%d',''); % the initial graph
    title('\bfThe initial graph with weighed vertexes')
    nMS=grMaxStabSet(E,V(:,3)); % the weightd maximal stable set
    fprintf(['Number of vertexes on the weighed maximal stable set '...
      '= %d\n'],length(nMS));
    disp('In a weighed maximal stable set is the vertexes with numbers:');
    fprintf('%d  ',nMS);
    fprintf('\nThe total weight = %d\n',sum(V(nMS,3)));
  case 16, % grMinAbsEdgeSet test
    disp('The grMinAbsEdgeSet test')
    V=[0 0;1 1;1 0;1 -1;2 1;2 0;2 -1;3 1;...
       3 0;3 -1;4 0]; % vertexes coordinates
    E=[1 2 5;1 3 5;1 4 5;2 3 2;3 4 2;2 5 3;...
       2 6 2;3 6 5;3 7 2;4 7 3;5 6 1;6 7 1;...
       5 8 5;6 8 2;6 9 3;7 9 2;7 10 3;8 9 4;...
       9 10 5;8 11 5;9 11 4;10 11 4]; % arrows and weights
    grPlot(V,E,'g','','%d'); % the initial graph
    title('\bfThe initial graph with weighed edges')
    nMS=grMinAbsEdgeSet(E(:,1:2)); % the minimal absorbant set of edges
    fprintf('Number of edges on the minimal absorbant set = %d\n',...
      length(nMS));
    disp('In a minimal absorbant set is the edges with numbers:');
    fprintf('%d  ',nMS);
    fprintf('\nThe total weight = %d\n',sum(E(nMS,3)));
    grPlot(V,E(nMS,:),'g','','%d'); % the minimal absorbant set of edges
    title('\bfThe minimal absorbant set of edges')
    nMS=grMinAbsEdgeSet(E); % the minimal weighed absorbant set of edges
    fprintf('Number of edges on the minimal weighed absorbant set = %d\n',...
      length(nMS));
    disp('In a minimal weighed absorbant set is the edges with numbers:');
    fprintf('%d  ',nMS);
    fprintf('\nThe total weight = %d\n',sum(E(nMS,3)));
    grPlot(V,E(nMS,:),'g','','%d'); % the minimal weighed absorbant set of edges
    title('\bfThe minimal weighed absorbant set of edges')
  case 17, % grMinAbsVerSet test
    disp('The grMinAbsVerSet test')
    V=[0 0 2;1 1 3;1 0 3;1 -1 4;2 1 1;2 0 2;2 -1 3;3 1 4;...
       3 0 5;3 -1 1;4 0 5]; % vertexes coordinates and weights
    E=[1 2;1 3;1 4;2 3;3 4;2 5;2 6;3 6;3 7;4 7;5 6;6 7;...
       5 8;6 8;6 9;7 9;7 10;8 9;9 10;8 11;9 11;10 11]; % edges
    grPlot(V(:,1:2),E,'g','%d',''); % the initial graph
    title('\bfThe initial graph')
    grPlot(V,E,'g','%d',''); % the initial graph
    title('\bfThe initial graph with weighed vertexes')
    nMS=grMinAbsVerSet(E); % the minimal absorbant set of vertexes
    fprintf('Number of vertexes on the minimal absorbant set = %d\n',...
      length(nMS));
    disp('In a minimal absorbant set is the vertexes with numbers:');
    fprintf('%d  ',nMS);
    fprintf('\nThe total weight = %d\n',sum(V(nMS,3)));
    nMS=grMinAbsVerSet(E,V(:,3)); % the weightd minimal absorbant set of vertexes
    fprintf(['Number of vertexes on the weighed minimal absorbant set '...
      '= %d\n'],length(nMS));
    disp('In a weighed minimal absorbant set is the vertexes with numbers:');
    fprintf('%d  ',nMS);
    fprintf('\nThe total weight = %d\n',sum(V(nMS,3)));
  case 18, % grMinCutSet test
    disp('The grMinCutSet test')
    V=[0 0;1 1;1 0;1 -1;2 1;2 0;2 -1;3 1;...
       3 0;3 -1;4 0]; % vertexes coordinates
    E=[1 2 5;1 3 5;1 4 5;2 3 2;3 4 2;2 5 3;...
       2 6 2;3 6 5;3 7 2;4 7 3;5 6 1;6 7 1;...
       5 8 5;6 8 2;6 9 3;7 9 2;7 10 3;8 9 2;...
       9 10 2;8 11 5;9 11 4;10 11 4]; % arrows and weights
    s=1; % the network source
    t=11; % the network sink
    fprintf('The source of the net s=%d\nThe sink of the net t=%d\n',s,t)
    grPlot(V,E,'d','','%d'); % the initial digraph
    title('\bfThe digraph of the net')
    [nMCS,mf]=grMinCutSet(E,s,t); % the minimal cut-set
    fprintf('The first minimal cut-set include arrows:');
    fprintf('  %d',nMCS);
    fprintf(['\nThe maximal flow through '...
      'each minimal cut-set = %12.6f\n'],mf)
    grPlot(V,E(setdiff(1:size(E,1),nMCS),:),'d','','%d');
    title('\bfThe digraph without first minimal cut-set')
  case 19, % grMinEdgeCover test
    disp('The grMinEdgeCover test')
    V=[0 0;1 1;1 0;1 -1;2 1;2 0;2 -1;3 1;...
       3 0;3 -1;4 0]; % vertexes coordinates and weights
    E=[1 2 5;1 3 5;1 4 5;2 3 2;3 4 2;2 5 3;2 6 2;3 6 5;...
       3 7 2;4 7 3;5 6 1;6 7 1;5 8 5;6 8 2;6 9 3;7 9 2;...
       7 10 3;8 9 2;9 10 2;8 11 5;9 11 4;10 11 4]; % edges and weights
    grPlot(V,E,'g',''); % the initial graph
    title('\bfThe initial graph with weighed edges')
    nMC=grMinEdgeCover(E(:,1:2)); % the minimal edge covering
    fprintf('Number of edges on the minimal edge covering = %d\n',...
      length(nMC));
    disp('In a minimal edge cover is the edges with numbers:');
    fprintf('%d  ',nMC);
    fprintf('\nThe total weight = %d\n',sum(E(nMC,3)));
    grPlot(V,E(nMC,:),'g',''); % the minimal edge covering
    title('\bfThe minimal edge covering')
    nMC=grMinEdgeCover(E); % the weighed minimal edge covering
    fprintf('Number of edges on the weighed minimal edge covering = %d\n',...
      length(nMC));
    disp('In a weighed minimal edge cover is the edges with numbers:');
    fprintf('%d  ',nMC);
    fprintf('\nThe total weight = %d\n',sum(E(nMC,3)));
    grPlot(V,E(nMC,:),'g',''); % the weighed minimal edge covering
    title('\bfThe weighed minimal edge covering')
  case 20, % grMinSpanTree test
    disp('The grMinSpanTree test')
    V=[0 4;1 4;2 4;3 4;4 4;0 3;1 3;2 3;3 3;4 3;...
       0 2;1 2;2 2;3 2;4 2;0 1;1 1;2 1;3 1;4 1;...
       0 0;1 0;2 0;3 0;4 0];
    E=[1 2 1;3 2 2;4 3 3;5 4 4;6 1 5;2 7 6;8 2 7;3 8 8;...
       9 4 9;9 5 8;10 5 7;7 6 6;8 7 5;8 9 4;10 9 3;11 6 2;...
       7 12 1;13 8 2;14 9 3;15 10 4;12 11 5;13 12 6;13 14 7;...
       14 13 8;5 5 10;15 14 9;16 11 8;12 17 7;13 18 6;...
       20 15 5;17 16 4;17 18 3;18 17 2;19 18 1;19 20 2;...
       5 5 8; 21 16 3;17 22 4;18 22 5;22 18 6;18 23 7;...
       19 24 8;20 25 9;21 22 8;22 21 7;23 24 6;10 10 8;...
       24 23 5;24 25 4];
    grPlot(V,E); % the initial graph
    title('\bfThe initial graph with weighed edges')
    nMST=grMinSpanTree(E(:,1:2)); % the spanning tree
    fprintf('Number of edges on the spanning tree = %d\n',length(nMST));
    fprintf('The total weight = %d\n',sum(E(nMST,3)));
    grPlot(V,E(nMST,:)); % the spanning tree
    title('\bfThe spanning tree')
    nMST=grMinSpanTree(E); % the minimal spanning tree
    fprintf('Number of edges on the minimal spanning tree = %d\n',...
      length(nMST));
    fprintf('The total weight = %d\n',sum(E(nMST,3)));
    grPlot(V,E(nMST,:)); % the minimal spanning tree
    title('\bfThe minimal spanning tree')
  case 21, % grMinVerCover test
    disp('The grMinVerCover test')
    V=[0 0 2;1 1 3;1 0 3;1 -1 4;2 1 1;2 0 2;2 -1 3;3 1 4;...
       3 0 7;3 -1 1;4 0 5]; % vertexes coordinates and weights
    E=[1 2;1 3;1 4;2 3;3 4;2 5;2 6;3 6;3 7;4 7;6 5;6 7;...
       5 8;6 8;6 9;7 9;7 10;8 9;9 10;8 11;9 11;10 11]; % edges
    grPlot(V,E,'g','%d',''); % the initial graph
    title('\bfThe initial graph with weighed vertexes')
    nMC=grMinVerCover(E); % the minimal vertex cover
    fprintf('Number of vertexes on the minimal vertex cover = %d\n',...
      length(nMC));
    disp('In a minimal vertex cover is the vertexes with numbers:');
    fprintf('%d  ',nMC);
    fprintf('\nThe total weight = %d\n',sum(V(nMC,3)));
    grPlot(V(nMC,:)); % the solution of the MinVerCover problem
    title('\bfThe minimal vertex cover')
    nMC=grMinVerCover(E,V(:,3)); % the weightd minimal vertex cover
    fprintf(['Number of vertexes on the weighed minimal vertex cover '...
      '= %d\n'],length(nMC));
    disp('In a weighed minimal vertex cover is the vertexes with numbers:');
    fprintf('%d  ',nMC);
    fprintf('\nThe total weight = %d\n',sum(V(nMC,3)));
    grPlot(V(nMC,:)); % the solution of the weighed MinVerCover problem
    title('\bfThe weighed minimal vertex cover')
  case 22, % grPERT test
    disp('The grPERT test')
    V=[1 1;0 0;1 0;1 -1;2 1;2 0;2 -1;3 1;...
       4 0;3 -1;3 0]; % events coordinates
    E=[2 1 5;2 3 5;2 4 5;1 3 2;3 4 2;1 5 3;...
       1 6 2;3 6 5;3 7 2;4 7 3;5 6 1;6 7 1;...
       5 8 5;6 8 2;6 11 3;7 11 2;7 10 3;8 11 2;...
       11 10 2;8 9 5;11 9 4;10 9 4]; % works and their times
    grPlot(V,E,'d','%d','%d');
    title('\bfThe schema of project')
    [CrP,Ts,Td]=grPERT(E);
    grPlot([V Ts'],[CrP(1:end-1);CrP(2:end)]','d','%d','');
    title('\bfThe critical path and start times for events')
    grPlot([V Ts'],[E(:,1:2) Td],'d','%d','%d')
    title('\bfThe start times for events and delay times for works')
  case 23, % grPlot test
    disp('The grPlot test')
    V=[0 0 2;1 1 3;1 0 3;1 -1 4;2 1 1;2 0 2;2 -1 3;3 1 4;...
       3 0 5;3 -1 1;4 0 5]; % vertexes coordinates and weights
    E=[1 2 5;1 1 2;1 1 5;2 2 3;1 3 5;1 4 5;2 3 2;3 4 2;2 5 3;2 6 2;3 6 5;3 7 2;...
       4 7 3;5 6 1;6 7 1;5 8 5;6 8 2;6 9 3;7 9 2;7 10 3;8 9 2;...
       9 10 2;8 11 5;9 11 4;10 11 4;1 2 8;1 3 4;1 3 5;1 3 6]; % edges (arrows) and weights
    grPlot(V(:,1:2),E,'d');
    title('\bfThe digraph with weighed multiple arrows and loops')
    grPlot(V,E(:,1:2),[],'%d','');
    title('\bfThe graph with weighed vertexes without edges numeration')
    grPlot(V(:,1:2));
    title('\bfThe disconnected graph')
    grPlot([],fullfact([5 5]),'d')
    title('\bfThe directed clique\rm \itK\rm_5')
  case 24, % grShortPath test
    disp('The grShortPath test')
    V=[0 0;1 1;1 0;1 -1;2 1;2 0;2 -1;3 1;...
       3 0;3 -1;4 0]; % vertexes coordinates
    E=[1 2 5;1 3 5;1 4 5;2 3 2;3 4 2;2 5 3;...
       2 6 2;3 6 5;3 7 2;4 7 3;5 6 1;6 7 1;...
       5 8 5;6 8 2;6 9 3;7 9 2;7 10 3;8 9 2;...
       9 10 2;8 11 5;9 11 4;10 11 4]; % arrows and weights
    s=1; % the network source
    t=11; % the network sink
    fprintf('The source of the net s=%d\nThe sink of the net t=%d\n',s,t)
    grPlot(V(:,1:2),E,'d','','%d');
    title('\bfThe digraph with weighed edges')
    [dSP,sp]=grShortPath(E,s,t);
    disp('The shortest paths between all vertexes:');
    fprintf('    %2.0f',1:size(dSP,2));
    fprintf('\n');
    for k1=1:size(dSP,1),
      fprintf('%2.0f',k1)
      fprintf('%6.2f',dSP(k1,:))
      fprintf('\n')
    end
    grPlot(V(:,1:2),[sp(1:end-1);sp(2:end)]','d','%d','')
    title(['\bfThe shortest path from vertex ' ...
      num2str(s) ' to vertex ' num2str(t)])
  case 25, % grTravSale test
    disp('The grTravSale test')
%    C=[0 3 7 4 6 4;4 0 3 7 8 5;6 9 0 3 2 1;...
%       8 6 3 0 9 8;3 7 4 6 0 4;4 5 8 7 2 0];
    C=[0 16827.953945741592 16540.792060841584 ...
      16540.792060841584 16843.983614335415;...
      16827.953945741592 0 1558.8328967532088 ...
      1558.8328967532088 81.59656855530139;...
      16540.792060841584 1558.8328967532088 0 ...
      0 1484.9249139266267;...
      16540.792060841584 1558.8328967532088 0 ...
      0 1484.9249139266267;
      16827.953945741592 81.59656855530139 1484.9249139266267 ...
      1484.9249139266267 0];
    disp('The distances between cities:')
    fprintf('  %18.0f',1:size(C,2))
    fprintf('\n')
    for k1=1:size(C,1),
      fprintf('%2.0f',k1)
      fprintf('%20.12f',C(k1,:))
      fprintf('\n')
    end
    [pTS,fmin]=grTravSale(C);
    disp('The order of cities:')
    fprintf('%d   ',pTS)
    fprintf('\nThe minimal way =%3.0f\n',fmin)
  otherwise,
    error('Select the test')
end