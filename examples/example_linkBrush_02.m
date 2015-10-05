% This is a more advanced exmaple
%  
%  linked data is stored in a struct
%  multiple plots on one page/tab.
%  4 of the 5 axes can be brushed.
%
%
%  see also mbrush, mlink, mEvent, matpigui, example_linkBrush_01
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_linkBrush_02.m 249 2015-10-05 09:55:34Z robertcumming $
classdef example_linkBrush_02 < handle
  properties ( GetAccess = private )
    hTab          % The parent figure
    link          % The link class
    hBrush        % the brush object
%     hPlot         % Handle to the plot which contains the links
  end
  methods % Constructor
    function obj = example_linkBrush_02 ()
      % Create a figure
      hFig = dialog ( 'position', [200 200 800 600], 'windowStyle', 'normal', 'name', 'Brush & Link Data example - www.matpi.com', 'resize', 'on' );
      centerfig(hFig);
      obj.hTab = matpigui ( hFig, 'buttonHeight', 0 );
      
      % Create 2 pages where plots will be created
      obj.hTab.addPage ( 'PrimaryPage'  );
      obj.hTab.addPage ( 'SecondaryPage' );
      % Create a number of axes which we will interact with through brusing and data linking
      obj.hTab.addAxes ( 'PrimaryPage', 'axes1', 'position', [0.055 0.075 0.8 0.23], 'iAxes', true );
      obj.hTab.addAxes ( 'PrimaryPage', 'axes2', 'position', [0.055 0.395 0.8 0.23], 'iAxes', true, 'nextplot', 'replace' );
      obj.hTab.addAxes ( 'PrimaryPage', 'axes3', 'position', [0.055 0.715 0.8 0.23], 'iAxes', true );
      
      % Create a secondary axes which we will use to prove source data has been updated
      obj.hTab.addAxes ( 'SecondaryPage', 'axes4', 'position', [0.055 0.100 0.8 0.375], 'nextplot', 'replace' );
      % Create an axes which has A v B which will be highlighted/brushed (even though X v Y was manipulated)
      obj.hTab.addAxes ( 'SecondaryPage', 'axes5', 'position', [0.055 0.575 0.8 0.375] );
      
      % initialise a toolbar for the gui (this creates a page selection
      % combo box, saveas (image) and copyClipboard toolbar icons.
      obj.hTab.toolbar ( 'init' );
      % Import some random data
      obj.randomData ( );
      
      % Get the data from the data object - the data can be at a struct sub level:
      x = obj.hTab.getData ( 'structData.X' );
      y = obj.hTab.getData ( 'structData.Y' );
      % Obtain the plot handles for all axes
      axes1 = obj.hTab.hUIC.PrimaryPage.axes1;
      axes2 = obj.hTab.hUIC.PrimaryPage.axes2;
      axes3 = obj.hTab.hUIC.PrimaryPage.axes3;
      axes4 = obj.hTab.hUIC.SecondaryPage.axes4;
      axes5 = obj.hTab.hUIC.SecondaryPage.axes5;
      
      % Initiate the first plot - this plot cannot be brushed.
      xx = linspace ( min(x), max(x), 100 );
      yy = interp1 ( [min(x) max(x)], [min(y) max(y)], xx );
      plot ( axes1, xx, yy, 'g.' );
      
      % Plot the data in the interactive (lhs) axes
      hPlot = plot ( axes1, x, y, 'bo' );
      
      % Set the title of the axes.
      title ( axes1, 'This axes can be brushed' );
      legend ( axes1, { 'otherData', 'X v Y' } )
      
      % Plot a single plot on axes 2
      secondaryX = 'structData.Y';
      secondaryY = 'structData.X';
      x = obj.hTab.getData ( secondaryX );
      y = obj.hTab.getData ( secondaryY );
      % Plot the data in the interactive (lhs middle) axes
      %  Note here we provide the XDataSource and YDataSource - this is required by the link.addChildLink command.
      secondLink = plot ( axes2, x, y, 'mx', 'XDataSource', secondaryX, 'YDataSource', secondaryY );
      title ( axes2, 'axes where brushed data are highlighted' );
      legend ( axes2, 'Y v X' )
      
      % Add a title and a button to the secondary (rhs) axes for user to manually update the plot
      title ( axes4, 'The User must manually update this axes' );
      obj.hTab.addUIC ( 'SecondaryPage', 'pushbutton', 'pushbutton', 'position', [0.6 0.02 0.3 0.05], 'Callback', @(a,b)obj.ManualUpdate(), 'String', 'Update Plot' );      

      % Plot the data in the interactive (lhs) axes
      hAvB = plot ( axes5, obj.hTab.getData ( 'structData.A' ), obj.hTab.getData ( 'structData.B' ), 'gs' );
      % Set the title in the lhs axes.
      title ( axes5, 'linked plot of A v B' );
      legend ( axes5, 'A v B' )
      
      % Create the brush object
      obj.hBrush = mbrush( axes1 );
      % Set the hit test for all plots to be off (allows selection over background image for example)
      obj.hBrush.setHitTest ( axes1, 'off' );
      % Tell the brush object what plot is to be brushed.
      obj.hBrush.addPlotsToBrush ( hPlot );
      % Add a second plot to be brushed - this one is on a different axes
%       obj.hBrush.addPlotsToBrush ( secondLink );
     obj.hBrush.addPlotsToHighlight ( secondLink );
      % Add secondary plot object -> this cannot be brushed directly but when the user brushes in axes1 it will be highlighted here.
      obj.hBrush.addPlotsToBrush ( hAvB );
%     obj.hBrush.addPlotsToHighlight ( hAvB );
      
      % Create the link between the axes and the data object.
      
      % Now create a link object 
      obj.link = mlink ( obj.hTab ); 
      obj.link.addChildLink ( hPlot, { 'structData.X' 'structData.Y' } ); % plotHandle, { 'X' 'Y' 'Z' }
      % Add another plot -> data link.  When data updated -> plot is also updated.
      %   In this exampale no variables are passed in -> in this case they MUST be provided in the X/YDataSource (see plot command above)
      obj.link.addChildLink ( secondLink );  
      % Add another linke -> where we provide the variable names of the data in the link
      obj.link.addChildLink ( hAvB, { 'structData.A' 'structData.B'} );
      
      % Simulate the data obj being updated (this demonstrates the link data from source -> to plot
      uiwait ( msgbox ( 'load more data - linking will update the plot' ) );
      % When user closes message box -> data is reloaded and the plots auto update.
      obj.randomData ( );
                  
      % Plot multiple plots on axes 3
      % This plots 2 curves - only 1 of which are linked.  Doing this when some data are brushed from axes 1 -> it
      %  is also removed from axes 3 -> but because of the other plots (index 1) the original data is shown in grey.
      thirdX = 'structData.X';
      thirdY = 'structData.Y';
      x = obj.hTab.getData ( thirdX );
      y = obj.hTab.getData ( thirdY );
      % Plot the data in the top left axes
      thirdLink(1) = plot ( axes3, x, y, '.',  'XDataSource', thirdX, 'YDataSource', thirdY, 'Color', [0.8 0.8 0.8] );
      thirdLink(2) = plot ( axes3, x, y, 'kx', 'XDataSource', thirdX, 'YDataSource', thirdY );

      title ( axes3, 'This axes can be brushed' );
      legend ( axes3, { 'source X v Y' 'X v Y'} )
      % Using this command multiple children can be added (in this case
      %  there is only 1) - but the input var could be an array
      obj.link.addMultipleChildren ( thirdLink(2) );
      
      % Add the data to be highlighted when brushing data are selected
      obj.hBrush.addPlotsToBrush ( thirdLink(2) );

      % Add brush items to the gui toolbar.
      obj.hBrush.add2ToolBar( hFig );
      
      % allow Ctrl-C to copy the figure to the clipboard.
      obj.hTab.setCopyFigure ( true );
      
      
%       axis ( axes1, 'equal' );
    end % Constructor
  end
  methods ( Access=private )
    function obj = ManualUpdate ( obj ) % Push button callback
      % Extract the x and y data from the data object
      x = obj.hTab.getData ( 'structData.A' );
      y = obj.hTab.getData ( 'structData.B' );
      % Plot the data in the secondary axes
      plot ( obj.hTab.hUIC.SecondaryPage.axes4, x, y, 'mx' );
      title ( obj.hTab.hUIC.SecondaryPage.axes4, 'User must manually update this axes' );
    end % ManualUpdate (push button callback)
    function obj = randomData ( obj )
      data.X = rand(20,20);
      data.xx = rand(20,20);
      data.xx = data.xx(:);
      data.xx(1:2:end) = 0.5;
      data.Y = (data.X(:)-.5).^2;
      data.Y = data.Y+0.1*(flipud((data.xx(:))-0.5).^2); % add some noise
      data.Y = data.Y+((data.xx(:).^2))-.5;              % add some more noise
      data.X = data.X(:)-.5;
      
      data.A = rad2deg(data.X);
      data.B = sin(data.A);
      
      vars = { 'X' 'Y' 'A' 'B' };
      for ii=1:length(vars)
        obj.hTab.addData ( sprintf ( 'structData.%s', vars{ii}), data.(vars{ii}) );
      end
    end
  end
end
function answer = rad2deg ( radians )
  answer = 180 * radians / pi ;
end
