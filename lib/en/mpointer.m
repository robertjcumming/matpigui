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
%  $Id: mpointer.m 263 2015-12-10 10:23:14Z robertcumming $
classdef mpointer < handle
  properties 
    fill = false;
  end
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
    function obj = setSpecial ( obj, mode )
      % obj.setSpecial ( mode )
      %
      %  set the mode but do not update the internal userPointer info
      % to reset use:
      %   obj.setSpecial ( 'user' );
    end
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
    function obj = changeUser ( obj, mode )
    end
    function obj = resetPointer ( obj )
    end
  end
end
