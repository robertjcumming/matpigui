% IAXES Convert a normal 2D axes into an interactive one with customised zooming and magnification.
%
% Example usage:
%
%    ax = axes ( '....' ) % normal Matlab call to create an axes
%    axesObj = iAxes ( ax ); %Create an axes which has the callbacks.
% 
%     If ax is an array of axes -> then the axes are linked and so when one is interacted with so are they all.
%      All of the public access variables can be set at launch by arg pairs - defaults shown below
%
%    axesObj ( ax, param1, value1, param2, value2, ...... );
%
%   see also example_iAxes
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: iAxes.m 216 2015-07-27 19:08:53Z Bob $
classdef iAxes < handle
  properties % public
    xZoom = true            % Flag to control min/max/auto zooming on x axes
    yZoom = true            % Flag to control min/max/auto zooming on y axes
    xLink = true            % If multiple axes -> is x zoom linked?
    yLink = true            % If multiple axes -> is y zoom linked?
    overrideHitTest = true  % Override the hitTest of children (make magnification easier)
    
    zoom = 5                % how much first zoom is
    factor = 1.1            % When scrolling with mouse -> how much factor in/out
    percentage = 33;        % Percentage of smallest dimension to make axes size
    zoomLabel = true        % On magnification plots are numeric labels shown
    zoomGridLines = true    % On magnification plots are grid lines shown
    zoomNLabel = 3;         % max number of lines (x and y) which will be labeled - requires zoomLabel and zoomGridLines to be true.
    pixelOffset = 18;       % number of pixels offset from axes for callacks to act upon.
    magBorderColor = [0 0 0]; % magnfified image colour.
  end
  
  properties (GetAccess=public, SetAccess=protected)
    version = '1.0.0.EE'
  end
  
  %------------------------------------------------- Methods
  methods  % public
    function obj = iAxes ( varargin )
      % axesObj = iAxes ( ax ); %Create an axes which has the callbacks.
      %
      % iAxes adds callbacks for zooming, magnification and annotating axes.
      %   also has the ability to link multiple axes together (one zoom -> they all zoom).
    end
  end
  methods
    function output = LicensedInfo ( obj )
      % obj.LicensedInfo
      % provide license information
    end
    function obj = addAxesLink ( obj, otherAx )
      % obj.addAxesLink ( axHandle );
      %  Add an axes to add for linking
    end
    function obj = addLinkAllAxes ( obj, parent )
      % obj.addAxesLink ( hParent )
      % hParent - figure, dialog, uipanel or uicontainer.
    end
    function obj = addMagnificationAt ( obj, ax, cp )
      % obj.addMagnification At ( ax, currentPoint )
      %
      %   add a magnificaiton object @ currentPoint (x,y);
    end
    function output = getFactor ( obj )
      % factor = obj.getFactor()
    end
    function output = getMagnifyAll ( obj )
      % flag = obj.getMagnifyAll()
    end
    function output = getXZoom ( obj )
      % zoom = obj.getXZoom()
    end
    function output = getYZoom ( obj )
      % zoom = obj.getYZoom()
    end
    function obj = setFactor ( obj, fact )
      % obj.setFactor ( factor );
    end
    function obj = setMagnifyAll ( obj, flag )
      % obj.setMagnifyAll ( boolean );
    end
    function obj = setXZoom ( obj, flag )
      % obj.setXZoom ( boolean )
    end
    function obj = setYZoom ( obj, flag )
      % obj.setYZoom ( boolean )
    end
  end
end
