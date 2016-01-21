% A basic example of linked data nd brushing
%  
%  3 axes 
%    1 plot X v Y (data linked & brushing allowed)
%    1 plot A v B (data linked & brushing highlighted)
%    1 plot A v B (no link -> user must manually update)
%
% 
%    This example shows the basic options for brushing and data linking
%    The axes which has to be manually updated is used to provide access
%    to the variables at any time -> this can check that the linked data
%    has been updated correctly.
%
%  see also mbrush, mlink, mEvent, matpigui, example_linkBrush_02
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
% $Id: example_linkBrush.m 250 2015-10-05 19:57:02Z Bob $
classdef example_linkBrush < handle
  properties ( GetAccess = private )
    hTab          % The parent figure
    link          % The link class
    hBrush        % the brush object
%     hPlot         % Handle to the plot which contains the links
  end
  methods % Constructor
    function obj = example_linkBrush ()
      % Create a figure
      hFig = dialog ( 'position', [100 100 800 600], 'windowStyle', 'normal', 'name', 'Brush & Link Data example - www.matpi.com' );
      centerfig ( hFig );
      
      % Create a matpigui object -> which will contain pages.
      obj.hTab = matpigui ( hFig, 'buttonHeight', 0 );
      
      % Create 2 pages where plots will be created
      obj.hTab.addPage ( 'PrimaryPage', 0.2  );
      obj.hTab.addPage ( 'SecondaryPage', 0.2 );
      % Create an axes which we will interact with through brusing and data linking
      obj.hTab.addAxes ( 'PrimaryPage', 'axes1', 'position', [0.1 0.1 0.8 0.8], 'iAxes', true );
      
      % Create a secondary axes which we will use to prove source data has been updated
      obj.hTab.addAxes ( 'SecondaryPage', 'axesA', 'position', [0.055 0.100 0.8 0.375], 'nextplot', 'replace' );
      
      % Create an axes which has A v B which will be highlighted/brushed (even though X v Y was manipulated)
      obj.hTab.addAxes ( 'SecondaryPage', 'axesB', 'position', [0.055 0.575 0.8 0.375] );
      
      % initialise a toolbar for the gui (this creates a page selection
      % combo box, saveas (image) and copyClipboard toolbar icons.
      obj.hTab.toolbar ( 'init' );      
      
      % Import some random data
      obj.randomData ( );
      
      % Get the data from the data object - the data can be at a struct sub level:
      x = obj.hTab.getData ( 'X' );
      y = obj.hTab.getData ( 'Y' );
      % Obtain the plot handles for all axes
      axes1 = obj.hTab.hUIC.PrimaryPage.axes1;
      axesA = obj.hTab.hUIC.SecondaryPage.axesA;
      axesB = obj.hTab.hUIC.SecondaryPage.axesB;
      
      % Initiate the first plot - this plot cannot be brushed.
      xx = linspace ( min(x), max(x), 100 );
      yy = interp1 ( [min(x) max(x)], [min(y) max(y)], xx );
      plot ( axes1, xx, yy, 'g.' );
      
      % Plot the data in the interactive (lhs) axes
      hPlot = plot ( axes1, x, y, 'kx' );
      
      % Set the title of the axes.
      title ( axes1, 'The data in this axes can be brushed' );
      
      
      % Add a title and a button to the secondary (rhs) axes for user to manually update the plot
      title ( axesA, 'user must manually update this axes' );
      obj.hTab.addUIC ( 'SecondaryPage', 'pushbutton', 'pushbutton', 'position', [0.6 0.02 0.3 0.05], 'Callback', @(a,b)obj.ManualUpdate(), 'String', 'Update Plot' );      

      % Plot the data in the interactive (lhs) axes
      hAvB = plot ( axesB, obj.hTab.getData ( 'A' ), obj.hTab.getData ( 'B' ), 'gs', 'XDataSource', 'A', 'YDataSource', 'B' );
      % Set the title in the lhs axes.
      title ( axesB, 'linked plot of A v B' );
      
      % Create the brush object
      obj.hBrush = mbrush( axes1 );
      % Set the hit test for all plots to be off (allows selection over background image for example)
      obj.hBrush.setHitTest ( axes1, 'off' );
      % Tell the brush object what plot is to be brushed.
      obj.hBrush.addPlotsToBrush ( hPlot );
      
      % Add another plot to highlight the brushed selection - this one is on a different axes
      %   and plotting different variables ( note X v Y is in axes1 -> this is A v B)
      % 
      % Using this command allows data to be selected/brushed
      % obj.hBrush.addPlotsToBrush ( hAvB );
      % Using this command shows brushed data in this plot (and acess to UIC).       
      obj.hBrush.addPlotsToHighlight ( hAvB );
      
      % Create a link to a data object.
      obj.link = mlink ( obj.hTab ); 
      % Add the plots that are to contain link data
                          % handlePlot, { 'X' 'Y' 'Z' }
      obj.link.addChildLink ( hPlot, { 'X' 'Y' } ); 
      % Add another plot -> data link.  When data updated -> plot is also updated.
      %   In this exampale NO variables are passed in -> in this case they MUST be provided in the X/YDataSource (see plot command above)
      obj.link.addChildLink ( hAvB );
                        
      % Add brush items to the figure toolbar.
      obj.hBrush.add2ToolBar( hFig );
      
      % allow Ctrl-C to copy the figure to the clipboard.
      obj.hTab.setCopyFigure ( true );
      
      % help
      msgbox ( sprintf ( 'Left click on the axes, release, move the mouse the left click to selectd data\nLeft click, move mouse then right click to select data using lasso method, continue to right click - left click will finalise\nRight click context menu provides options to modify the data' )  );
    end % Constructor
  end
  methods ( Access=private )
    function obj = ManualUpdate ( obj ) % Push button callback
      % Extract the x and y data from the data object
      x = obj.hTab.getData ( 'A' );
      y = obj.hTab.getData ( 'B' );
      % Plot the data in the secondary axes
      plot ( obj.hTab.hUIC.SecondaryPage.axesA, x, y, 'mx' );
      title ( obj.hTab.hUIC.SecondaryPage.axesA, 'User must manually update this axes' );
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
        obj.hTab.addData ( vars{ii}, data.(vars{ii}) );
      end
    end
  end
end

function answer = rad2deg ( radians )
  answer = 180 * radians / pi ;
end
