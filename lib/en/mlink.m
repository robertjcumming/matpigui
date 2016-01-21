% class to link data between source and plot
%
%   Links data to update plots and source data due to user interaction
%
%   Similar to Matlab built in capability but this is faster and allows
%    for data in structs and requires user to define the data to be linked.
%
%  see also mbrush, mlink, mEvent
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: mlink.m 259 2015-11-15 21:12:57Z Bob $
classdef mlink < handle
  properties 
    dimCheck = true % flag to perform dimension check before updating plots
  end
  methods % constructor
    function obj = mlink ( dataObj, hPlot, variables )
      % mlink constructor
      %
      % mlink ( dataObject )
      % mlink ( dataObject, hPlot(s), { X Y Z } );
      %
      %  dataObject - the class where your data (to link is stored)
      %  hPlots - plots to link
      %  X, Y, Z the variables in the plots
    end
  end
  methods ( Access=public )
    function obj = addMultipleChildren ( obj, allChild, variables )
      % Add multiple plots to link
      % obj.addMultipleChildren ( hPlots )  % vars taken from {X/Y/Z}DataSource variables from the plot
      % obj.addMultipleChildren ( hPlots, variables )
    end
    function obj = addChildLink ( obj, hChild, variables )
      % Add an individual child plot to link data 
      % obj.addChildLink ( hChild )  % vars taken from {X/Y/Z}DataSource variables from the plot
      % obj.addChildLink ( hChild, variables )
    end
  end
end
