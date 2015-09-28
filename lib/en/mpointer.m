% MPOINTER - a class for managing a mouse pointer
%
%   mObj = mpointer ( figure );
%
%   Use this to modify the mouse pointer, then when your finished
%   set it back to what it was before using the reset method.
%
%   You need to reset it back before you switch to a new shape.
%
%   Example:
%     mObj.setPointer ( 'move' );
%     pause ( 1 );
%     mObj.resetPointer;
%
%   see also annotator
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: mpointer.m 237 2015-09-17 16:13:40Z robertcumming $
classdef mpointer < handle
  properties ( SetAccess = protected )
    hFig
  end
  methods % Constructor
    function obj = mpointer ( hFig )
      % obj = mpointer ()
      % obj = mpointer ( hFig )
      %
      %  Create a pointer object.
    end
    function obj = delete(obj)
    end
  end
  methods
    function obj = setPointer ( obj, mode, force )
      % obj.setPointer ( mode );
      % obj.setPointer ( mode, force )
      %
      %  Valid modes:
      %     'none' 
      %     'selectIMG'
      %     'enterText'
      %     'move' 'drag'
      %     'dragStart' 'dragEnd'
      %     'dragTextBase' 'dragTextTop'
      %     'dragTextRight' 'dragTextLeft'
      %     'dragTextRightUp' 'dragTextLeftDown'
      %     'dragTextRightDown' 'dragTextLeftUp'
      %     'dragArrowPoint'
      %     'dragArrowBase'      
    end
    function obj = resetPointer ( obj )
    end
  end
end
