function hh = rotateXLabels( ax, angle, varargin )
%rotateXLabels: rotate any xticklabels
%
%   hh = rotateXLabels(ax,angle) rotates all XLabels on axes AX by an angle
%   ANGLE (in degrees). Handles to the resulting text objects are returned
%   in HH.
%
%   hh = rotateXLabels(ax,angle,param,value,...) also allows one or more
%   optional parameters to be specified. Possible parameters are:
%     'MaxStringLength'   The maximum length of label to show (default inf)
%
%   Examples:
%   >> bar( hsv(5)+0.05 )
%   >> days = {'Monday','Tuesday','Wednesday','Thursday','Friday'};
%   >> set( gca(), 'XTickLabel', days )
%   >> rotateXLabels( gca(), 45 )
%
%   See also: GCA, BAR

%   Copyright 2006-2014 The MathWorks Ltd.

error( nargchk( 2, inf, nargin ) );
if ~isnumeric( angle ) || ~isscalar( angle )
    error( 'RotateXLabels:BadAngle', 'Parameter ANGLE must be a scalar angle in degrees' )
end
angle = mod( angle, 360 );

[maxStringLength] = parseInputs( varargin{:} );

% Get the existing label texts and clear them
[vals, labels] = findAndClearExistingLabels( ax, maxStringLength );

% Create the new label texts
h = createNewLabels( ax, vals, labels, angle );

% Reposition the axes itself to leave space for the new labels
repositionAxes( ax );

% If an X-label is present, move it too
repositionXLabel( ax );

% Store angle
setappdata( ax, 'RotateXLabelsAngle', angle );

% Only send outputs if requested
if nargout
    hh = h;
end

%-------------------------------------------------------------------------%
    function [maxStringLength] = parseInputs( varargin )
        % Parse optional inputs
        maxStringLength = inf;
        if nargin > 0
            params = varargin(1:2:end);
            values = varargin(2:2:end);
            if numel( params ) ~= numel( values )
                error( 'RotateXLabels:BadSyntax', 'Optional arguments must be specified as parameter-value pairs.' );
            end
            if any( ~cellfun( 'isclass', params, 'char' ) )
                error( 'RotateXLabels:BadSyntax', 'Optional argument names must be specified as strings.' );
            end
            for pp=1:numel( params )
                switch upper( params{pp} )
                    case 'MAXSTRINGLENGTH'
                        maxStringLength = values{pp};
                        
                    otherwise
                        error( 'RotateXLabels:BadParam', 'Optional parameter ''%s'' not recognised.', params{pp} );
                end
            end
        end
    end % parseInputs
%-------------------------------------------------------------------------%
    function [vals,labels] = findAndClearExistingLabels( ax, maxStringLength )
        % Get the current tick positions so that we can place our new labels
        vals = get( ax, 'XTick' );
        
        % Now determine the labels. We look first at for previously rotated labels
        % since if there are some the actual labels will be empty.
        ex = findall( ax, 'Tag', 'RotatedXTickLabel' );
        if isempty( ex )
            % Store the positions and labels
            labels = get( ax, 'XTickLabel' );
            if isempty( labels )
                % No labels!
                return
            else
                if ~iscell(labels)
                    labels = cellstr(labels);
                end
            end
            % Clear existing labels so that xlabel is in the right position
            set( ax, 'XTickLabel', {}, 'XTickMode', 'Manual' );
            setappdata( ax, 'OriginalXTickLabels', labels );
        else
            % Labels have already been rotated, so capture them
            labels = getappdata( ax, 'OriginalXTickLabels' );
            set(ex, 'DeleteFcn', []);
            delete(ex);
        end
        % Limit the length, if requested
        if isfinite( maxStringLength )
            for ll=1:numel( labels )
                if length( labels{ll} ) > maxStringLength
                    labels{ll} = labels{ll}(1:maxStringLength);
                end
            end
        end
        
    end % findAndClearExistingLabels
%-------------------------------------------------------------------------%
    function restoreDefaultLabels( ax )
        % Restore the default axis behavior
        removeListeners( ax );
        
        % Try to restore the tick marks and labels
        set( ax, 'XTickMode', 'auto', 'XTickLabelMode', 'auto' );
        rmappdata( ax, 'OriginalXTickLabels' );
        
        % Try to restore the axes position
        if isappdata( ax, 'OriginalAxesPosition' )
            set( ax, 'Position', getappdata( ax, 'OriginalAxesPosition' ) );
            rmappdata( ax, 'OriginalAxesPosition' );
        end
    end
%-------------------------------------------------------------------------%
    function textLabels = createNewLabels( ax, vals, labels, angle )
        % Work out the ticklabel positions
        zlim = get(ax,'ZLim');
        z = zlim(1);
        
        % We want to work in normalised coords, but this doesn't print 
        % correctly. Instead we have to work in data units even though it
        % makes positioning hard.
        ylim = get( ax, 'YLim' );
        if strcmpi( get( ax, 'XAxisLocation' ), 'Top' )
            y = ylim(2);
        else
            y = ylim(1);
        end
        
        % Now create new text objects in similar positions.
        textLabels = -1*ones( numel( vals ), 1 );
        for ll=1:numel(vals)
            textLabels(ll) = text( ...
                'Units', 'Data', ...
                'Position', [vals(ll), y, z], ...
                'String', labels{ll}, ...
                'Parent', ax, ...
                'Clipping', 'off', ...
                'Rotation', angle, ...
                'Tag', 'RotatedXTickLabel', ...
                'UserData', vals(ll));
        end
        % So that we can respond to CLA and CLOSE, attach a delete
        % callback. We only attach it to one label to save massive numbers
        % of callbacks during axes shut-down.
        set(textLabels(end), 'DeleteFcn', @onTextLabelDeleted);
        
        % Now copy font properties into the texts
        updateFont();
        % Update the alignment of the text
        updateAlignment();
 
    end % createNewLabels

%-------------------------------------------------------------------------%
    function repositionAxes( ax )
        % Reposition the axes so that there's room for the labels
        % Note that we only do this if the OuterPosition is the thing being
        % controlled
        if ~strcmpi( get( ax, 'ActivePositionProperty' ), 'OuterPosition' )
            return;
        end
        
        % Work out the maximum height required for the labels
        labelHeight = getLabelHeight(ax);
        
        % Remove listeners while we mess around with things, otherwise we'll
        % trigger redraws recursively
        removeListeners( ax );
        
        % Change to normalized units for the position calculation
        oldUnits = get( ax, 'Units' );
        set( ax, 'Units', 'Normalized' );
        
        % Not sure why, but the extent seems to be proportional to the height of the axes.
        % Correct that now.
        set( ax, 'ActivePositionProperty', 'Position' );
        pos = get( ax, 'Position' );
        axesHeight = pos(4);
        % Make sure we don't adjust away the axes entirely!
        heightAdjust = min( (axesHeight*0.9), labelHeight*axesHeight );
        
        % Move the axes
        if isappdata( ax, 'OriginalAxesPosition' )
            pos = getappdata( ax, 'OriginalAxesPosition' );
        else
            pos = get(ax,'Position');
            setappdata( ax, 'OriginalAxesPosition', pos );
        end
        if strcmpi( get( ax, 'XAxisLocation' ), 'Bottom' )
            % Move it up and reduce the height
            set( ax, 'Position', pos+[0 heightAdjust 0 -heightAdjust] )
        else
            % Just reduce the height
            set( ax, 'Position', pos+[0 0 0 -heightAdjust] )
        end
        set( ax, 'Units', oldUnits );
        set( ax, 'ActivePositionProperty', 'OuterPosition' );
        
        % Make sure we find out if axes properties are changed
        addListeners( ax );
        
    end % repositionAxes

%-------------------------------------------------------------------------%
    function repositionXLabel( ax )
        % Try to work out where to put the xlabel
        removeListeners( ax );
        labelHeight = getLabelHeight(ax);
        
        % Use the new max extent to move the xlabel. We may also need to
        % move the title
        xlab = get(ax,'XLabel');
        titleh = get( ax, 'Title' );
        set( [xlab,titleh], 'Units', 'Normalized' );
        if strcmpi( get( ax, 'XAxisLocation' ), 'Top' )
            titleExtent = get( xlab, 'Extent' );
            set( xlab, 'Position', [0.5 1+labelHeight-titleExtent(4) 0] );
            set( titleh, 'Position', [0.5 1+labelHeight 0] );
        else
            set( xlab, 'Position', [0.5 -labelHeight 0] );
            set( titleh, 'Position', [0.5 1 0] );
        end
        addListeners( ax );
    end % repositionXLabel

%-------------------------------------------------------------------------%
    function height = getLabelHeight(ax)
        height = 0;
        textLabels = findall( ax, 'Tag', 'RotatedXTickLabel' );
        if isempty(textLabels)
            return;
        end
        oldUnits = get( textLabels(1), 'Units' );
        set( textLabels, 'Units', 'Normalized' );
        for ll=1:numel(vals)
            ext = get( textLabels(ll), 'Extent' );
            if ext(4) > height
                height = ext(4);
            end
        end
        set( textLabels, 'Units', oldUnits );
    end % getLabelExtent

%-------------------------------------------------------------------------%
    function updateFont()
        % Update the rotated text fonts when the axes font changes
        properties = {
            'FontName'
            'FontSize'
            'FontAngle'
            'FontWeight'
            'FontUnits'
            };
        propertyValues = get( ax, properties );
        textLabels = findall( ax, 'Tag', 'RotatedXTickLabel' );
        set( textLabels, properties, propertyValues );
    end % updateFont

    function updateAlignment()
        textLabels = findall( ax, 'Tag', 'RotatedXTickLabel' );
        angle = get( textLabels(1), 'Rotation' );
        % Depending on the angle, we may need to change the alignment. We change
        % alignments within 5 degrees of each 90 degree orientation.
        if strcmpi( get( ax, 'XAxisLocation' ), 'Top' )
            if 0 <= angle && angle < 5
                set( textLabels, 'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Bottom' );
            elseif 5 <= angle && angle < 85
                set( textLabels, 'HorizontalAlignment', 'Left', 'VerticalAlignment', 'Bottom' );
            elseif 85 <= angle && angle < 95
                set( textLabels, 'HorizontalAlignment', 'Left', 'VerticalAlignment', 'Middle' );
            elseif 95 <= angle && angle < 175
                set( textLabels, 'HorizontalAlignment', 'Left', 'VerticalAlignment', 'Top' );
            elseif 175 <= angle && angle < 185
                set( textLabels, 'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Top' );
            elseif 185 <= angle && angle < 265
                set( textLabels, 'HorizontalAlignment', 'Right', 'VerticalAlignment', 'Top' );
            elseif 265 <= angle && angle < 275
                set( textLabels, 'HorizontalAlignment', 'Right', 'VerticalAlignment', 'Middle' );
            elseif 275 <= angle && angle < 355
                set( textLabels, 'HorizontalAlignment', 'Right', 'VerticalAlignment', 'Bottom' );
            else % 355-360
                set( textLabels, 'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Bottom' );
            end
        else
            if 0 <= angle && angle < 5
                set( textLabels, 'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Top' );
            elseif 5 <= angle && angle < 85
                set( textLabels, 'HorizontalAlignment', 'Right', 'VerticalAlignment', 'Top' );
            elseif 85 <= angle && angle < 95
                set( textLabels, 'HorizontalAlignment', 'Right', 'VerticalAlignment', 'Middle' );
            elseif 95 <= angle && angle < 175
                set( textLabels, 'HorizontalAlignment', 'Right', 'VerticalAlignment', 'Bottom' );
            elseif 175 <= angle && angle < 185
                set( textLabels, 'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Bottom' );
            elseif 185 <= angle && angle < 265
                set( textLabels, 'HorizontalAlignment', 'Left', 'VerticalAlignment', 'Bottom' );
            elseif 265 <= angle && angle < 275
                set( textLabels, 'HorizontalAlignment', 'Left', 'VerticalAlignment', 'Middle' );
            elseif 275 <= angle && angle < 355
                set( textLabels, 'HorizontalAlignment', 'Left', 'VerticalAlignment', 'Top' );
            else % 355-360
                set( textLabels, 'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Top' );
            end
        end
    end

%-------------------------------------------------------------------------%
    function onAxesFontChanged( ~, ~ )
        updateFont();
        repositionAxes( ax );
        repositionXLabel( ax );
    end % onAxesFontChanged

%-------------------------------------------------------------------------%
    function onAxesPositionChanged( ~, ~ )
        % We need to accept the new position, so remove the appdata before
        % redrawing
        if isappdata( ax, 'OriginalAxesPosition' )
            rmappdata( ax, 'OriginalAxesPosition' );
        end
        if isappdata( ax, 'OriginalXLabelPosition' )
            rmappdata( ax, 'OriginalXLabelPosition' );
        end
        repositionAxes( ax );
        repositionXLabel( ax );
    end % onAxesPositionChanged

%-------------------------------------------------------------------------%
    function onXAxisLocationChanged( ~, ~ )
        updateAlignment();
        repositionAxes( ax );
        repositionXLabel( ax );
    end % onXAxisLocationChanged

%-------------------------------------------------------------------------%
    function onAxesLimitsChanged( ~, ~ )
        % The limits have moved, so make sure the labels are still ok
        textLabels = findall( ax, 'Tag', 'RotatedXTickLabel' );
        xlim = get( ax, 'XLim' );
        ylim = get( ax, 'YLim' );
        if strcmpi( get( ax, 'XAxisLocation'), 'Bottom' )
            pos = [0 ylim(1)];
        else
            pos = [0 ylim(2)];
        end
        for tt=1:numel( textLabels )
            xval = get( textLabels(tt), 'UserData' );
            pos(1) = xval;
            % If the tick is off the edge, make it invisible
            if xval<xlim(1) || xval>xlim(2)
                set( textLabels(tt), 'Visible', 'off', 'Position', pos )
            elseif ~strcmpi( get( textLabels(tt), 'Visible' ), 'on' )
                set( textLabels(tt), 'Visible', 'on', 'Position', pos )
            else
                % Just set the position
                set( textLabels(tt), 'Position', pos );
            end
        end

        repositionXLabel( ax );
    end % onAxesPositionChanged

%-------------------------------------------------------------------------%
    function onTextLabelDeleted( ~, ~ )
        % The final text label has been deleted. This is likely from a 
        % "cla" or "close" call, so we should remove all of our dirty
        % hacks.
        restoreDefaultLabels(ax);
    end

%-------------------------------------------------------------------------%
    function addListeners( ax )
        % Create listeners. We store the array of listeners in the axes to make
        % sure that they have the same life-span as the axes they are listening to.
        axh = handle( ax );
        listeners = [
            handle.listener( axh, findprop( axh, 'FontName' ), 'PropertyPostSet', @onAxesFontChanged )
            handle.listener( axh, findprop( axh, 'FontSize' ), 'PropertyPostSet', @onAxesFontChanged )
            handle.listener( axh, findprop( axh, 'FontWeight' ), 'PropertyPostSet', @onAxesFontChanged )
            handle.listener( axh, findprop( axh, 'FontAngle' ), 'PropertyPostSet', @onAxesFontChanged )
            handle.listener( axh, findprop( axh, 'FontUnits' ), 'PropertyPostSet', @onAxesFontChanged )
            handle.listener( axh, findprop( axh, 'OuterPosition' ), 'PropertyPostSet', @onAxesPositionChanged )
            handle.listener( axh, findprop( axh, 'XLim' ), 'PropertyPostSet', @onAxesLimitsChanged )
            handle.listener( axh, findprop( axh, 'YLim' ), 'PropertyPostSet', @onAxesLimitsChanged )
            handle.listener( axh, findprop( axh, 'XAxisLocation' ), 'PropertyPostSet', @onXAxisLocationChanged )
            ];
        setappdata( ax, 'RotateXLabelsListeners', listeners );
    end % addListeners

%-------------------------------------------------------------------------%
    function removeListeners( ax )
        % Rempove any property listeners whilst we are fiddling with the axes
        if isappdata( ax, 'RotateXLabelsListeners' )
            delete( getappdata( ax, 'RotateXLabelsListeners' ) );
            rmappdata( ax, 'RotateXLabelsListeners' );
        end
    end % removeListeners



end % EOF