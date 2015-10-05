% DYNAMICPANEL creates uipanel(s) hidden by default appear interactively.
% 
%   DYNAMICPANL is a class which creates extra panel(s) which are hidden 
%        by default and appear when the user places the mouse near them
% 
% The panels can be located on any side of a uipanel, uicomponent*.
% 
% When the panels appear then the parent panel reduces in size automatically.
% 
% A DYNAMICPANEL is created as shown:
% 
%    % Create a new object which initially has no dynamic panels - to be added later
%    dPanel = dynamicPanel ( hParent );
%    
% 
%    % Create a new dynamic panel with panels defined initially 
%    dPanel = dynamicPanel ( hParent, width, position, varargin )
% 
%    hParent   - A handle to a uipanel, uicomponent
%    width     - The width of each panel (normalized to size of hParent)
%    position  - location of panel(s). 
%              -   Valid positions are:  'top' 'right' 'left' 'bottom'
% 
%    varargin  - arg pairs valid for a uipanel.
%
%   see also matpigui
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: dynamicPanel.m 215 2015-07-27 19:00:38Z Bob $
classdef dynamicPanel < handle
  properties 
    tWait = 2;           % time to wait on no mouse movement to trigger  
    nSteps = 20          % number of steps in the dynamic panel being show
    traverseTime = 0.5   % how long the dynamic panel will take to traverse
  end
  properties ( SetAccess = private )
    version = '1.0.0.EH'
  end
  methods % constructor and destructor
    function obj = dynamicPanel( userPanel, hiddenWidth, hidePosition, varargin )
      %  dPanel = dynamicPanel ( hParent, width, position, varargin )
      % 
      %  hParent   - A handle to a uipanel, uicomponent
      %  width     - The width of each panel (normalized to size of hParent)
      %  position  - location of panel(s). 
      %              -   Valid positions are:  'top' 'right' 'left' 'bottom'
      % 
      %  varargin  - arg pairs valid for a uipanel.      
    end
    function delete ( obj )
      % obj.delete  % Destructor
    end
  end
  methods % Public Methods
    function obj = addPanel ( obj, varargin )
      %  obj.addPanel ( hParent, width, position, argPairs )
      %  obj.addPanel ( width, position, argPairs )
      % 
      %  hParent  - if not already initialised - the parent panel needs to be passed in.
      %  width    - normalised width of hidden panel when shown
      %  position - location of panel - 'right', 'left', 'top' or 'bottom'
      %  argPairs - valid arg pairs for the panel parent.
    end
    function deletePanel ( obj, location )
      % obj.deletePanel ( location )
      % location - position of the panel to remove. ('right', 'left', 'top' or 'bottom')
    end
    function output = getDynPanel ( obj, location )
      %  h = obj.getDynPanel ( location )
    end
    function output = getLocation ( obj, index )
      % location = obj.getLocation ( index )
      % index    - integer 1 to 4.
    end
    function output = getName ( obj, location )
      % name = obj.getName ( location )
      % location - valid position in text ('right', 'left', 'top' or 'bottom')
    end
    function output = getWidth ( obj, location )
     % name = obj.getName ( location )
     % location - valid position in text ('right', 'left', 'top' or 'bottom')
    end
    function output = hasPanel ( obj, location )
      % name = obj.getName ( location )
      % location - valid position in text ('right', 'left', 'top' or 'bottom')
    end
    function obj = hideAllPanel ( obj, mode )
      % obj.hideAllPanel ()
      % obj.hideAllPanel ( 'fast' )
    end
    function obj = hideToken ( obj, location )
    % obj.hideTokan ( location )
    % location - valid position in text ('right', 'left', 'top' or 'bottom')
    end
    function obj = pin ( obj, location, permanent )
      % obj.pin ( location )
      % obj.pin ( location, permanent )
      %       
      % location  - valid position in text ('right', 'left', 'top' or 'bottom')
      % permanent - is panel to be fixed in position (user cannot unpin and hide)   
    end
    function obj = setName ( obj, location, name )
      % obj.setName ( location, name )
      % location  - valid position in text ('right', 'left', 'top' or 'bottom')
      % name      - The new name for the panel
    end
    function obj = setWidth ( obj, location, width )
      % obj.setWidth ( location, width )
      % location  - valid position in text ('right', 'left', 'top' or 'bottom')
      % width     - Normalised width of the panel.
    end
    function obj = showAllPanel ( obj, mode )
    end
    function obj = showToken ( obj, location )
    end
    function obj = togglePanel ( obj, location )
    end
    function obj = unPin ( obj, location )
    end
    function obj = updatePanelPositions( obj )
      %%
    end
  end
end
