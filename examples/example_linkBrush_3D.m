% EXAMPLE_LINKBRUSH_3D example including 3D linking
%
% A 3D example of linked data and brushing
%  
%  3D plot axes 
%    1 plot X v Y (data linked & brushing allowed)
%    1 plot A v B (data linked & brushing highlighted)
%    1 plot A v B (no link -> user must manually update)
%
%   The source data is in two different groups
%     The user can brush all groups or each individually.
%
%
%  see also mbrush, mlink, mEvent, matpigui, example_linkBrush_02, example_linkBrush_01
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_linkBrush_3D.m 250 2015-10-05 19:57:02Z Bob $
classdef example_linkBrush_3D < handle
  properties ( SetAccess = private )
    hTab          % The parent figure
    link          % The link class
    hBrush        % the brush object
  end
  methods % Constructor
    function obj = example_linkBrush_3D ()
      % Create a figure
      hFig = dialog ( 'position', [100 100 1000 800], 'windowStyle', 'normal', 'name', 'Brush & Link Data example - www.matpi.com', 'resize', 'on' );
      
      % Create a matpigui object -> which will contain pages.
      obj.hTab = matpigui ( hFig, 'buttonHeight', 0 );
      
      % Create 2 pages where plots will be created
      obj.hTab.addPage ( '3D', 0.2  );
      % Create an axes which we will interact with through brusing and data linking
      obj.hTab.addAxes ( '3D', 'axes1', 'position', [0.1 0.10 0.8 0.4], 'iAxes', true ); 
      obj.hTab.addAxes ( '3D', 'axes2', 'position', [0.05 0.55 0.4 0.4], 'iAxes', true ); 
      obj.hTab.addAxes ( '3D', 'axes3', 'position', [0.55 0.55 0.4 0.4], 'iAxes', true ); 
      
      % initialise a toolbar for the gui (this creates a page selection
      % combo box, saveas (image) and copyClipboard toolbar icons.
      obj.hTab.toolbar ( 'init' );      
      
      % Import some random data
      obj.dataset1();
      obj.dataset2();
      
      %%  3D  Get the data from the data object - the data can be at a struct sub level:
      x = obj.hTab.getData ( 'data1.X' );
      y = obj.hTab.getData ( 'data1.Y' );
      z = obj.hTab.getData ( 'data1.Z' );
      % Obtain the plot handles for all axes
      axes3d   = obj.hTab.hUIC.F_3D.axes1;
      axes2d01 = obj.hTab.hUIC.F_3D.axes2;
      axes2d02 = obj.hTab.hUIC.F_3D.axes3;
      
      % Plot the data in the interactive (lhs) axes
      hPlot3d01 = plot3 ( axes3d, x, y, z, 'kx' );
      hPlot2d01 = plot ( axes2d02, x, y, 'k.' );
      grid ( axes3d, 'on' );
      
      % Get data from another source
      xx = obj.hTab.getData ( 'data2.X' );
      yy = obj.hTab.getData ( 'data2.Y' );
      zz = obj.hTab.getData ( 'data2.Z' );
      hPlot3d02 = plot3 ( axes3d, xx, yy, zz, 'bo' );
      hPlot2d02 = plot ( axes2d01, xx, yy, 'k.' );
      
      % Set the title of the axes.
      title ( axes3d, 'The data in this axes can be brushed' );
      
      view ( axes3d, 3);
      % Create the brush object
      obj.hBrush = mbrush( axes3d );
      % Set the hit test for all plots to be off (allows selection over background image for example)
      obj.hBrush.setHitTest ( axes3d, 'off' );
      % Tell the brush object what plot is to be brushed.
      obj.hBrush.addPlotsToBrush ( hPlot3d01 );
      obj.hBrush.addPlotsToBrush ( hPlot2d01 );
      obj.hBrush.changeGroup(2);
      obj.hBrush.addPlotsToBrush ( hPlot3d02 );
      obj.hBrush.addPlotsToBrush ( hPlot2d02 );
      % Turn it on for all groups to be highlighted at once.
      xlabel(axes3d,'X');
      ylabel(axes3d,'Y');
      zlabel(axes3d,'Z');

      
      % Create a link to a data object.
      obj.link = mlink ( obj.hTab ); 
      % Add the plots that are to contain link data
      obj.link.addChildLink ( hPlot3d01, { 'data1.X' 'data1.Y' 'data1.Z' } ); % handlePlot, { 'X' 'Y' 'Z' }
      obj.link.addChildLink ( hPlot3d02, { 'data2.X' 'data2.Y', 'data2.Z' } ); % handlePlot, { 'X' 'Y' 'Z' }
      obj.link.addChildLink ( hPlot2d02, { 'data2.X' 'data2.Y' } ); % handlePlot, { 'X' 'Y' 'Z' }
      obj.link.addChildLink ( hPlot2d01, { 'data1.X' 'data1.Y' } ); % handlePlot, { 'X' 'Y' 'Z' }

      % Set the brush all groups to true (you can change selection from the toolbar)
      obj.hBrush.brushAllGroups(true);

      % Add the brush items to the toolbar.
      obj.hBrush.add2ToolBar( hFig );
      
      % allow Ctrl-C to copy the figure to the clipboard.
      obj.hTab.setCopyFigure ( true );
      centerfig ( hFig );
    end % Constructor
  end
  methods ( Access=private )
    function obj = dataset1 ( obj )
      temp = rand(3,1000);
      data.X = temp(1,:);
      data.Y = temp(2,:).^2;
      data.Z = temp(3,:).^2;
      data.Freq = randi(10,size(temp,2),1).^2;
      vars = { 'X' 'Y' 'Z' 'Freq'};
      for ii=1:length(vars)
        obj.hTab.addData ( sprintf ( 'data1.%s', vars{ii}), data.(vars{ii}) );
      end
    end
    function obj = dataset2 ( obj )
      temp = rand(3,100);
      data.X = temp(1,:);
      data.Y = temp(2,:).^2;
      data.Z = temp(3,:).^2;
      vars = { 'X' 'Y' 'Z' };
      for ii=1:length(vars)
        obj.hTab.addData ( sprintf ( 'data2.%s', vars{ii}), data.(vars{ii}) );
      end
    end
  end
end