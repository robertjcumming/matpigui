% ANNOTATOR  - add annotation to a figure or a uipanel
%
%    Annotation focused on panel or figure
%
%    Can add:
%
%        arrows
%        text
%        text boxes   *
%        speech boxes *
%        circle
%
%   * text and speech boxes have autowrapping of text when you enter the 
%      text - based on spaces.
%     To finish typing text press the enter key
%     To input a line break you hold down CTRL+ALT+ENTER
%     When deployed CTRL+ENTER will also do the same job.
%
%   Example
%
%     ANNOTATOR ( hFig );
%     ANNOTATOR ( hUIPanel );
%
%     % For using in a matpigui object.
%     ANNOTATOR ( hGui.getPageHandle ( 'pageName' ) );
%
%     ANNOTATOR()    % will launch a GUI with a uipanel for demo.
%
%  This will add buttons to the parent figure toolbar for interative annotation
%
%  All objects that are created have uicontext menus for editing
%
%  see also mpointer, matpigui
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: annotator.m 242 2015-09-22 07:26:11Z robertcumming $
classdef annotator < mpointer
  properties
    lineColor = [1 0 0];
    textColor = [0 0 0];
  end
  properties ( SetAccess = private )
    hDraw
%     hFig
    hToolbar
    hAx      
    aObj
    sqSpeech = cell(0);
    circle = cell(0);
    arrow = cell(0);
    userPointer = [];
    dPos = 0.0125
    version = '1.0.0.EN'
isStudent = 0
isDemo = 1
isDemoUser = 0
isUser = 0
isDeployable = 0
    daysRemaining
  end
  properties
    uic = [];
  end
  methods % constructor & destructor
    function obj = annotator ( hDraw, hAx )
      % obj = annotator()    % launches a demo - adding annotation to a uipanel
      %
      % obj = annotator ( hFig );
      % obj = annotator ( hUip );
      %
      % Pass in the figure or uipanel for the annotation to be drawn on
      % Inherits from the mpointer class & handle
    end
    function obj = delete ( obj )
    end
  end
  methods % public
    end
  end
end
