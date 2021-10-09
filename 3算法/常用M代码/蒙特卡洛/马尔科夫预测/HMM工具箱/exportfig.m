function varargout = exportfig(varargin)
%EXPORTFIG  Export a figure.
%   EXPORTFIG(H, FILENAME) writes the figure H to FILENAME.  H is
%   a figure handle and FILENAME is a string that specifies the
%   name of the output file.
%
%   EXPORTFIG(H, FILENAME, OPTIONS) writes the figure H to FILENAME
%   with options initially specified by the structure OPTIONS. The
%   field names of OPTIONS must be legal parameters listed below
%   and the field values must be legal values for the corresponding
%   parameter. Default options can be set in releases prior to R12
%   by storing the OPTIONS structure in the root object's appdata
%   with the command 
%      setappdata(0,'exportfigdefaults', OPTIONS) 
%   and for releases after R12 by setting the preference with the
%   command 
%      setpref('exportfig', 'defaults', OPTIONS) 
%
%   EXPORTFIG(...,PARAM1,VAL1,PARAM2,VAL2,...) specifies
%   parameters that control various characteristics of the output
%   file. Any parameter value can be the string 'auto' which means
%   the parameter uses the default factory behavior, overriding
%   any other default for the parameter.
%
%   Format Paramter:
%     'Format'  a string
%          specifies the output format. Defaults to 'eps'. For a
%          list of export formats type 'help print'.
%     'Preview' one of the strings 'none', 'tiff'
%          specifies a preview for EPS files. Defaults to 'none'.
%
%   Size Parameters:
%     'Width'   a positive scalar
%          specifies the width in the figure's PaperUnits
%     'Height'  a positive scalar
%          specifies the height in the figure's PaperUnits
%     'Bounds' one of the strings 'tight', 'loose'
%          specifies a tight or loose bounding box. Defaults to 'tight'.
%     'Reference' an axes handle or a string
%          specifies that the width and height parameters
%          are relative to the given axes. If a string is
%          specified then it must evaluate to an axes handle.
%
%     Specifying only one dimension sets the other dimension
%     so that the exported aspect ratio is the same as the
%     figure's or reference axes' current aspect ratio. 
%     If neither dimension is specified the size defaults to 
%     the width and height from the figure's or reference
%     axes' size. Tight bounding boxes are only computed for
%     2-D views and in that case the computed bounds enclose all
%     text objects.
%           
%   Rendering Parameters:
%     'Color'     one of the strings 'bw', 'gray', 'cmyk'
%         'bw'    specifies that lines and text are exported in
%                 black and all other objects in grayscale
%         'gray'  specifies that all objects are exported in grayscale
%         'rgb'   specifies that all objects are exported in color
%                 using the RGB color space
%         'cmyk'  specifies that all objects are exported in color
%                 using the CMYK color space
%     'Renderer'  one of 'painters', 'zbuffer', 'opengl'
%         specifies the renderer to use
%     'Resolution'   a positive scalar
%         specifies the resolution in dots-per-inch.
%     'LockAxes'  one of 0 or 1
%         specifies that all axes limits and ticks should be fixed
%         while exporting.
%     
%     The default color setting is 'bw'.
%
%   Font Parameters:
%     'FontMode'     one of the strings 'scaled', 'fixed'
%     'FontSize'     a positive scalar
%          in 'scaled' mode multiplies with the font size of each
%          text object to obtain the exported font size
%          in 'fixed' mode specifies the font size of all text
%          objects in points
%     'DefaultFixedFontSize' a positive scalar
%          in 'fixed' mode specified the default font size in
%          points
%     'FontSizeMin' a positive scalar
%          specifies the minimum font size allowed after scaling
%     'FontSizeMax' a positive scalar
%          specifies the maximum font size allowed after scaling
%     'FontEncoding' one of the strings 'latin1', 'adobe'
%          specifies the character encoding of the font
%     'SeparateText' one of 0 or 1
%          specifies that the text objects are stored in separate
%          file as EPS with the base filename having '_t' appended.
%
%     If FontMode is 'scaled' but FontSize is not specified then a
%     scaling factor is computed from the ratio of the size of the
%     exported figure to the size of the actual figure.
%
%     The default 'FontMode' setting is 'scaled'.
%
%   Line Width Parameters:
%     'LineMode'     one of the strings 'scaled', 'fixed'
%     'LineWidth'    a positive scalar
%     'DefaultFixedLineWidth' a positive scalar
%     'LineWidthMin' a positive scalar
%          specifies the minimum line width allowed after scaling
%     'LineWidthMax' a positive scalar
%          specifies the maximum line width allowed after scaling
%     The semantics of 'Line' parameters are exactly the
%     same as the corresponding 'Font' parameters, except that
%     they apply to line widths instead of font sizes.
%
%   Style Map Parameter:
%     'LineStyleMap'    one of [], 'bw', or a function name or handle
%          specifies how to map line colors to styles. An empty
%          style map means styles are not changed. The style map
%          'bw' is a built-in mapping that maps lines with the same
%          color to the same style and otherwise cycles through the
%          available styles. A user-specified map is a function
%          that takes as input a cell array of line objects and
%          outputs a cell array of line style strings. The default
%          map is [].
%      
%   Examples:
%     exportfig(gcf,'fig1.eps','height',3);
%       Exports the current figure to the file named 'fig1.eps' with
%       a height of 3 inches (assuming the figure's PaperUnits is 
%       inches) and an aspect ratio the same as the figure's aspect
%       ratio on screen.
%
%     opts = struct('FontMode','fixed','FontSize',10,'height',3);
%     exportfig(gcf, 'fig2.eps', opts, 'height', 5);
%       Exports the current figure to 'fig2.eps' with all
%       text in 10 point fonts and with height 5 inches.
%
%   See also PREVIEWFIG, APPLYTOFIG, RESTOREFIG, PRINT.

%  Copyright 2000 Ben Hinkle
%  Email bug reports and comments to bhinkle@mathworks.com

if (nargin < 2)
  error('Too few input arguments');
end

% exportfig(H, filename, [options,] ...)
H = varargin{1};
if ~LocalIsHG(H,'figure')
  error('First argument must be a handle to a figure.');
end
filename = varargin{2};
if ~ischar(filename)
  error('Second argument must be a string.');
end
paramPairs = {varargin{3:end}};
if nargin > 2
  if isstruct(paramPairs{1})
    pcell = LocalToCell(paramPairs{1});
    paramPairs = {pcell{:}, paramPairs{2:end}};
  end
end
verstr = version;
majorver = str2num(verstr(1));
defaults = [];
if majorver > 5
  if ispref('exportfig','defaults')
    defaults = getpref('exportfig','defaults');
  end
elseif exist('getappdata')
  defaults = getappdata(0,'exportfigdefaults');
end
if ~isempty(defaults)
  dcell = LocalToCell(defaults);
  paramPairs = {dcell{:}, paramPairs{:}};
end

% Do some validity checking on param-value pairs
if (rem(length(paramPairs),2) ~= 0)
  error(['Invalid input syntax. Optional parameters and values' ...
	 ' must be in pairs.']);
end

auto.format = 'eps';
auto.preview = 'none';
auto.width = -1;
auto.height = -1;
auto.color = 'bw';
auto.defaultfontsize=10;
auto.fontsize = -1;
auto.fontmode='scaled';
auto.fontmin = 8;
auto.fontmax = 60;
auto.defaultlinewidth = 1.0;
auto.linewidth = -1;
auto.linemode=[];
auto.linemin = 0.5;
auto.linemax = 100;
auto.fontencoding = 'latin1';
auto.renderer = [];
auto.resolution = [];
auto.stylemap = [];
auto.applystyle = 0;
auto.refobj = -1;
auto.bounds = 'tight';
explicitbounds = 0;
auto.lockaxes = 1;
auto.separatetext = 0;
opts = auto;

% Process param-value pairs
args = {};
for k = 1:2:length(paramPairs)
  param = lower(paramPairs{k});
  if ~ischar(param)
    error('Optional parameter names must be strings');
  end
  value = paramPairs{k+1};
  
  switch (param)
   case 'format'
    opts.format = LocalCheckAuto(lower(value),auto.format);
    if strcmp(opts.format,'preview')
      error(['Format ''preview'' no longer supported. Use PREVIEWFIG' ...
	     ' instead.']);
    end
   case 'preview'
    opts.preview = LocalCheckAuto(lower(value),auto.preview);
    if ~strcmp(opts.preview,{'none','tiff'})
      error('Preview must be ''none'' or ''tiff''.');
    end
   case 'width'
    opts.width = LocalToNum(value, auto.width);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~LocalIsPositiveScalar(opts.width)
	error('Width must be a numeric scalar > 0');
      end
    end
   case 'height'
    opts.height = LocalToNum(value, auto.height);
    if ~ischar(value) | ~strcmp(value,'auto')
      if(~LocalIsPositiveScalar(opts.height))
	error('Height must be a numeric scalar > 0');
      end
    end
   case 'color'
    opts.color = LocalCheckAuto(lower(value),auto.color);
    if ~strcmp(opts.color,{'bw','gray','rgb','cmyk'})
      error('Color must be ''bw'', ''gray'',''rgb'' or ''cmyk''.');
    end
   case 'fontmode'
    opts.fontmode = LocalCheckAuto(lower(value),auto.fontmode);
    if ~strcmp(opts.fontmode,{'scaled','fixed'})
      error('FontMode must be ''scaled'' or ''fixed''.');
    end
   case 'fontsize'
    opts.fontsize = LocalToNum(value,auto.fontsize);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~LocalIsPositiveScalar(opts.fontsize)
	error('FontSize must be a numeric scalar > 0');
      end
    end
   case 'defaultfixedfontsize'
    opts.defaultfontsize = LocalToNum(value,auto.defaultfontsize);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~LocalIsPositiveScalar(opts.defaultfontsize)
	error('DefaultFixedFontSize must be a numeric scalar > 0');
      end
    end
   case 'fontsizemin'
    opts.fontmin = LocalToNum(value,auto.fontmin);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~LocalIsPositiveScalar(opts.fontmin)
	error('FontSizeMin must be a numeric scalar > 0');
      end
    end
   case 'fontsizemax'
    opts.fontmax = LocalToNum(value,auto.fontmax);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~LocalIsPositiveScalar(opts.fontmax)
	error('FontSizeMax must be a numeric scalar > 0');
      end
    end
   case 'fontencoding'
    opts.fontencoding = LocalCheckAuto(lower(value),auto.fontencoding);
    if ~strcmp(opts.fontencoding,{'latin1','adobe'})
      error('FontEncoding must be ''latin1'' or ''adobe''.');
    end
   case 'linemode'
    opts.linemode = LocalCheckAuto(lower(value),auto.linemode);
    if ~strcmp(opts.linemode,{'scaled','fixed'})
      error('LineMode must be ''scaled'' or ''fixed''.');
    end
   case 'linewidth'
    opts.linewidth = LocalToNum(value,auto.linewidth);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~LocalIsPositiveScalar(opts.linewidth)
	error('LineWidth must be a numeric scalar > 0');
      end
    end
   case 'defaultfixedlinewidth'
    opts.defaultlinewidth = LocalToNum(value,auto.defaultlinewidth);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~LocalIsPositiveScalar(opts.defaultlinewidth)
	error(['DefaultFixedLineWidth must be a numeric scalar >' ...
	       ' 0']);
      end
    end
   case 'linewidthmin'
    opts.linemin = LocalToNum(value,auto.linemin);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~LocalIsPositiveScalar(opts.linemin)
	error('LineWidthMin must be a numeric scalar > 0');
      end
    end
   case 'linewidthmax'
    opts.linemax = LocalToNum(value,auto.linemax);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~LocalIsPositiveScalar(opts.linemax)
	error('LineWidthMax must be a numeric scalar > 0');
      end
    end
   case 'linestylemap'
    opts.stylemap = LocalCheckAuto(value,auto.stylemap);
   case 'renderer'
    opts.renderer = LocalCheckAuto(lower(value),auto.renderer);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~strcmp(opts.renderer,{'painters','zbuffer','opengl'})
	error(['Renderer must be ''painters'', ''zbuffer'' or' ...
	       ' ''opengl''.']);
      end
    end
   case 'resolution'
    opts.resolution = LocalToNum(value,auto.resolution);
    if ~ischar(value) | ~strcmp(value,'auto')
      if ~(isnumeric(value) & (prod(size(value)) == 1) & (value >= 0));
	error('Resolution must be a numeric scalar >= 0');
      end
    end
   case 'applystyle' % means to apply the options and not export
    opts.applystyle = 1;
   case 'reference'
    if ischar(value)
      if strcmp(value,'auto')
	opts.refobj = auto.refobj;
      else
	opts.refobj = eval(value);
      end
    else
      opts.refobj = value;
    end
    if ~LocalIsHG(opts.refobj,'axes')
      error('Reference object must evaluate to an axes handle.');
    end
   case 'bounds'
    opts.bounds = LocalCheckAuto(lower(value),auto.bounds);
    explicitbounds = 1;
    if ~strcmp(opts.bounds,{'tight','loose'})
      error('Bounds must be ''tight'' or ''loose''.');
    end
   case 'lockaxes'
    opts.lockaxes = LocalToNum(value,auto.lockaxes);
   case 'separatetext'
    opts.separatetext = LocalToNum(value,auto.separatetext);
   otherwise
    error(['Unrecognized option ' param '.']);
  end
end

% make sure figure is up-to-date
drawnow;

allLines  = findall(H, 'type', 'line');
allText   = findall(H, 'type', 'text');
allAxes   = findall(H, 'type', 'axes');
allImages = findall(H, 'type', 'image');
allLights = findall(H, 'type', 'light');
allPatch  = findall(H, 'type', 'patch');
allSurf   = findall(H, 'type', 'surface');
allRect   = findall(H, 'type', 'rectangle');
allFont   = [allText; allAxes];
allColor  = [allLines; allText; allAxes; allLights];
allMarker = [allLines; allPatch; allSurf];
allEdge   = [allPatch; allSurf];
allCData  = [allImages; allPatch; allSurf];

old.objs = {};
old.prop = {};
old.values = {};

% Process format
if strncmp(opts.format,'eps',3) & ~strcmp(opts.preview,'none')
  args = {args{:}, ['-' opts.preview]};
end

hadError = 0;
oldwarn = warning;
try

  % lock axes limits, ticks and labels if requested
  if opts.lockaxes
    old = LocalManualAxesMode(old, allAxes, 'TickMode');
    old = LocalManualAxesMode(old, allAxes, 'TickLabelMode');
    old = LocalManualAxesMode(old, allAxes, 'LimMode');
  end  

  % Process size parameters
  figurePaperUnits = get(H, 'PaperUnits');
  oldFigureUnits = get(H, 'Units');
  oldFigPos = get(H,'Position');
  set(H, 'Units', figurePaperUnits);
  figPos = get(H,'Position');
  refsize = figPos(3:4);
  if opts.refobj ~= -1
    oldUnits = get(opts.refobj, 'Units');
    set(opts.refobj, 'Units', figurePaperUnits);
    r = get(opts.refobj, 'Position');
    refsize = r(3:4);
    set(opts.refobj, 'Units', oldUnits);
  end
  aspectRatio = refsize(1)/refsize(2);
  if (opts.width == -1) & (opts.height == -1)
    opts.width = refsize(1);
    opts.height = refsize(2);
  elseif (opts.width == -1)
    opts.width = opts.height * aspectRatio;
  elseif (opts.height == -1)
    opts.height = opts.width / aspectRatio;
  end
  wscale = opts.width/refsize(1);
  hscale = opts.height/refsize(2);
  sizescale = min(wscale,hscale);
  old = LocalPushOldData(old,H,'PaperPositionMode', ...
			 get(H,'PaperPositionMode'));
  set(H, 'PaperPositionMode', 'auto');
  newPos = [figPos(1) figPos(2)+figPos(4)*(1-hscale) ...
	    wscale*figPos(3) hscale*figPos(4)];
  set(H, 'Position', newPos);
  set(H, 'Units', oldFigureUnits);
  
  % process line-style map
  if ~isempty(opts.stylemap) & ~isempty(allLines)
    oldlstyle = LocalGetAsCell(allLines,'LineStyle');
    old = LocalPushOldData(old, allLines, {'LineStyle'}, ...
			   oldlstyle);
    newlstyle = oldlstyle;
    if ischar(opts.stylemap) & strcmpi(opts.stylemap,'bw')
      newlstyle = LocalMapColorToStyle(allLines);
    else
      try
	newlstyle = feval(opts.stylemap,allLines);
      catch
	warning(['Skipping stylemap. ' lasterr]);
      end
    end
    set(allLines,{'LineStyle'},newlstyle);
  end

  % Process rendering parameters
  switch (opts.color)
   case {'bw', 'gray'}
    if ~strcmp(opts.color,'bw') & strncmp(opts.format,'eps',3)
      opts.format = [opts.format 'c'];
    end
    args = {args{:}, ['-d' opts.format]};
    
    %compute and set gray colormap
    oldcmap = get(H,'Colormap');
    newgrays = 0.30*oldcmap(:,1) + 0.59*oldcmap(:,2) + 0.11*oldcmap(:,3);
    newcmap = [newgrays newgrays newgrays];
    old = LocalPushOldData(old, H, 'Colormap', oldcmap);
    set(H, 'Colormap', newcmap);

    %compute and set ColorSpec and CData properties
    old = LocalUpdateColors(allColor, 'color', old);
    old = LocalUpdateColors(allAxes, 'xcolor', old);
    old = LocalUpdateColors(allAxes, 'ycolor', old);
    old = LocalUpdateColors(allAxes, 'zcolor', old);
    old = LocalUpdateColors(allMarker, 'MarkerEdgeColor', old);
    old = LocalUpdateColors(allMarker, 'MarkerFaceColor', old);
    old = LocalUpdateColors(allEdge, 'EdgeColor', old);
    old = LocalUpdateColors(allEdge, 'FaceColor', old);
    old = LocalUpdateColors(allCData, 'CData', old);
    
   case {'rgb','cmyk'}
    if strncmp(opts.format,'eps',3)
      opts.format = [opts.format 'c'];
      args = {args{:}, ['-d' opts.format]};
      if strcmp(opts.color,'cmyk')
	args = {args{:}, '-cmyk'};
      end
    else
      args = {args{:}, ['-d' opts.format]};
    end
   otherwise
    error('Invalid Color parameter');
  end
  if (~isempty(opts.renderer))
    args = {args{:}, ['-' opts.renderer]};
  end
  if (~isempty(opts.resolution)) | ~strncmp(opts.format,'eps',3)
    if isempty(opts.resolution)
      opts.resolution = 0;
    end
    args = {args{:}, ['-r' int2str(opts.resolution)]};
  end

  % Process font parameters
  if ~isempty(opts.fontmode)
    oldfonts = LocalGetAsCell(allFont,'FontSize');
    oldfontunits = LocalGetAsCell(allFont,'FontUnits');
    set(allFont,'FontUnits','points');
    switch (opts.fontmode)
     case 'fixed'
      if (opts.fontsize == -1)
	set(allFont,'FontSize',opts.defaultfontsize);
      else
	set(allFont,'FontSize',opts.fontsize);
      end
     case 'scaled'
      if (opts.fontsize == -1)
	scale = sizescale;
      else
	scale = opts.fontsize;
      end
      newfonts = LocalScale(oldfonts,scale,opts.fontmin,opts.fontmax);
      set(allFont,{'FontSize'},newfonts);
     otherwise
      error('Invalid FontMode parameter');
    end
    old = LocalPushOldData(old, allFont, {'FontSize'}, oldfonts);
    old = LocalPushOldData(old, allFont, {'FontUnits'}, oldfontunits);
  end
  if strcmp(opts.fontencoding,'adobe') & strncmp(opts.format,'eps',3)
    args = {args{:}, '-adobecset'};
  end

  % Process line parameters
  if ~isempty(opts.linemode)
    oldlines = LocalGetAsCell(allMarker,'LineWidth');
    old = LocalPushOldData(old, allMarker, {'LineWidth'}, oldlines);
    switch (opts.linemode)
     case 'fixed'
      if (opts.linewidth == -1)
	set(allMarker,'LineWidth',opts.defaultlinewidth);
      else
	set(allMarker,'LineWidth',opts.linewidth);
      end
     case 'scaled'
      if (opts.linewidth == -1)
	scale = sizescale;
      else
	scale = opts.linewidth;
      end
      newlines = LocalScale(oldlines, scale, opts.linemin, opts.linemax);
      set(allMarker,{'LineWidth'},newlines);
    end
  end

  % adjust figure bounds to surround axes
  if strcmp(opts.bounds,'tight')
    if (~strncmp(opts.format,'eps',3) & LocalHas3DPlot(allAxes)) | ...
	  (strncmp(opts.format,'eps',3) & opts.separatetext)
      if (explicitbounds == 1)
	warning(['Cannot compute ''tight'' bounds. Using ''loose''' ...
		 ' bounds.']);
      end
      opts.bounds = 'loose';
    end
  end
  warning('off');
  if ~isempty(allAxes)
    if strncmp(opts.format,'eps',3)
      if strcmp(opts.bounds,'loose')
	args = {args{:}, '-loose'};
      end
      old = LocalPushOldData(old,H,'Position', oldFigPos);
    elseif strcmp(opts.bounds,'tight')
      oldaunits = LocalGetAsCell(allAxes,'Units');
      oldapos = LocalGetAsCell(allAxes,'Position');
      oldtunits = LocalGetAsCell(allText,'units');
      oldtpos = LocalGetAsCell(allText,'Position');
      set(allAxes,'units','points');
      apos = LocalGetAsCell(allAxes,'Position');
      oldunits = get(H,'Units');
      set(H,'units','points');
      origfr = get(H,'position');
      fr = [];
      for k=1:length(allAxes)
	if ~strcmpi(get(allAxes(k),'Tag'),'legend')
	  axesR = apos{k};
	  r = LocalAxesTightBoundingBox(axesR, allAxes(k));
	  r(1:2) = r(1:2) + axesR(1:2);
	  fr = LocalUnionRect(fr,r);
	end
      end
      if isempty(fr)
	fr = [0 0 origfr(3:4)];
      end
      for k=1:length(allAxes)
	ax = allAxes(k);
	r = apos{k};
	r(1:2) = r(1:2) - fr(1:2);
	set(ax,'Position',r);
      end
      old = LocalPushOldData(old, allAxes, {'Position'}, oldapos);
      old = LocalPushOldData(old, allText, {'Position'}, oldtpos);
      old = LocalPushOldData(old, allText, {'Units'}, oldtunits);
      old = LocalPushOldData(old, allAxes, {'Units'}, oldaunits);
      old = LocalPushOldData(old, H, 'Position', oldFigPos);
      old = LocalPushOldData(old, H, 'Units', oldFigureUnits);
      r = [origfr(1) origfr(2)+origfr(4)-fr(4) fr(3:4)];
      set(H,'Position',r);
    else
      args = {args{:}, '-loose'};
      old = LocalPushOldData(old,H,'Position', oldFigPos);
    end
  end
  
  % Process text in a separate file if needed
  if opts.separatetext & ~opts.applystyle
    % First hide all text and export
    oldtvis = LocalGetAsCell(allText,'visible');
    set(allText,'visible','off');
    oldax = LocalGetAsCell(allAxes,'XTickLabel',1);
    olday = LocalGetAsCell(allAxes,'YTickLabel',1);
    oldaz = LocalGetAsCell(allAxes,'ZTickLabel',1);
    null = cell(length(oldax),1);
    [null{:}] = deal([]);
    set(allAxes,{'XTickLabel'},null);
    set(allAxes,{'YTickLabel'},null);
    set(allAxes,{'ZTickLabel'},null);
    print(H, filename, args{:});
    set(allText,{'Visible'},oldtvis);
    set(allAxes,{'XTickLabel'},oldax);
    set(allAxes,{'YTickLabel'},olday);
    set(allAxes,{'ZTickLabel'},oldaz);
    % Now hide all non-text and export as eps in painters
    [path, name, ext] = fileparts(filename);
    tfile = fullfile(path,[name '_t.eps']);
    tfile2 = fullfile(path,[name '_t2.eps']);
    foundRenderer = 0;
    for k=1:length(args)
      if strncmp('-d',args{k},2)
	args{k} = '-deps';
      elseif strncmp('-zbuffer',args{k},8) | ...
	    strncmp('-opengl', args{k},6)
	args{k} = '-painters';
	foundRenderer = 1;
      end
    end
    if ~foundRenderer
      args = {args{:}, '-painters'};
    end
    allNonText = [allLines; allLights; allPatch; ...
		  allImages; allSurf; allRect];
    oldvis = LocalGetAsCell(allNonText,'visible');
    oldc = LocalGetAsCell(allAxes,'color');
    oldaxg = LocalGetAsCell(allAxes,'XGrid');
    oldayg = LocalGetAsCell(allAxes,'YGrid');
    oldazg = LocalGetAsCell(allAxes,'ZGrid');
    [null{:}] = deal('off');
    set(allAxes,{'XGrid'},null);
    set(allAxes,{'YGrid'},null);
    set(allAxes,{'ZGrid'},null);
    set(allNonText,'Visible','off');
    set(allAxes,'Color','none');
    print(H, tfile2, args{:});
    set(allNonText,{'Visible'},oldvis);
    set(allAxes,{'Color'},oldc);
    set(allAxes,{'XGrid'},oldaxg);
    set(allAxes,{'YGrid'},oldayg);
    set(allAxes,{'ZGrid'},oldazg);
    %hack up the postscript file
    fid1 = fopen(tfile,'w');
    fid2 = fopen(tfile2,'r');
    line = fgetl(fid2);
    while ischar(line)
      if strncmp(line,'%%Title',7)
	fprintf(fid1,'%s\n',['%%Title: ', tfile]);
      elseif (length(line) < 3) 
	fprintf(fid1,'%s\n',line);
      elseif ~strcmp(line(end-2:end),' PR') & ...
	    ~strcmp(line(end-1:end),' L')
	fprintf(fid1,'%s\n',line);
      end
      line = fgetl(fid2);
    end
    fclose(fid1);
    fclose(fid2);
    delete(tfile2);
    
  elseif ~opts.applystyle
    drawnow;
    print(H, filename, args{:});
  end
  warning(oldwarn);
  
catch
  warning(oldwarn);
  hadError = 1;
end

% Restore figure settings
if opts.applystyle
  varargout{1} = old;
else
  for n=1:length(old.objs)
    if ~iscell(old.values{n}) & iscell(old.prop{n})
      old.values{n} = {old.values{n}};
    end
    set(old.objs{n}, old.prop{n}, old.values{n});
  end
end

if hadError
  error(deblank(lasterr));
end

%
%  Local Functions
%

function outData = LocalPushOldData(inData, objs, prop, values)
outData.objs = {objs, inData.objs{:}};
outData.prop = {prop, inData.prop{:}};
outData.values = {values, inData.values{:}};

function cellArray = LocalGetAsCell(fig,prop,allowemptycell);
cellArray = get(fig,prop);
if nargin < 3
  allowemptycell = 0;
end
if ~iscell(cellArray) & (allowemptycell | ~isempty(cellArray))
  cellArray = {cellArray};
end

function newArray = LocalScale(inArray, scale, minv, maxv)
n = length(inArray);
newArray = cell(n,1);
for k=1:n
  newArray{k} = min(maxv,max(minv,scale*inArray{k}(1)));
end

function gray = LocalMapToGray1(color)
gray = color;
if ischar(color)
  switch color(1)
   case 'y'
    color = [1 1 0];
   case 'm'
    color = [1 0 1];
   case 'c'
    color = [0 1 1];
   case 'r'
    color = [1 0 0];
   case 'g'
    color = [0 1 0];
   case 'b'
    color = [0 0 1];
   case 'w'
    color = [1 1 1];
   case 'k'
    color = [0 0 0];
  end
end
if ~ischar(color)
  gray = 0.30*color(1) + 0.59*color(2) + 0.11*color(3);
end

function newArray = LocalMapToGray(inArray);
n = length(inArray);
newArray = cell(n,1);
for k=1:n
  color = inArray{k};
  if ~isempty(color)
    color = LocalMapToGray1(color);
  end
  if isempty(color) | ischar(color)
    newArray{k} = color;
  else
    newArray{k} = [color color color];
  end
end

function newArray = LocalMapColorToStyle(inArray);
inArray = LocalGetAsCell(inArray,'Color');
n = length(inArray);
newArray = cell(n,1);
styles = {'-','--',':','-.'};
uniques = [];
nstyles = length(styles);
for k=1:n
  gray = LocalMapToGray1(inArray{k});
  if isempty(gray) | ischar(gray) | gray < .05
    newArray{k} = '-';
  else
    if ~isempty(uniques) & any(gray == uniques)
      ind = find(gray==uniques);
    else
      uniques = [uniques gray];
      ind = length(uniques);
    end
    newArray{k} = styles{mod(ind-1,nstyles)+1};
  end
end

function newArray = LocalMapCData(inArray);
n = length(inArray);
newArray = cell(n,1);
for k=1:n
  color = inArray{k};
  if (ndims(color) == 3) & isa(color,'double')
    gray = 0.30*color(:,:,1) + 0.59*color(:,:,2) + 0.11*color(:,:,3);
    color(:,:,1) = gray;
    color(:,:,2) = gray;
    color(:,:,3) = gray;
  end
  newArray{k} = color;
end

function outData = LocalUpdateColors(inArray, prop, inData)
value = LocalGetAsCell(inArray,prop);
outData.objs = {inData.objs{:}, inArray};
outData.prop = {inData.prop{:}, {prop}};
outData.values = {inData.values{:}, value};
if (~isempty(value))
  if strcmp(prop,'CData') 
    value = LocalMapCData(value);
  else
    value = LocalMapToGray(value);
  end
  set(inArray,{prop},value);
end

function bool = LocalIsPositiveScalar(value)
bool = isnumeric(value) & ...
       prod(size(value)) == 1 & ...
       value > 0;

function value = LocalToNum(value,auto)
if ischar(value)
  if strcmp(value,'auto')
    value = auto;
  else
    value = str2num(value);
  end
end

%convert a struct to {field1,val1,field2,val2,...}
function c = LocalToCell(s)
f = fieldnames(s);
v = struct2cell(s);
opts = cell(2,length(f));
opts(1,:) = f;
opts(2,:) = v;
c = {opts{:}};

function c = LocalIsHG(obj,hgtype)
c = 0;
if (length(obj) == 1) & ishandle(obj) 
  c = strcmp(get(obj,'type'),hgtype);
end

function c = LocalHas3DPlot(a)
zticks = LocalGetAsCell(a,'ZTickLabel');
c = 0;
for k=1:length(zticks)
  if ~isempty(zticks{k})
    c = 1;
    return;
  end
end

function r = LocalUnionRect(r1,r2)
if isempty(r1)
  r = r2;
elseif isempty(r2)
  r = r1;
elseif max(r2(3:4)) > 0
  left = min(r1(1),r2(1));
  bot = min(r1(2),r2(2));
  right = max(r1(1)+r1(3),r2(1)+r2(3));
  top = max(r1(2)+r1(4),r2(2)+r2(4));
  r = [left bot right-left top-bot];
else
  r = r1;
end

function c = LocalLabelsMatchTicks(labs,ticks)
c = 0;
try
  t1 = num2str(ticks(1));
  n = length(ticks);
  tend = num2str(ticks(n));
  c = strncmp(labs(1),t1,length(labs(1))) & ...
      strncmp(labs(n),tend,length(labs(n)));
end

function r = LocalAxesTightBoundingBox(axesR, a)
r = [];
atext = findall(a,'type','text','visible','on');
if ~isempty(atext)
  set(atext,'units','points');
  res=LocalGetAsCell(atext,'extent');
  for n=1:length(atext)
    r = LocalUnionRect(r,res{n});
  end
end
if strcmp(get(a,'visible'),'on')
  r = LocalUnionRect(r,[0 0 axesR(3:4)]);
  oldunits = get(a,'fontunits');
  set(a,'fontunits','points');
  label = text(0,0,'','parent',a,...
	       'units','points',...
	       'fontsize',get(a,'fontsize'),...
	       'fontname',get(a,'fontname'),...
	       'fontweight',get(a,'fontweight'),...
	       'fontangle',get(a,'fontangle'),...
	       'visible','off');
  fs = get(a,'fontsize');

  % handle y axis tick labels
  ry = [0 -fs/2 0 axesR(4)+fs];
  ylabs = get(a,'yticklabels');
  yticks = get(a,'ytick');
  maxw = 0;
  if ~isempty(ylabs)
    for n=1:size(ylabs,1)
      set(label,'string',ylabs(n,:));
      ext = get(label,'extent');
      maxw = max(maxw,ext(3));
    end
    if ~LocalLabelsMatchTicks(ylabs,yticks) & ...
	  strcmp(get(a,'xaxislocation'),'bottom')
      ry(4) = ry(4) + 1.5*ext(4);
    end
    if strcmp(get(a,'yaxislocation'),'left')
      ry(1) = -(maxw+5);
    else
      ry(1) = axesR(3);
    end
    ry(3) = maxw+5;
    r = LocalUnionRect(r,ry);
  end

  % handle x axis tick labels
  rx = [0 0 0 fs+5];
  xlabs = get(a,'xticklabels');
  xticks = get(a,'xtick');
  if ~isempty(xlabs)
    if strcmp(get(a,'xaxislocation'),'bottom')
      rx(2) = -(fs+5);
      if ~LocalLabelsMatchTicks(xlabs,xticks);
	rx(4) = rx(4) + 2*fs;
	rx(2) = rx(2) - 2*fs;
      end
    else
      rx(2) = axesR(4);
      % exponent is still below axes
      if ~LocalLabelsMatchTicks(xlabs,xticks);
	rx(4) = rx(4) + axesR(4) + 2*fs;
	rx(2) = -2*fs;
      end
    end
    set(label,'string',xlabs(1,:));
    ext1 = get(label,'extent');
    rx(1) = -ext1(3)/2;
    set(label,'string',xlabs(size(xlabs,1),:));
    ext2 = get(label,'extent');
    rx(3) = axesR(3) + (ext2(3) + ext1(3))/2;
    r = LocalUnionRect(r,rx);
  end
  set(a,'fontunits',oldunits);
  delete(label);
end

function c = LocalManualAxesMode(old, allAxes, base)
xs = ['X' base];
ys = ['Y' base];
zs = ['Z' base];
oldXMode = LocalGetAsCell(allAxes,xs);
oldYMode = LocalGetAsCell(allAxes,ys);
oldZMode = LocalGetAsCell(allAxes,zs);
old = LocalPushOldData(old, allAxes, {xs}, oldXMode);
old = LocalPushOldData(old, allAxes, {ys}, oldYMode);
old = LocalPushOldData(old, allAxes, {zs}, oldZMode);
set(allAxes,xs,'manual');
set(allAxes,ys,'manual');
set(allAxes,zs,'manual');
c = old;

function val = LocalCheckAuto(val, auto)
if ischar(val) & strcmp(val,'auto')
  val = auto;
end
