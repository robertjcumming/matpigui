% MDATATIP - add a datatip to a line, plot, surface
%
%   MDATATIP ( hObj );
%   MDATATIP ( hObj, @userFunction );
%   MDATATIP ( hObj, @userFunction, arg1, arg2, ..., argN );
%
%   Click on hObj and a data tip will appear at the nearest source point
%   Clicking on the axes again will clear the point
%   Clicking on/near another point will remove the point & create a new one
%   Holding control down and clicking near/on a point will make a new one
%   Pressing the arrow keys will move the datatip
%  
%   Holding the left mouse down on the datatip will allow you to 
%    reposition the datatip (note position is reset when axes scales updated)
%
%
%   see also example_mdatatip
%
%   Author:    Robert Cumming
%   Copyright: Matpi Ltd.
%   $Id: mdatatip.m 263 2015-12-10 10:23:14Z robertcumming $
%
classdef mdatatip < mpointer
  properties
    backgroundColor = [1 1 0.667];% datatip background color.
    foregroundColor = [0 0 0];    % text color
    userFcn                       % user callback function to create datatip text
    userArgs = cell(0);           % any userArgs to the user callback function
    formatStr = '%4.3f';          % txt format string
    highlightPoint = true         % boolean flag for highlighting selected point
    highlightColor = 'r';         % highlight point marker color
    highlightMarker = 'o';        % highlight point marker format
    active = true;                % if false -> creation & deleting tips not possible
  end
  methods % Constructor
    function obj = mdatatip ( hLine , userFunction, varargin )
      % obj = mdatatip ( hLine, userFcn )
      %
      %  hLine is an object which is plotted
      %
      %  optional:
      %    userFunction is a function to create the txt str to display
      %                 if not provided X, Y is displayed
      %             
    end
    function obj = delete ( obj )
      % Delete the object
      % obj.delete()
    end
    function obj = cleanUp ( obj )
      % Force a clean up of the datatip
      % obj.cleanUp()
    end
    function obj = addLink ( obj, varargin )
      % Add a clickable link to the botton of your datatip
      %
      % obj.addLink ( @(obj,event)yourFunction ( yourArgs ) );
      % obj.addLink ( 'link Txt', @(obj,event)yourFunction ( yourArgs ) );
      %
    end
  end
  methods % Public
    function obj = showDataTip ( obj, hObj, xx, yy, zz )
      % obj.showDataTip ( hObj, x, y )
      % obj.showDataTip ( hObj, x, y, z )
    end
  end
end
