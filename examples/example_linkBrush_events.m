% EXAMPLE_LINKBRUSH_EVENTS - An example showing how to use mBrush events
%
%   Demonstrates the use of 3 events from mBrush:
%
%       dataSelected          % When the user selects data
%       selectionCleared      % When a selection is reset
%       dataBrushed           % When data is actually replaced.
%
%
%   hGui = EXAMPLE_LINKBRUSH_EVENTS
%
%   Returns a handle to the hGui object.
%
%    Brush the data in the lower plot - when the selection is
%      confirmed the selected data is plotted in the secondary window
%      through the use of events and listeners
%
%    When any data is brushed (e.g.) right click and replace with NaN
%      a messagebox appears which shows how many points and the Y range
%      which were brushed.
%
%   The ability to show the original brushed data is included in the toolbar
%    This is a toggle button.
%
%    see also mbrush, mlink, mEvent, matpigui
%
%  Copyright:  Matpi Ltd
%  Author:     Robert Cumming
%
% $Id: example_linkBrush_events.m 227 2015-09-04 13:39:45Z Bob $
function hGui = example_linkBrush_events ()
  %% Create a figure
  hFig = dialog ( 'position', [200 200 800 600], 'windowStyle', 'normal', 'name', 'Brush & Link Data example - www.matpi.com' );
  
  % Create the matpigui object
  hGui = matpigui ( hFig, 'buttonHeight', 0 );
  
  % Create 2 pages where plots will be created
  hGui.addPage ( 'PrimaryPage'  );
  % Create a number of axes which we will interact with through brushing and events
  hGui.addAxes ( 'PrimaryPage', 'axes1', 'position', [0.055 0.075 0.8 0.4], 'iAxes', true );
  hGui.addAxes ( 'PrimaryPage', 'axes2', 'position', [0.055 0.575 0.8 0.4], 'iAxes', true );
  
  % initialise a toolbar for the gui
  % combo box, saveas (image) and copyClipboard toolbar icons.
  hGui.toolbar ( 'init' );
  
  % Creeate some data and store in the object.
  hGui.data.X = -pi:0.01:pi;
  hGui.data.Y = sin(hGui.data.X);
  
  % Obtain the plot handles for all axes
  axes1 = hGui.hUIC.PrimaryPage.axes1;
  
  % Initiate the first plot - this plot cannot be brushed.
  x = hGui.data.X;
  y = hGui.data.Y;
  xx = linspace ( min(x), max(x), 100 );
  yy = interp1 ( [min(x) max(x)], [min(y) max(y)], xx );
  plot ( axes1, xx, yy, 'g.' );
  
  % Plot the data in the lower axes - save the handle as this data will be brushed
  hPlot = plot ( axes1, hGui.data.X, hGui.data.Y, 'bo' );
  
  % Set the title of the axes.
  title ( axes1, 'This axes can be brushed' );
  legend ( axes1, { 'otherData', 'X v Y' } )
  
  % Create the brush object
  hBrush = mbrush( axes1 );
  % Set the hit test for all plots to be off (allows selection over background image for example)
  hBrush.setHitTest ( axes1, 'off' );
  % Tell the brush object what plot is to be brushed.
  hBrush.addPlotsToBrush ( hPlot );
  
  % Now create a link object
  link = mlink ( hGui );
  % Add the hPlot handle and tell it the name of the variables which represent the X & Y Data.
  link.addChildLink ( hPlot, { 'X' 'Y' } );
  
  % Add a listener which for an event when any data selection is finalised, i.e. left button
  %  pressed a second time.
  addlistener ( hBrush, 'dataSelected', @(obj,event)listenForDataSelectedAction(obj,event,hGui) );
  % Add a listener for the data brushed event.
  addlistener ( hBrush, 'dataBrushed', @(obj,event)listenForDataBrushedAction(obj,event,hGui) );
  % Add a listener for the selection cleared event.
  addlistener ( hBrush, 'selectionCleared', @(obj,event)listenForSelectionCleared(obj,event,hGui) );
  
  % Add the toggle option for to show all brushed data.
  hBrush.incOriginalSelectionInToolbar = true;
  % Add brush items to the gui toolbar.
  hBrush.add2ToolBar( hFig );
  
  % allow Ctrl-C to copy the figure to the clipboard.
  hGui.setCopyFigure ( true );
end 
%% The listeners for the events are detailed below
function listenForSelectionCleared ( obj, event, hGui )
  % When the selection is cleared we clear the secondary axes data.
  cla(hGui.hUIC.PrimaryPage.axes2);
end
function listenForDataBrushedAction ( obj, event, hGui )
  %% Display a message box to highlight how many points have been brushed
  % and the Y range of data which has been brushed in this instance.
  s = sprintf ( 'Brushed %i data points', length(event.data.index) );
  s = sprintf ( '%s\n  Data Brushed Y Range %f to %f', s, max ( event.data.brushedY ), min ( event.data.brushedY ) );
  msgbox ( s, 'Info' )  
end
function listenForDataSelectedAction ( obj, event, hGui )
  % For this event we plot the selected data in a secondary axes
  % Get the axes handle
  axes2 = hGui.hUIC.PrimaryPage.axes2;
  % Extract all the x and y data from the brushed plot
  %  Use the event index propery to reduce the data to the selected data.
  x = event.data.hPlot.XData(event.data.index);
  y = event.data.hPlot.YData(event.data.index);
  % Plot the data on the axes
  plot(axes2,x,y, 'ro');
  % Force the X & Y limits to be the same -> makes it easier to visualise.
  axes2.XLim = hGui.hUIC.PrimaryPage.axes1.XLim;
  axes2.YLim = hGui.hUIC.PrimaryPage.axes1.YLim;
end
