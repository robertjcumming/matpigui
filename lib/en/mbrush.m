% MBRUSH - interactive brushing of data
%
%  Interactive brushing of data, 2D, 3D
%
%  Data sources can be grouped into different formats for highlighting
%  Brushing has undo capability
%
%   Brushing can be done in rect or lasso mode
%
%   Have can be highlighted when mouse passes over in a circle, square, rect
%     or custom shape.
%
%
%  see also mEvent, mlink, exampleDataObj
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: mbrush.m 235 2015-09-15 09:29:06Z robertcumming $
classdef mbrush < handle
  properties ( GetAccess=public, SetAccess=public )
    lassoFormat                        % struct containing lasso plot properties
    userFcn                            % user function for replacing data
    brushFormat                        % struct containing brush plot properties
    histFormat                         % struct containing hist plot properties
    originalFormat                     % struct containing the original data plot properties
    groupFormat                        % format of a specific group
    groupOriginalFormat                % format for original group
    groupHistFormat                    % format of a group for hist plots.
    incGroupSelectionInToolbar = true  % is group selection (all, or individual) included in toolbar
    incRotate3D = false;               % include a 3D rotate option in the toolbar
    multiSelect = false;               % is the default to multi select point (i.e. control held by default)
    incOriginalSelectionInToolbar = false; %Include the original selection in the toolbar?
%     dispOriginal = false;              % display original flag - manual control if not from toolbar
  end
  properties ( GetAccess=public, SetAccess=protected )
    version = '1.0.0.EE'
    currAx                             % Current axes
    enabled = true;                    % Is brush enabled?
    selectedData                       % Struct containing selected brush data -> used in highlighting other plots
  end
  % Demo struct where demo properties are stored.
  events
    dataSelected
    dataBrushed
    selectionCleared
  end
  methods % Constructor
    function obj = mbrush ( ax )
      % MBRUSH constructor for creating a mbrush object
      %
      % obj = mbrush ( axesHandle )
      %
      % obj = mbrush ( 'demo' )  % same as mbrush()
    end
  end
  methods % public methods
    function obj = addHistogramToBrush ( obj, children, sourceData, hitTest )
      % Add a histogram object to brush (currently you can only add one)
      %  hist is added to the currently active group.
      %
      % obj.addHistogramToBrush ( hPlot, sourceData )
      % obj.addHistogramToBrush ( hPlot, sourceData, hitTest )
      %
      %  hPlot      - is the handle to the hist plot
      %  sourceData - the Y data used to create the hist plot
      %  hitTest    - ( 'auto' )  char string for setting hPlots HitTest variable 
    end
    function obj = addPlotsToBrush ( obj, children, hitTest )
      % Add child plots to brush (to the current active group).
      % obj.addPlotsToBrush ( )
      % obj.addPlotsToBrush ( hPlots )
      % obj.addPlotsToBrush ( hPlots, hitTest )
      %
      %  hPlots  - handles to plots which can be brushed
      %          - if not provided all children of ax used
      %  hitTest - ( 'auto' )  char string for setting hPlots HitTest variable 
      % 
    end
    function obj = addPlotsToHighlight ( obj, children )
      % Add plot children to highlight through brushing (can directly brush)
      %
      % obj.addPlotsToHighlight ( children )
      %
      %  Add other plots to be highlighted when brushed data selected
      %  This can be in other axes/figure etc...
    end
    function obj = add2ToolBar ( obj, hToolbar, removeMatlabDef )
      % Add mbrush controls to a toolbar item
      %
      % obj.add2ToolBar ( hToolbar )
      % obj.add2ToolBar ( hAxes )     % it will find the toolbar
      % obj.add2ToolBar ( hFig )      % it will find the toolbar
      %
      % obj.add2ToolBar ( hToolbar, matlabFigDefaultFlag )
      %
      %  A optional second argument to keep/remove the default Matlab toolbar
      %     default is to remove (true).
    end
    function obj = brushAllGroups (obj, flag )
      % brush all groups at the same time option
      %
      % obj.brushAllGroups ( true | false )
    end
    function obj = brushBy ( obj, varargin )
      % TODO
%       a=0
    end
    function obj = changeGroup ( obj, groupIndex )
      % Change the currently active group
      %
      % obj.changeGroup ( groupIndex )
      % obj.changeGroup ( [] )         % turn all on
      % obj.changeGroup ( 0 )          % turn all on
    end
    function obj = changeGroupName ( obj, group, name )
      % obj.changeGroupName ( groupID, name );
    end
    function obj = deleteSelection ( obj )
      % Delete the current selection (active group(s))
      %
      %  obj.deleteSelection();
      %
    end
    function obj = lassoBrush3D ( obj, ax, x, y, varargin )
      % Lasso 3D points
      %
      %  obj.lassoBrush3D ( axesHandle, x, y )
      %
      %  X and Y in normalized fig pixel co-ordinates
      %
      %   see lassoBrush for more info
      %
    end
    function obj = lassoBrush ( obj, ax, x, y, control, is3D, ax3D )
      % create a lasso brush selection
      %
      % obj.lassoBrush ( [x1 x2 .... xN], [y1 y2 .... yN] );
      % obj.lassoBrush ( [x1 x2 .... xN], [y1 y2 .... yN], control );
    end
    function obj = rectBrush ( obj, ax, x, y, varargin )
      % Create a rectangle brush selection
      %
      % obj.rectBrush ( [xmin xmax], [ymin ymax] );
      % obj.rectBrush ( [xmin xmax], [ymin ymax], control );
      % build the 4 corner points and use the lassoBrush function
    end
    function obj = rectBrush3D ( obj, ax, x, y, varargin )
      % Build a 3D rect brush selection
      %  obj.rectBrush3D ( axesHandle, x, y )
      %
      %  X and Y in normalized fig pixel co-ordinates
      %
      %   see rectBrush for more info
    end
    function obj = replaceData ( obj, method, varargin )
      % method to replace brushed data
      %
      % obj.replacedata ( 'const', constant );
      % obj.replacedata ( 'value', constant );
      % obj.replacedata ( 'linearInterp' )
      % obj.replacedata ( 'nan' )
      % obj.replacedata ( 'remove' )
      % obj.replacedata ( 'user' )
      %    uses obj.userFcn function handle.
      % obj.replacedata ( 'zero' )      
    end
    function obj = setHitTest ( obj, ax, flag )
      % Set the hit test property of children of the input axes
      %
      %  obj.setHittest ( ax, flag )
      %
      %  ax   - axes Handle
      %  flag - 'off' | 'reset'
    end
    function obj = setEnabled ( obj, flag )
      % toggle the brush enable property
      %
      %  obj.setEnabled()    % toggles state
      %  obj.setEnabled ( true | false )
    end
    function obj = undo ( obj )
      % Undo the last brushing replace data action
      %
      % obj.undo()
    end
  end
end
