function varargout = SVR(varargin)
% SVR M-file for SVR.fig
%      SVR, by itself, creates a new SVR or raises the existing
%      singleton*.
%
%      H = SVR returns the handle to a new SVR or the handle to
%      the existing singleton*.
%
%      SVR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SVR.M with the given input arguments.
%
%      SVR('Property','Value',...) creates a new SVR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SVR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SVR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SVR

% Last Modified by GUIDE v2.5 02-Feb-2010 20:16:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SVR_OpeningFcn, ...
                   'gui_OutputFcn',  @SVR_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SVR is made visible.
function SVR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SVR (see VARARGIN)

% Choose default command line output for SVR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SVR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SVR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
SVM_GUI;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname,filterindex] = uigetfile({'*.mat';'*.*'},'load data');

if filterindex
    filename=strcat(pathname,filename);
    datatemp = load(filename);
    global TRAIN_DATA TRAIN_LABEL TEST_DATA TEST_LABEL
    global testflag
    testflag = 1;
    TRAIN_DATA = datatemp.train_x;
    TRAIN_LABEL = datatemp.train_y;
    if length(fieldnames(datatemp)) == 2
        TEST_DATA = TRAIN_DATA;
        TEST_LABEL = TRAIN_LABEL;
        testflag = 0;
    else
        TEST_DATA = datatemp.test_x;
        TEST_LABEL = datatemp.test_y;
    end
    
    [trains,traind] = size(TRAIN_DATA);
    [tests,testd] = size(TEST_DATA); 
    global mystring
    mystring = [];
    mystring = {'实时信息提示'};
    line1 = ['数据载入完毕!'];
    line2 = ['训练集：',num2str(trains),'个样本,样本维数',num2str(traind)];
    line3 = ['测试集：',num2str(tests),'个样本,样本维数',num2str(testd)];
    mystring{length(mystring)+1,1} = line1;
    mystring{length(mystring)+1,1} = line2;
    mystring{length(mystring)+1,1} = line3;
    set(handles.info,'String',mystring);
end

guidata(hObject, handles);

% --- Executes on button press in SVR.
function SVR_Callback(hObject, eventdata, handles)
% hObject    handle to SVR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TRAIN_DATA TRAIN_LABEL TEST_DATA TEST_LABEL
global testflag
global mystring
mystring = [];
%
TrainL = TRAIN_LABEL;
Train = TRAIN_DATA;
TestL = TEST_LABEL;
Test = TEST_DATA;

% xscaleflag
xscaleflag = get(handles.xscale,'Value');
switch xscaleflag
    case 1
        [Train,Test] = scaleForSVM(Train,Test,-1,1);
        line1 = ['自变量归一化完毕!'];
        line2 = ['数据被规整到[-1,1]范围内'];
        mystring{length(mystring)+1,1} = line1;
        mystring{length(mystring)+1,1} = line2;
        set(handles.info,'String',mystring);
    case 2
        [Train,Test] = scaleForSVM(Train,Test,0,1);
        line1 = ['自变量归一化完毕!'];
        line2 = ['数据被规整到[0,1]范围内'];
        mystring{length(mystring)+1,1} = line1;
        mystring{length(mystring)+1,1} = line2;
        set(handles.info,'String',mystring);
    case 3
        nothing = 0;
    case 4
        lower = str2num( get(handles.min,'String') );
        upper = str2num( get(handles.max,'String') );
        [Train,Test] = scaleForSVM(Train,Test,lower,upper);    
        line1 = ['自变量归一化完毕!'];
        line2 = ['数据被规整到','[',num2str(lower),',',num2str(upper),']','范围内'];
        mystring{length(mystring)+1,1} = line1;
        mystring{length(mystring)+1,1} = line2;
        set(handles.info,'String',mystring);
end

% yscaleflag
yscaleflag = get(handles.yscale,'Value');
global ps
switch yscaleflag
    case 1
        [TrainL,TestL,ps] = scaleForSVM(TrainL,TestL,-1,1);
        line1 = ['因变量归一化完毕!'];
        line2 = ['数据被规整到[-1,1]范围内'];
        mystring{length(mystring)+1,1} = line1;
        mystring{length(mystring)+1,1} = line2;
        set(handles.info,'String',mystring);
    case 2
        [TrainL,TestL,ps] = scaleForSVM(TrainL,TestL,0,1);
        line1 = ['因变量归一化完毕!'];
        line2 = ['数据被规整到[0,1]范围内'];
        mystring{length(mystring)+1,1} = line1;
        mystring{length(mystring)+1,1} = line2;
        set(handles.info,'String',mystring);
    case 3
        nothing = 0;
    case 4
        lower = str2num( get(handles.ymin,'String') );
        upper = str2num( get(handles.ymax,'String') );
        [TrainL,TestL,ps] = scaleForSVM(TrainL,TestL,lower,upper);    
        line1 = ['因变量归一化完毕!'];
        line2 = ['数据被规整到','[',num2str(lower),',',num2str(upper),']','范围内'];
        mystring{length(mystring)+1,1} = line1;
        mystring{length(mystring)+1,1} = line2;
        set(handles.info,'String',mystring);
end

% pcaflag
pcaflag = get(handles.pca,'Value');
switch pcaflag
    case 1
        line1 = ['pca降维预处理开始...'];
        mystring{length(mystring)+1,1} = line1;
        set(handles.info,'String',mystring);
        
        threshold = str2num(get(handles.percent,'String'));
        [mtrain,ntrain] = size(Train);
        [mtest,ntest] = size(Test);
        dataset = [Train;Test];
        [dataset_coef,dataset_score,dataset_latent,dataset_t2] = princomp(dataset);
        dataset_cumsum = 100*cumsum(dataset_latent)./sum(dataset_latent);
        index = find(dataset_cumsum >= threshold);
        percent_explained = 100*dataset_latent/sum(dataset_latent);
        axes(handles.axesB);
        cla reset;
        pareto(percent_explained);
        set(gcf,'Nextplot','add');
        xlabel('Principal Component');
        ylabel('Variance Explained (%)');
        grid on;
        Train = dataset_score(1:mtrain,:);
        Test = dataset_score( (mtrain+1):(mtrain+mtest),: );
        Train = Train(:,1:index(1));
        Test = Test(:,1:index(1));
        
        [trains,traind] = size(TRAIN_DATA);
        line1 = ['pca降维预处理完毕！'];
        line2 = ['样本维数由',num2str(traind),'变为',num2str(size(Train,2))];
        mystring{length(mystring)+1,1} = line1;
        mystring{length(mystring)+1,1} = line2;
        set(handles.info,'String',mystring);
        
    case 2
        nothing = 0;
        axes(handles.axesB);
        cla reset;
end
% findflag
findflag = get(handles.find,'Value');
switch findflag
    case 1
        
        line1 = '参数寻优开始(grid search method)...';
        mystring{length(mystring)+1,1} = line1;
        set(handles.info,'String',mystring);
        
        train = Train;
        train_label = TrainL;
        cmin = str2num(get(handles.gridcmin,'String'));
        cmax = str2num(get(handles.gridcmax,'String'));;
        gmin = str2num(get(handles.gridgmin,'String'));;
        gmax = str2num(get(handles.gridgmax,'String'));;
        v = str2num(get(handles.v,'String'));
        cstep = str2num(get(handles.gridcstep,'String'));
        gstep = str2num(get(handles.gridgstep,'String'));
        [X,Y] = meshgrid(cmin:cstep:cmax,gmin:gstep:gmax);
        [m,n] = size(X);
        cg = zeros(m,n);
        
        eps = 10^(-4);
        
        %% record acc with different c & g,and find the bestacc with the smallest c
        bestc = 1;
        bestg = 0.1;
        mse = Inf; % mse
        basenum = 2;
        for i = 1:m
            for j = 1:n
                cmd = ['-v ',num2str(v),' -c ',num2str( basenum^X(i,j) ),' -g ',num2str( basenum^Y(i,j) ),' -s 3 -p 0.1'];
                cg(i,j) = svmtrain(train_label, train, cmd);
                
                if cg(i,j) < mse
                    mse = cg(i,j);
                    bestc = basenum^X(i,j);
                    bestg = basenum^Y(i,j);
                end
                
                if abs( cg(i,j)-mse )<=eps && bestc > basenum^X(i,j)
                    mse = cg(i,j);
                    bestc = basenum^X(i,j);
                    bestg = basenum^Y(i,j);
                end
                
            end
        end
        str = ['CVmse = ',num2str(mse)];
        set(handles.CVaccuracy,'String',str);
        str = ['best c = ',num2str(bestc)];
        set(handles.bestc,'String',str);
        str = ['best g = ',num2str(bestg)];
        set(handles.bestg,'String',str);
        %% to draw the acc with different c & g
        axes(handles.axesA);
        cla reset;
        view(3);
        meshc(X,Y,cg);
        axis auto;
        xlabel('log2c','FontSize',12);
        ylabel('log2g','FontSize',12);
        zlabel('MSE','FontSize',12);
        firstline = 'SVR参数选择结果图(3D视图)[GridSearchMethod]';
        secondline = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
            ' CVmse=',num2str(mse)];
        title({firstline;secondline},'Fontsize',12);
        
        cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.1'];
        
        line1 = '参数寻优完毕(grid search method)';
        mystring{length(mystring)+1,1} = line1;
        set(handles.info,'String',mystring);        
    case 2
        line1 = '参数寻优开始(ga method)...';
        mystring{length(mystring)+1,1} = line1;
        set(handles.info,'String',mystring);        
        
        train_data = Train;
        train_label = TrainL;
        
        ga_option = struct('maxgen',100,'sizepop',20,'ggap',0.9,...
            'cbound',[0,100],'gbound',[0,100],'v',5);
        
        ga_option.maxgen = str2num(get(handles.maxgen,'String'));
        ga_option.sizepop = str2num(get(handles.sizepop,'String'));
        ga_option.cbound = [str2num(get(handles.cmin,'String')),str2num(get(handles.cmax,'String'))];
        ga_option.gbound = [str2num(get(handles.gmin,'String')),str2num(get(handles.gmax,'String'))];
        ga_option.v = str2num(get(handles.v,'String'));
        
        MAXGEN = ga_option.maxgen;
        NIND = ga_option.sizepop;
        NVAR = 2;
        PRECI = 20;
        GGAP = ga_option.ggap;
        trace = zeros(MAXGEN,2);
        
        FieldID = ...
            [rep([PRECI],[1,NVAR]);[ga_option.cbound(1),ga_option.gbound(1);ga_option.cbound(2),ga_option.gbound(2)]; ...
            [1,1;0,0;0,1;1,1]];
        
        Chrom = crtbp(NIND,NVAR*PRECI);
        
        gen = 1;
        v = ga_option.v;
        BestMSE = inf;
        Bestc = 0;
        Bestg = 0;
        %%
        cg = bs2rv(Chrom,FieldID);
        
        for nind = 1:NIND
            cmd = ['-v ',num2str(v),' -c ',num2str(cg(nind,1)),' -g ',num2str(cg(nind,2)),' -s 3 -p 0.01'];
            ObjV(nind,1) = svmtrain(train_label,train_data,cmd);
        end
        [BestMSE,I] = min(ObjV);
        Bestc = cg(I,1);
        Bestg = cg(I,2);
        
        %%
        for gen = 1:MAXGEN
            FitnV = ranking(ObjV);
            
            SelCh = select('sus',Chrom,FitnV,GGAP);
            SelCh = recombin('xovsp',SelCh,0.7);
            SelCh = mut(SelCh);
            
            cg = bs2rv(SelCh,FieldID);
            for nind = 1:size(SelCh,1)
                cmd = ['-v ',num2str(v),' -c ',num2str(cg(nind,1)),' -g ',num2str(cg(nind,2))];
                ObjVSel(nind,1) = svmtrain(train_label,train_data,cmd);
            end
            
            [Chrom,ObjV] = reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            
            [NewBestCVaccuracy,I] = max(ObjV);
            cg_temp = bs2rv(Chrom,FieldID);
            temp_NewBestCVaccuracy = NewBestCVaccuracy;
            
            if NewBestCVaccuracy < BestMSE
                BestMSE = NewBestCVaccuracy;
                Bestc = cg_temp(I,1);
                Bestg = cg_temp(I,2);
            end
            
            if abs( NewBestCVaccuracy-BestMSE ) <= 10^(-2) && ...
                    cg_temp(I,1) < Bestc
                BestMSE = NewBestCVaccuracy;
                Bestc = cg_temp(I,1);
                Bestg = cg_temp(I,2);
            end
            trace(gen,1) = max(ObjV);
            trace(gen,2) = sum(ObjV)/length(ObjV);
        end
        str = ['CVmse = ',num2str(BestMSE)];
        set(handles.CVaccuracy,'String',str);
        str = ['best c = ',num2str(Bestc)];
        set(handles.bestc,'String',str);
        str = ['best g = ',num2str(Bestg)];
        set(handles.bestg,'String',str);
        axes(handles.axesA);
        cla reset;
        view(2);
        hold on;
        trace = round(trace*10000)/10000;
        plot(trace(1:gen,1),'r*-','LineWidth',1.5);
        plot(trace(1:gen,2),'o-','LineWidth',1.5);
        legend('最佳适应度','平均适应度');
        xlabel('进化代数','FontSize',12);
        ylabel('适应度','FontSize',12);
        grid on;
        axis auto;
        line1 = '适应度曲线MSE[GAmethod]';
        line2 = ['(终止代数=', ...
            num2str(gen),',种群数量pop=', ...
            num2str(NIND),')'];
        line3 = ['Best c=',num2str(Bestc),' g=',num2str(Bestg), ...
            ' CVmse=',num2str(BestMSE),'%'];
        title({line1;line2;line3},'FontSize',12);
        cmd = ['-c ',num2str(Bestc),' -g ',num2str(Bestg),' -s 3 -p 0.1'];
        
        line1 = '参数寻优完毕(ga method)';
        mystring{length(mystring)+1,1} = line1;
        set(handles.info,'String',mystring);          
    case 3
        line1 = '参数寻优开始(pso method)...';
        mystring{length(mystring)+1,1} = line1;
        set(handles.info,'String',mystring);          
        train = Train;
        train_label = TrainL;
        pso_option = struct('c1',1.5,'c2',1.7,'maxgen',100,'sizepop',20, ...
            'k',0.6,'wV',1,'wP',1,'v',5, ...
            'popcmax',10^2,'popcmin',10^(-1),'popgmax',10^3,'popgmin',10^(-2));
       
        pso_option.maxgen = str2num(get(handles.maxgen,'String'));
        pso_option.sizepop = str2num(get(handles.sizepop,'String'));
        pso_option.popcmin = str2num(get(handles.cmin,'String'))+0.01;
        pso_option.popcmax = str2num(get(handles.cmax,'String'));
        pso_option.popgmin = str2num(get(handles.gmin,'String'))+0.01;
        pso_option.popgmax = str2num(get(handles.gmax,'String'));
        pso_option.v = str2num(get(handles.v,'String'));  
        
        Vcmax = pso_option.k*pso_option.popcmax;
        Vcmin = -Vcmax ;
        Vgmax = pso_option.k*pso_option.popgmax;
        Vgmin = -Vgmax ;
        
        eps = 10^(-3);
        %% 产生初始粒子和速度
        for i=1:pso_option.sizepop
            
            % 随机产生种群和速度
            pop(i,1) = (pso_option.popcmax-pso_option.popcmin)*rand+pso_option.popcmin;
            pop(i,2) = (pso_option.popgmax-pso_option.popgmin)*rand+pso_option.popgmin;
            V(i,1)=Vcmax*rands(1,1);
            V(i,2)=Vgmax*rands(1,1);
            
            % 计算初始适应度
            cmd = ['-v ',num2str(pso_option.v),' -c ',num2str( pop(i,1) ),' -g ',num2str( pop(i,2) ),' -s 3 -p 0.1'];
            fitness(i) = svmtrain(train_label, train, cmd);
        end
        
        % 找极值和极值点
        [global_fitness bestindex]=min(fitness); % 全局极值
        local_fitness=fitness;   % 个体极值初始化
        
        global_x=pop(bestindex,:);   % 全局极值点
        local_x=pop;    % 个体极值点初始化
        
        % 每一代种群的平均适应度
        avgfitness_gen = zeros(1,pso_option.maxgen);
        
        %% 迭代寻优
        for i=1:pso_option.maxgen
            
            for j=1:pso_option.sizepop
                
                %速度更新
                V(j,:) = pso_option.wV*V(j,:) + pso_option.c1*rand*(local_x(j,:) - pop(j,:)) + pso_option.c2*rand*(global_x - pop(j,:));
                if V(j,1) > Vcmax
                    V(j,1) = Vcmax;
                end
                if V(j,1) < Vcmin
                    V(j,1) = Vcmin;
                end
                if V(j,2) > Vgmax
                    V(j,2) = Vgmax;
                end
                if V(j,2) < Vgmin
                    V(j,2) = Vgmin;
                end
                
                %种群更新
                pop(j,:)=pop(j,:) + pso_option.wP*V(j,:);
                if pop(j,1) > pso_option.popcmax
                    pop(j,1) = pso_option.popcmax;
                end
                if pop(j,1) < pso_option.popcmin
                    pop(j,1) = pso_option.popcmin;
                end
                if pop(j,2) > pso_option.popgmax
                    pop(j,2) = pso_option.popgmax;
                end
                if pop(j,2) < pso_option.popgmin
                    pop(j,2) = pso_option.popgmin;
                end
                
                % 自适应粒子变异
                if rand>0.5
                    k=ceil(2*rand);
                    if k == 1
                        pop(j,k) = (20-1)*rand+1;
                    end
                    if k == 2
                        pop(j,k) = (pso_option.popgmax-pso_option.popgmin)*rand + pso_option.popgmin;
                    end
                end
                
                %适应度值
                cmd = ['-v ',num2str(pso_option.v),' -c ',num2str( pop(j,1) ),' -g ',num2str( pop(j,2) ),' -s 3 -p 0.1'];
                fitness(j) = svmtrain(train_label, train, cmd);     
                
                %个体最优更新
                if fitness(j) < local_fitness(j)
                    local_x(j,:) = pop(j,:);
                    local_fitness(j) = fitness(j);
                end
                
                if abs( fitness(j)-local_fitness(j) )<=eps && pop(j,1) < local_x(j,1)
                    local_x(j,:) = pop(j,:);
                    local_fitness(j) = fitness(j);
                end
                
                %群体最优更新
                if fitness(j) < global_fitness
                    global_x = pop(j,:);
                    global_fitness = fitness(j);
                end
                
                if abs( fitness(j)-global_fitness )<=eps && pop(j,1) < global_x(1)
                    global_x = pop(j,:);
                    global_fitness = fitness(j);
                end
                
            end
            
            fit_gen(i) = global_fitness;
            avgfitness_gen(i) = sum(fitness)/pso_option.sizepop;
        end
        
        %% 结果分析
        axes(handles.axesA);
        cla reset;
        view(2);
        hold on;
        plot(fit_gen,'r*-','LineWidth',1.5);
        plot(avgfitness_gen,'o-','LineWidth',1.5);
        legend('最佳适应度','平均适应度');
        xlabel('进化代数','FontSize',12);
        ylabel('适应度','FontSize',12);
        grid on;
        bestc = global_x(1);
        bestg = global_x(2);
        bestCVaccuarcy = fit_gen(pso_option.maxgen);
        
        str = ['CVmse = ',num2str(bestCVaccuarcy)];
        set(handles.CVaccuracy,'String',str);
        str = ['best c = ',num2str(bestc)];
        set(handles.bestc,'String',str);
        str = ['best g = ',num2str(bestg)];
        set(handles.bestg,'String',str);
        
        line1 = '适应度曲线MSE[PSOmethod]';
        line2 = ['(参数c1=',num2str(pso_option.c1), ...
            ',c2=',num2str(pso_option.c2),',终止代数=', ...
            num2str(pso_option.maxgen),',种群数量pop=', ...
            num2str(pso_option.sizepop),')'];
        line3 = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
            ' CVmse=',num2str(bestCVaccuarcy)];
        title({line1;line2;line3},'FontSize',12);
        cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.1'];
        
        line1 = '参数寻优完毕(pso method)';
        mystring{length(mystring)+1,1} = line1;
        set(handles.info,'String',mystring);
    case 4
        line1 = '参数寻优开始(ga method)...';
        mystring{length(mystring)+1,1} = line1;
        set(handles.info,'String',mystring);
        
        train_data = Train;
        train_label = TrainL;
        
        ga_option = struct('maxgen',100,'sizepop',20,'ggap',0.9,...
            'cbound',[0,100],'gbound',[0,100],'pbound',[0,1],'v',5);
        
        ga_option.maxgen = str2num(get(handles.maxgen,'String'));
        ga_option.sizepop = str2num(get(handles.sizepop,'String'));
        ga_option.cbound = [str2num(get(handles.cmin,'String')),str2num(get(handles.cmax,'String'))];
        ga_option.gbound = [str2num(get(handles.gmin,'String')),str2num(get(handles.gmax,'String'))];
        ga_option.pbound = [str2num(get(handles.pmin,'String')),str2num(get(handles.pmax,'String'))];
        ga_option.v = str2num(get(handles.v,'String'));
         
        MAXGEN = ga_option.maxgen;
        NIND = ga_option.sizepop;
        NVAR = 3;
        PRECI = 20;
        GGAP = ga_option.ggap;
        trace = zeros(MAXGEN,2);
        
        FieldID = ...
            [rep([PRECI],[1,NVAR]); ...
            [ga_option.cbound(1),ga_option.gbound(1),ga_option.pbound(1);ga_option.cbound(2),ga_option.gbound(2),ga_option.pbound(2);];...
            [1,1,1;0,0,0;0,1,1;1,1,1]];
        
        Chrom = crtbp(NIND,NVAR*PRECI);
        
        gen = 1;
        v = ga_option.v;
        BestMSE = inf;
        Bestc = 0;
        Bestg = 0;
        Bestp = 0;
        %%
        cg = bs2rv(Chrom,FieldID);
        
        for nind = 1:NIND
            cmd = ['-v ',num2str(v),' -c ',num2str(cg(nind,1)),' -g ',num2str(cg(nind,2)),' -p ',num2str(cg(nind,3)),' -s 3'];
            ObjV(nind,1) = svmtrain(train_label,train_data,cmd);
        end
        [BestMSE,I] = min(ObjV);
        Bestc = cg(I,1);
        Bestg = cg(I,2);
        Bestp = cg(I,3);
        
        %%
        for gen = 1:MAXGEN
            FitnV = ranking(ObjV);
            
            SelCh = select('sus',Chrom,FitnV,GGAP);
            SelCh = recombin('xovsp',SelCh,0.7);
            SelCh = mut(SelCh);
            
            cg = bs2rv(SelCh,FieldID);
            for nind = 1:size(SelCh,1)
                cmd = ['-v ',num2str(v),' -c ',num2str(cg(nind,1)),' -g ',num2str(cg(nind,2)),' -p ',num2str(cg(nind,3)),' -s 3'];
                ObjVSel(nind,1) = svmtrain(train_label,train_data,cmd);
            end
            
            [Chrom,ObjV] = reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            
            [NewBestCVaccuracy,I] = min(ObjV);
            cg_temp = bs2rv(Chrom,FieldID);
            temp_NewBestCVaccuracy = NewBestCVaccuracy;
            
            if NewBestCVaccuracy < BestMSE
                BestMSE = NewBestCVaccuracy;
                Bestc = cg_temp(I,1);
                Bestg = cg_temp(I,2);
                Bestp = cg_temp(I,3);
            end
            
            if abs( NewBestCVaccuracy-BestMSE ) <= 10^(-2) && ...
                    cg_temp(I,1) < Bestc
                BestMSE = NewBestCVaccuracy;
                Bestc = cg_temp(I,1);
                Bestg = cg_temp(I,2);
                Bestp = cg_temp(I,3);
            end
            
            trace(gen,1) = min(ObjV);
            trace(gen,2) = sum(ObjV)/length(ObjV);
            
        end
        
        %%
        str = ['CVmse = ',num2str(BestMSE)];
        set(handles.CVaccuracy,'String',str);
        str = ['best c = ',num2str(Bestc)];
        set(handles.bestc,'String',str);
        str = {['best g = ',num2str(Bestg)];['best p = ',num2str(Bestp)]};
        set(handles.bestg,'String',str);
        axes(handles.axesA);
        cla reset;
        view(2);
        hold on;
        trace = round(trace*10000)/10000;
        plot(trace(1:gen,1),'r*-','LineWidth',1.5);
        plot(trace(1:gen,2),'o-','LineWidth',1.5);
        legend('最佳适应度','平均适应度');
        xlabel('进化代数','FontSize',12);
        ylabel('适应度','FontSize',12);
        grid on;
        axis auto;
        line1 = '适应度曲线MSE[GAmethod]';
        line2 = ['(终止代数=', ...
            num2str(gen),',种群数量pop=', ...
            num2str(NIND),')'];
        line3 = ['Best c=',num2str(Bestc),' g=',num2str(Bestg),' p=',num2str(Bestp), ...
            ' CVmse=',num2str(BestMSE),'%'];
        title({line1;line2;line3},'FontSize',12);
        cmd = ['-c ',num2str(Bestc),' -g ',num2str(Bestg),' -s 3 -p 0.1'];
        
        line1 = '参数寻优完毕(ga method)';
        mystring{length(mystring)+1,1} = line1;
        set(handles.info,'String',mystring);   
        
end
%%
line1 = '开始训练&预测...';
mystring{length(mystring)+1,1} = line1;
set(handles.info,'String',mystring);

global Model pretrain pretest 
Model = svmtrain(TrainL,Train,cmd);
[pretrain,trainacc] = svmpredict(TrainL,Train,Model);
[pretest,testacc] = svmpredict(TestL,Test,Model);

if get(handles.yscale,'Value') ~= 3
    pretrain = mapminmax('reverse',pretrain',ps);
    pretrain = pretrain';
    pretest = mapminmax('reverse',pretest',ps);
    pretest = pretest';
end

str = {['train set mse = ',num2str(trainacc(2))];['train set r2 = ',num2str(trainacc(3))]};
set(handles.trainacc,'String',str);
str = {['test set mse = ',num2str(testacc(2))];['test set r2 = ',num2str(testacc(3))]};
set(handles.testacc,'String',str);

line1 = '训练&预测完毕！';
mystring{length(mystring)+1,1} = line1;
set(handles.info,'String',mystring);
%%
if testflag == 0
    axes(handles.axesC);
    cla reset;
    view(2);
    reset(gca);
    plot(TrainL,'-o');
    hold on;
    plot(pretrain,'r-^');
    legend('original','predict');
    title('train set');
    grid on;
else
    axes(handles.axesC);
    cla reset;
    view(2);
    reset(gca);
    plot(TRAIN_LABEL,'-o');
    hold on;
    plot(pretrain,'r-^');
    legend('original','predict');
    title('train set');
    grid on;
    
    axes(handles.axesB);
    cla reset;
    view(2);
    reset(gca);
    plot(TEST_LABEL,'-o');
    hold on;
    plot(pretest,'r-^');
    legend('original','predict');
    title('test set');
    grid on;
end

line1 = '======all done=====';
mystring{length(mystring)+1,1} = line1;
set(handles.info,'String',mystring);

guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname,filterindex] = uiputfile({'*.mat';'*.*'},'save data');

if filterindex
    filename=strcat(pathname,filename);
    global TRAIN_DATA TRAIN_LABEL TEST_DATA TEST_LABEL
    global Model pretrain pretest
    save(filename,...
        'TRAIN_DATA','TRAIN_LABEL','TEST_DATA','TEST_LABEL',...
        'Model','pretrain','pretest');
end

guidata(hObject, handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
open('SVM_GUI.fig');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = sprintf('SVM_GUI v3.1\nBased on libsvm-FarutoUltimate3.1\nby faruto @ www.matlabsky.com\nQQ:516667408\nlast modified 2011.07');
msgbox(s,'about');
open('readme.txt');
guidata(hObject,handles);


function info_Callback(hObject, eventdata, handles)
% hObject    handle to info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of info as text
%        str2double(get(hObject,'String')) returns contents of info as a double


% --- Executes during object creation, after setting all properties.
function info_CreateFcn(hObject, eventdata, handles)
% hObject    handle to info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in xscale.
function xscale_Callback(hObject, eventdata, handles)
% hObject    handle to xscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns xscale contents as cell array
%        contents{get(hObject,'Value')} returns selected item from xscale
if get(handles.xscale,'Value') == 4
    set(handles.min,'Enable','on');
    set(handles.max,'Enable','on');
else
    set(handles.min,'Enable','off');
    set(handles.max,'Enable','off');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xscale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pca.
function pca_Callback(hObject, eventdata, handles)
% hObject    handle to pca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pca contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pca
if get(handles.pca,'Value') == 1
    set(handles.percent,'Enable','on');
else
    set(handles.percent,'Enable','off');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pca_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in find.
function find_Callback(hObject, eventdata, handles)
% hObject    handle to find (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns find contents as cell array
%        contents{get(hObject,'Value')} returns selected item from find
if get(handles.find,'Value') == 1
    set(handles.gridcmin,'Enable','on');
    set(handles.gridcmax,'Enable','on');
    set(handles.gridgmin,'Enable','on');
    set(handles.gridgmax,'Enable','on');
    set(handles.gridcstep,'Enable','on');
    set(handles.gridgstep,'Enable','on');
else
    set(handles.gridcmin,'Enable','off');
    set(handles.gridcmax,'Enable','off');
    set(handles.gridgmin,'Enable','off');
    set(handles.gridgmax,'Enable','off');
    set(handles.gridcstep,'Enable','off');
    set(handles.gridgstep,'Enable','off');
end
if get(handles.find,'Value') == 2 || get(handles.find,'Value') == 3 || get(handles.find,'Value') == 4
    set(handles.maxgen,'Enable','on');
    set(handles.sizepop,'Enable','on');
    set(handles.cmin,'Enable','on');
    set(handles.cmax,'Enable','on');
    set(handles.gmin,'Enable','on');
    set(handles.gmax,'Enable','on');
else
    set(handles.maxgen,'Enable','off');
    set(handles.sizepop,'Enable','off');
    set(handles.cmin,'Enable','off');
    set(handles.cmax,'Enable','off');
    set(handles.gmin,'Enable','off');
    set(handles.gmax,'Enable','off');
end
if get(handles.find,'Value') == 4
    set(handles.pmin,'Enable','on');
    set(handles.pmax,'Enable','on');
else
    set(handles.pmin,'Enable','off');
    set(handles.pmax,'Enable','off');
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function find_CreateFcn(hObject, eventdata, handles)
% hObject    handle to find (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min as text
%        str2double(get(hObject,'String')) returns contents of min as a double
tempmin = get(handles.min,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.max,'String');
tempmax = str2num(tempmax);
if isempty(tempmin)
    warndlg('the lower bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max as text
%        str2double(get(hObject,'String')) returns contents of max as a double
tempmin = get(handles.min,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.max,'String');
tempmax = str2num(tempmax);
if isempty(tempmax)
    warndlg('the upper bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function percent_Callback(hObject, eventdata, handles)
% hObject    handle to percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of percent as text
%        str2double(get(hObject,'String')) returns contents of percent as a double
per = str2num(get(handles.percent,'String'));
if isempty(per) || per < 0 || per >100
    warndlg('the percentage must be a numerical number(0-100)!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function percent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gridcmin_Callback(hObject, eventdata, handles)
% hObject    handle to gridcmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gridcmin as text
%        str2double(get(hObject,'String')) returns contents of gridcmin as a double
tempmin = get(handles.gridcmin,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.gridcmax,'String');
tempmax = str2num(tempmax);
if isempty(tempmin)
    warndlg('the lower bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function gridcmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gridcmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gridcmax_Callback(hObject, eventdata, handles)
% hObject    handle to gridcmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gridcmax as text
%        str2double(get(hObject,'String')) returns contents of gridcmax as a double
tempmin = get(handles.gridcmin,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.gridcmax,'String');
tempmax = str2num(tempmax);
if isempty(tempmax)
    warndlg('the upper bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function gridcmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gridcmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gridgmin_Callback(hObject, eventdata, handles)
% hObject    handle to gridgmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gridgmin as text
%        str2double(get(hObject,'String')) returns contents of gridgmin as a double
tempmin = get(handles.gridgmin,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.gridgmax,'String');
tempmax = str2num(tempmax);
if isempty(tempmin)
    warndlg('the lower bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function gridgmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gridgmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gridgmax_Callback(hObject, eventdata, handles)
% hObject    handle to gridgmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gridgmax as text
%        str2double(get(hObject,'String')) returns contents of gridgmax as a double
tempmin = get(handles.gridgmin,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.gridgmax,'String');
tempmax = str2num(tempmax);
if isempty(tempmax)
    warndlg('the upper bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function gridgmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gridgmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gridgstep_Callback(hObject, eventdata, handles)
% hObject    handle to gridgstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gridgstep as text
%        str2double(get(hObject,'String')) returns contents of gridgstep as a double
temp = get(handles.gridgstep,'String');
temp = str2num(temp);
if isempty(temp) || temp<=0
    warndlg('the grid g step must be a numerical number(>0)!','warning');
end

% --- Executes during object creation, after setting all properties.
function gridgstep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gridgstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gridcstep_Callback(hObject, eventdata, handles)
% hObject    handle to gridcstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gridcstep as text
%        str2double(get(hObject,'String')) returns contents of gridcstep as a double
temp = get(handles.gridcstep,'String');
temp = str2num(temp);
if isempty(temp) || temp <= 0
    warndlg('the grid c step must be a numerical number(>0)!','warning');
end

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function gridcstep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gridcstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v_Callback(hObject, eventdata, handles)
% hObject    handle to v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v as text
%        str2double(get(hObject,'String')) returns contents of v as a double
temp = get(handles.v,'String');
temp = str2num(temp);
if isempty(temp) || temp<=2 
    warndlg('the fold v must be a numerical number(>=3)!','warning');
end

% --- Executes during object creation, after setting all properties.
function v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cmin_Callback(hObject, eventdata, handles)
% hObject    handle to cmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmin as text
%        str2double(get(hObject,'String')) returns contents of cmin as a double
tempmin = get(handles.cmin,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.cmax,'String');
tempmax = str2num(tempmax);
if isempty(tempmin)
    warndlg('the lower bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function cmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cmax_Callback(hObject, eventdata, handles)
% hObject    handle to cmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmax as text
%        str2double(get(hObject,'String')) returns contents of cmax as a double
tempmin = get(handles.cmin,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.cmax,'String');
tempmax = str2num(tempmax);
if isempty(tempmax)
    warndlg('the upper bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function cmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gmin_Callback(hObject, eventdata, handles)
% hObject    handle to gmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gmin as text
%        str2double(get(hObject,'String')) returns contents of gmin as a double
tempmin = get(handles.gmin,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.gmax,'String');
tempmax = str2num(tempmax);
if isempty(tempmin)
    warndlg('the lower bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function gmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gmax_Callback(hObject, eventdata, handles)
% hObject    handle to gmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gmax as text
%        str2double(get(hObject,'String')) returns contents of gmax as a double
tempmin = get(handles.gmin,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.gmax,'String');
tempmax = str2num(tempmax);
if isempty(tempmax)
    warndlg('the upper bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function gmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxgen_Callback(hObject, eventdata, handles)
% hObject    handle to maxgen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxgen as text
%        str2double(get(hObject,'String')) returns contents of maxgen as a double
temp = get(handles.maxgen,'String');
temp = str2num(temp);
if isempty(temp) || temp<=0
    warndlg('the maxgen must be a numerical number(>0)!','warning');
end

% --- Executes during object creation, after setting all properties.
function maxgen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxgen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sizepop_Callback(hObject, eventdata, handles)
% hObject    handle to sizepop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sizepop as text
%        str2double(get(hObject,'String')) returns contents of sizepop as a double
temp = get(handles.sizepop,'String');
temp = str2num(temp);
if isempty(temp) || temp<=0
    warndlg('the sizepop must be a numerical number(>0)!','warning');
end

% --- Executes during object creation, after setting all properties.
function sizepop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sizepop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function savepicB_Callback(hObject, eventdata, handles)
% hObject    handle to savepicB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axesB);
if isempty(handles.axesB)
    return;
end
newfig = figure;
set(newfig,'Visible','off');
newaxes = copyobj(handles.axesB,newfig);
set(newaxes,'Units','default','Position','default');

[filename,pathname,filterindex] = uiputfile({'*.jpg';'*.*'},'save as');

if filterindex
    filename=strcat(pathname,filename);
    pic = getframe(newfig);
    pic = frame2im(pic);
    imwrite(pic, filename);
end

guidata(hObject,handles);

% --------------------------------------------------------------------
function clearpicB_Callback(hObject, eventdata, handles)
% hObject    handle to clearpicB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axesB,'reset');
guidata(hObject,handles);

% --------------------------------------------------------------------
function savepicA_Callback(hObject, eventdata, handles)
% hObject    handle to savepicA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axesA);
if isempty(handles.axesA)
    return;
end
newfig = figure;
set(newfig,'Visible','off');
newaxes = copyobj(handles.axesA,newfig);
set(newaxes,'Units','default','Position','default');

[filename,pathname,filterindex] = uiputfile({'*.jpg';'*.*'},'save as');

if filterindex
    filename=strcat(pathname,filename);
    pic = getframe(newfig);
    pic = frame2im(pic);
    imwrite(pic, filename);
end

guidata(hObject,handles);

% --------------------------------------------------------------------
function clearpicA_Callback(hObject, eventdata, handles)
% hObject    handle to clearpicA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axesA,'reset');
guidata(hObject,handles);

% --------------------------------------------------------------------
function picA_Callback(hObject, eventdata, handles)
% hObject    handle to picA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function picB_Callback(hObject, eventdata, handles)
% hObject    handle to picB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function clearinfo_Callback(hObject, eventdata, handles)
% hObject    handle to clearinfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.info,'String','');
guidata(hObject,handles);



function pmin_Callback(hObject, eventdata, handles)
% hObject    handle to pmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pmin as text
%        str2double(get(hObject,'String')) returns contents of pmin as a double


% --- Executes during object creation, after setting all properties.
function pmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pmax_Callback(hObject, eventdata, handles)
% hObject    handle to pmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pmax as text
%        str2double(get(hObject,'String')) returns contents of pmax as a double


% --- Executes during object creation, after setting all properties.
function pmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in yscale.
function yscale_Callback(hObject, eventdata, handles)
% hObject    handle to yscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns yscale contents as cell array
%        contents{get(hObject,'Value')} returns selected item from yscale
if get(handles.yscale,'Value') == 4
    set(handles.ymin,'Enable','on');
    set(handles.ymax,'Enable','on');
else
    set(handles.ymin,'Enable','off');
    set(handles.ymax,'Enable','off');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function yscale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymin_Callback(hObject, eventdata, handles)
% hObject    handle to ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymin as text
%        str2double(get(hObject,'String')) returns contents of ymin as a double
tempmin = get(handles.ymin,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.ymax,'String');
tempmax = str2num(tempmax);
if isempty(tempmin)
    warndlg('the lower bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymax_Callback(hObject, eventdata, handles)
% hObject    handle to ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymax as text
%        str2double(get(hObject,'String')) returns contents of ymax as a double
tempmin = get(handles.ymin,'String');
tempmin = str2num(tempmin);
tempmax = get(handles.ymax,'String');
tempmax = str2num(tempmax);
if isempty(tempmax)
    warndlg('the upper bound must be a numerical number!','warning');
end
if tempmin >= tempmax
    warndlg('the lower bound must be less than the upper bound!','warning');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function savepicC_Callback(hObject, eventdata, handles)
% hObject    handle to savepicC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axesC);
if isempty(handles.axesC)
    return;
end
newfig = figure;
set(newfig,'Visible','off');
newaxes = copyobj(handles.axesC,newfig);
set(newaxes,'Units','default','Position','default');

[filename,pathname,filterindex] = uiputfile({'*.jpg';'*.*'},'save as');

if filterindex
    filename=strcat(pathname,filename);
    pic = getframe(newfig);
    pic = frame2im(pic);
    imwrite(pic, filename);
end

guidata(hObject,handles);

% --------------------------------------------------------------------
function clearpicC_Callback(hObject, eventdata, handles)
% hObject    handle to clearpicC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axesC,'reset');
guidata(hObject,handles);

% --------------------------------------------------------------------
function picC_Callback(hObject, eventdata, handles)
% hObject    handle to picC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
