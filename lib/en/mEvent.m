% An event object which contains extra infromation (var + data)
%
%  see also mbrush, mlink, exampleDataObj
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: mEvent.m 216 2015-07-27 19:08:53Z Bob $
classdef mEvent < event.EventData
  properties ( SetAccess=private )
    data % Any arg pairs passed in on construction are stored here.
  end
  methods
    function obj = mEvent(varargin)
      % obj = mEvent ( 'arg1', value1, arg2, value2, ...., argN, valN );
      %
      %  You can pass any arg pairs in the the class these are stored
      %   in the event and passed to any listener.
    end
  end
end
