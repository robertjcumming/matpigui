% IAXES2 - Under development a new version of iAxes
%
%    UNDOCUMENTED AT THIS STAGE.
%    
classdef iAxes2 < handle
  properties
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
  methods  % Constructor
    function obj = iAxes2 ( varargin )
    end
    function obj = panAxes ( obj, ax )
    end
    function obj = delete ( obj )
    end
  end
end
