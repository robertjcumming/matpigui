% MUISETCOLOR - a GUI color picker - standalone or embedded.
%
%   Select a color from an interactivce GUI
%
%   color = MUISETCOLOR();                % call on its own -> no default
%   color = MUISETCOLOR( [1 0 0] );       % define the 1st colorselected
%
%   The object can also be used to ,,,,
%
%
%   To load a temp color object into your GUI - which can be moved
%      f = figure;
%      uip = uipanel ( 'parent', f, 'Position', [0 0 0.4 0.4] )
%      muisetcolor([],uip)
%
%      f = figure;
%      uip = uipanel ( 'parent', f, 'Position', [0 0 0.4 0.4] )
%      muisetcolor([],uip)
%
%   Embed into a GUI to use in your own code:
%      f = figure;
%      uip = uipanel ( 'parent', f, 'Position', [0 0 0.4 0.4] )
%      cObj = muisetcolor([], uip, 'modal', false)
%
%      The selected color is at:  cObj.selectedColor
%
%  see also example_muisetcolor, mpointer
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: muisetcolor.m 217 2015-07-27 19:10:38Z Bob $
classdef muisetcolor < mpointer
  properties ( SetAccess = private )
    selectedColor
    originalColor  = [0 0 0]
  end
  events
    userSelectedColor
    userApply
  end
  methods % Constructor
    function obj = muisetcolor( varargin )
      % obj = muisetcolor ()
      % obj = muisetcolor ( [R G B] );
      % obj = muisetcolor ( [], hUip ); % load into an embedded uipanel;
      % obj = muisetcolor ( [R G B], hUip ); % load into an embedded uipanel.
      % obj = muisetcolor ( [], hUip, 'modal', false ); % load into permanent panel
      %
    end
    function obj = delete ( obj )
    end
  end
  methods % Public
    end
  end
end
