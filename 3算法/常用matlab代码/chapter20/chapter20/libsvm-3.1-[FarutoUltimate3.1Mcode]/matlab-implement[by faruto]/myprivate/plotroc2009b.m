function result = plotroc2009b(varargin)
%PLOTROC Plot receiver operating characteristic.
%
%  Syntax
%
%    plotroc(targets,outputs)
%    plotroc(targets1,outputs1,'name1',targets,outputs2,'name2', ...)
%
%  Description
%
%    PLOTROC(TARGETS,OUTPUTS) plots the receiver operating characteristic
%    for each output class. The more each curve hugs the left and top edges
%    of the plot, the better the classification.
%
%    PLOTROC(TARGETS1,OUTPUTS2,'name1',...) generates multiple plots.
%
%  Example
%
%    load simplecluster_dataset
%    net = newpr(simpleclusterInputs,simpleclusterTargets,20);
%    net = train(net,simpleclusterInputs,simpleclusterTargets);
%    simpleclusterOutputs = sim(net,simpleclusterInputs);
%    plotroc(simpleclusterTargets,simpleclusterOutputs);
%
% See also ROC

% Copyright 2007-2008 The MathWorks, Inc.

if nargin < 1, error('NNET:Arguments','Not enough input arguments.'); end

%% Info
if strcmp(varargin{1},'info')
  info.name = mfilename;
  info.title = 'Receiver Operating Characteristic';
  info.type = 'Plot';
  info.version = 6;
  result = info;
  return;
end

if nargin < 1, error('NNET:Arguments','Incorrect number of input arguments.'); end

%% Plot
v1 = varargin{1};
if ~isa(varargin{1},'network')
  % User arguments - New plot
  count = round(nargin/3);
  tt = cell(1,count);
  yy = cell(1,count);
  names = cell(1,count);
  for i=1:count
    tt{i} = varargin{i*3-2};
    yy{i} = varargin{i*3-1};
    if nargin >= (i*3)
      names{i} = varargin{i*3};
    else
      names{i} = '';
    end
  end
  fig = new_figure('');
elseif  (isa(v1,'network') && (nargin == 3))
  [net,tr,signals] = deal(varargin{:});
  tt={};
  yy={};
  names = {};
  for i=1:length(signals)
    signal = signals{i};
    if ~isempty(signal.indices)
      tt = [tt {signal.T}];
      yy = [yy {signal.Y}];
      names = [names {signal.name}];
    end
  end
  if length(names) > 1
    tt = [tt {cell2mat([tt{:}])}];
    yy = [yy {cell2mat([yy{:}])}];
    names = [names {'All'}];
  end
  fig = nn_find_tagged_figure(mfilename);
  if isempty(fig)
    fig = new_figure(mfilename);
  end
end
update_figure(fig,tt,yy,names);
if (nargout > 0), result = fig; end

%% New Figure
function fig = new_figure(tag)

fig = figure;
ud.numSignals = 0;
ud.numClasses = 0;

this = 'plotroc';
info = feval(this,'info');

set(fig,'name',[info.title ' (' this ')']);
set(fig,'menubar','none','toolbar','none','NumberTitle','off');
set(fig,'tag',tag,'UserData',ud)

%% Update Figure
function update_figure(fig,tt,yy,names)

ok = true;

if ok
  plot_figure(fig,tt,yy,names);
else
  clear_figure(fig);
end
drawnow

%% Plot Figure
function plot_figure(fig,tt,yy,names)

set(0,'CurrentFigure',fig);
ud = get(fig,'userdata');

t = tt{1}; if iscell(t), t = cell2mat(t); end
numSignals = length(names);
numClasses = size(t,1);

% Rebuild figure
if (ud.numSignals ~= numSignals) || (ud.numClasses ~= numClasses)
  clf(fig);
  set(fig,'nextplot','replace');
  
  ud.numSignals = numSignals;
  ud.numClasses = numClasses;
  ud.axes = zeros(1,numSignals);
  
  pos = get(fig,'position');
  windowSize = [350*numSignals, 300];
  pos(3:4) = windowSize;
  if (ud.numSignals == 0)
    screenSize = get(0,'ScreenSize');
    screenSize = screenSize(3:4);
    pos(1:2)= (screenSize-windowSize)/2;
  end
  set(fig,'position',pos);
  
  colors = {[0 0 1],[0 0.8 0],[1 0 0]};
  
  plotcols = ceil(sqrt(numSignals));
  plotrows = ceil(numSignals/plotcols);
  
  for plotrow=1:plotrows
    for plotcol=1:plotcols
      i = (plotrow-1)*plotcols+plotcol;
      if (i<=numSignals)
        
        a = subplot(plotrows,plotcols,i);
        set(a,'dataaspectratio',[1 1 1]);
        set(a,'xlim',[0 1]);
        set(a,'ylim',[0 1]);
        hold on

        axisdata = [];
        axisdata.lines = zeros(1,numClasses);
        for j=1:numClasses
          c = colors{rem(j-1,length(colors))+1};
          line([0 1],[0 1],'linewidth',2,'color',[1 1 1]*0.8);
          axisdata.lines(j) = line([0 1],[0 1],'linewidth',2,'Color',c);
        end

        if ~isempty(names{1})
          titleStr = [names{i} ' ROC'];
        else
          titleStr = 'ROC';
        end
        title(a,titleStr);
        xlabel(a,'False Positive Rate');
        ylabel(a,'True Positive Rate');

        ud.axes(i) = a;
        set(a,'userdata',axisdata);
      end
    end
  end

  set(fig,'userdata',ud);
  set(fig,'nextplot','new');
  
  screenSize = get(0,'ScreenSize');
  screenSize = screenSize(3:4);
  windowSize = 700 * [1 (plotrows/plotcols)];
  pos = [(screenSize-windowSize)/2 windowSize];
  set(fig,'position',pos);
end

% Update details
for i=1:numSignals
  y = yy{i}; if iscell(y), y = cell2mat(y); end
  t = tt{i}; if iscell(t), t = cell2mat(t); end
  
  [tpr,fpr] = roc(t,y);
  if ~iscell(tpr)
    tpr = {tpr};
    fpr = {fpr};
  end
  
  a = ud.axes(i);
  axisdata = get(a,'userdata');
  
  for j=1:numClasses
    set(axisdata.lines(j),'xdata',[0 fpr{j} 1],'ydata',[0 tpr{j} 1]);
  end
end


%% Clear Figure
function clear_figure(fig)

ud = get(fig,'userdata');
set(ud.outputLine,'Xdata',[NaN NaN],'Ydata',[NaN NaN]);
set(ud.targetLine,'Xdata',[NaN NaN],'Ydata',[NaN NaN]);
set(ud.fitLine,'Xdata',[NaN NaN],'Ydata',[NaN NaN]);
set(ud.errorLine,'Xdata',[NaN NaN],'Ydata',[NaN NaN]);

set(ud.axis,'xlim',[0 1]);
set(ud.axis,'ylim',[0 1]);
set(ud.warning1,'visible','on');
set(ud.warning2,'visible','on');

