% EXAMPLE_LINKBRUSH_HISTOGRAM  - example linking a histogram
%
% A Histogram example of linked data and brushing
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
%  $Id: example_linkBrush_Histogram.m 224 2015-09-04 10:31:57Z robertcumming $
classdef example_linkBrush_Histogram < handle
  properties ( SetAccess = private )
    hTab          % The parent figure
    link          % The link class
    hBrush        % the brush object
%     hPlot         % Handle to the plot which contains the links
  end
  methods % Constructor
    function obj = example_linkBrush_Histogram ()
      % Create a figure
      hFig = dialog ( 'position', [100 100 1000 800], 'windowStyle', 'normal', 'name', 'Brush & Link Data example - www.matpi.com', 'resize', 'on' );
      
      % Create a matpigui object -> which will contain pages.
      obj.hTab = matpigui ( hFig );
      
      % Create 2 pages where plots will be created
      obj.hTab.addPage ( 'Histogram'  );

      % add the axes
      obj.hTab.addAxes ( 'Histogram', 'axes1', 'position', [0.05 0.37 0.45 0.26] ); 
      obj.hTab.addAxes ( 'Histogram', 'axes2', 'position', [0.05 0.69 0.9 0.26] ); 
      obj.hTab.addAxes ( 'Histogram', 'axes3', 'position', [0.55 0.37 0.45 0.26] ); 
      obj.hTab.addAxes ( 'Histogram', 'axes4', 'position', [0.05 0.03 0.45 0.26] ); 
      obj.hTab.addAxes ( 'Histogram', 'axes5', 'position', [0.55 0.03 0.45 0.26] ); 
      
      % initialise a toolbar for the gui (this creates a page selection
      obj.hTab.toolbar ( 'init' );      
      
      % Import some random data
      obj.dataset1();

      %% Histogram
      % Get some dta
      x = obj.hTab.getData ( 'data1.X' );
      y = obj.hTab.getData ( 'data1.Y' );
      z = obj.hTab.getData ( 'data1.Z' );
      % Get the axes handle
      ax2 = obj.hTab.hUIC.Histogram.axes2;
      % plot the Histogram data
      Histogram01 = plot ( ax2, x, y, 'k.' );
      title ( ax2, 'Y v X' );
      grid ( ax2, 'on' );
      
      % create a Histogram plot
      freq = obj.hTab.getData ( 'data1.Freq' );
      histogram ( obj.hTab.hUIC.Histogram.axes1, freq );
      hHistogram = obj.hTab.hUIC.Histogram.axes1.Children(end);
      title ( obj.hTab.hUIC.Histogram.axes1, 'Freq Histogram' );
      
      % plot the Histogram data
      histogram ( obj.hTab.hUIC.Histogram.axes3, x );
      hHistogramX = obj.hTab.hUIC.Histogram.axes3.Children(end);
      title ( obj.hTab.hUIC.Histogram.axes3, 'X Histogram' );

      histogram ( obj.hTab.hUIC.Histogram.axes4, y );
      hHistogramY = obj.hTab.hUIC.Histogram.axes4.Children(end);
      title ( obj.hTab.hUIC.Histogram.axes4, 'Y Histogram' );
      
      histogram ( obj.hTab.hUIC.Histogram.axes5, z, 'Orientation', 'Horizontal' );
      hHistogramZ = obj.hTab.hUIC.Histogram.axes5.Children(end);
      title ( obj.hTab.hUIC.Histogram.axes5, 'Z Histogram' );
      
      
      % create the brush object
      obj.hBrush = mbrush( ax2 );
      % add the plots and Histogramogram
      obj.hBrush.addPlotsToBrush ( Histogram01 );
      obj.hBrush.addHistogramToBrush ( hHistogram, freq );
      obj.hBrush.addHistogramToBrush ( hHistogramX, x );
      obj.hBrush.addHistogramToBrush ( hHistogramY, y );
      obj.hBrush.addHistogramToBrush ( hHistogramZ, z );

      % Create a link to a data object.
      obj.link = mlink ( obj.hTab );
      obj.link.addChildLink ( Histogram01, { 'data1.X' 'data1.Y' } ); 
      obj.link.addChildLink ( hHistogram, { [] 'data1.Freq' } ); 
      obj.link.addChildLink ( hHistogramX, { [] 'data1.X' } ); 
      obj.link.addChildLink ( hHistogramY, { [] 'data1.Y' } ); 
      obj.link.addChildLink ( hHistogramZ, { [] 'data1.Z' } ); 

      % Add the toggle option for to show all brushed data.
      obj.hBrush.incOriginalSelectionInToolbar = true;
      % Update the toolbar
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
  end
end