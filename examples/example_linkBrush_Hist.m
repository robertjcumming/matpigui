% EXAMPLE_LINKBRUSH_HIST - linking a hist plot
%
% A hist example of linked data and brushing
%  
%  plot and corresponding hist of data
% 
%  Data can be brushed in the XvY plot or the hist plot and the selected
%   data will highlight in both plots.
%
%  see also mbrush, mlink, mEvent, matpigui, example_linkBrush_02, example_linkBrush_01
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_linkBrush_Hist.m 242 2015-09-22 07:26:11Z robertcumming $
classdef example_linkBrush_Hist < handle
  properties ( SetAccess = private )
    hTab          % The parent figure
    link          % The link class
    hBrush        % the brush object
%     hPlot         % Handle to the plot which contains the links
  end
  methods % Constructor
    function obj = example_linkBrush_Hist ()
      % Create a figure
      hFig = dialog ( 'position', [100 100 1000 800], 'windowStyle', 'normal', 'name', 'Brush & Link Data example - www.matpi.com', 'resize', 'on' );
      
      % Create a matpigui object -> which will contain pages.
      obj.hTab = matpigui ( hFig );
      
      % Create 2 pages where plots will be created
      obj.hTab.addPage ( 'Hist'  );

      % add the axes
      obj.hTab.addAxes ( 'Hist', 'axes1', 'position', [0.05 0.37 0.45 0.26] ); 
      obj.hTab.addAxes ( 'Hist', 'axes2', 'position', [0.05 0.69 0.9 0.26] ); 
      obj.hTab.addAxes ( 'Hist', 'axes3', 'position', [0.55 0.37 0.45 0.26] ); 
      obj.hTab.addAxes ( 'Hist', 'axes4', 'position', [0.05 0.03 0.45 0.26] ); 
      obj.hTab.addAxes ( 'Hist', 'axes5', 'position', [0.55 0.03 0.45 0.26] ); 
      
      % initialise a toolbar for the gui (this creates a page selection
      obj.hTab.toolbar ( 'init' );      
      
      % Import some random data
      obj.dataset1();

      %% Hist
      % Get some dta
      x = obj.hTab.getData ( 'data1.X' );
      y = obj.hTab.getData ( 'data1.Y' );
      z = obj.hTab.getData ( 'data1.Z' );
      % Get the axes handle
      ax2 = obj.hTab.hUIC.Hist.axes2;
      % plot the hist data
      hist01 = plot ( ax2, x, y, 'k.' );
      title ( ax2, 'Y v X' );
      grid ( ax2, 'on' );
      
      % create a hist plot
      freq = obj.hTab.getData ( 'data1.Freq' );
      hist ( obj.hTab.hUIC.Hist.axes1, freq, 4 );
      hHist = obj.hTab.hUIC.Hist.axes1.Children(end);
      hHist.FaceColor = [1 1 1];
      title ( obj.hTab.hUIC.Hist.axes1, 'Freq Hist' );
      
      % plot the hist data
      hist ( obj.hTab.hUIC.Hist.axes3, x );
      hHistX = obj.hTab.hUIC.Hist.axes3.Children(end);
      hHistX.FaceColor = [1 1 1];
      title ( obj.hTab.hUIC.Hist.axes3, 'X Hist' );

      hist ( obj.hTab.hUIC.Hist.axes4, y );
      hHistY = obj.hTab.hUIC.Hist.axes4.Children(end);
      hHistY.FaceColor = [1 1 1];
      title ( obj.hTab.hUIC.Hist.axes4, 'Y Hist' );
      
      hist ( obj.hTab.hUIC.Hist.axes5, z );
      hHistZ = obj.hTab.hUIC.Hist.axes5.Children(end);
      hHistZ.FaceColor = [1 1 1];
      title ( obj.hTab.hUIC.Hist.axes5, 'Z Hist' );
      
      
      % create the brush object
      obj.hBrush = mbrush( ax2 );
      % add the plots and histogram
      obj.hBrush.addPlotsToBrush ( hist01 );
      obj.hBrush.addHistogramToBrush ( hHist, freq );
      obj.hBrush.addHistogramToBrush ( hHistX, x );
      obj.hBrush.addHistogramToBrush ( hHistY, y );
      obj.hBrush.addHistogramToBrush ( hHistZ, z );

      % Create a link to a data object.
      obj.link = mlink ( obj.hTab );
      obj.link.addChildLink ( hist01, { 'data1.X' 'data1.Y' } ); 
      obj.link.addChildLink ( hHist, { [] 'data1.Freq' } ); 
      obj.link.addChildLink ( hHistX, { [] 'data1.X' } ); 
      obj.link.addChildLink ( hHistY, { [] 'data1.Y' } ); 
      obj.link.addChildLink ( hHistZ, { [] 'data1.Z' } ); 

      obj.hBrush.incOriginalSelectionInToolbar = true;
      obj.hBrush.add2ToolBar( hFig );
      
      % allow Ctrl-C to copy the figure to the clipboard.
      obj.hTab.setCopyFigure ( true );
      centerfig ( hFig );
      
      % Add a datatip to to the hist handle.
      mdatatip ( hist01 );
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
  end
end