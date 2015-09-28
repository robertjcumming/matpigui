%WORKING_EXAMPLE_01  My one line help goes here
%
%
%  Add description here
%
%
%  see also matpigui, mguide, iAxes
%
%
%  This disclaimer must remain in the file produced (as per license)
%  File produced by MGUIDE Internal.1.0.0.AA
%  See www.matpi.com for user guide and latest information
%  Author:    Robert Cumming
%  Copyright: Matpi Ltd.
%  $Id: Working_Example_01.m 215 2015-07-27 19:00:38Z Bob $
function hObj = Working_Example_01
  % first create the figure handle
  hFig = dialog ( 'windowstyle', 'normal', 'name', 'Working Example 01', 'resize', 'on' );
  % now initiate the matpigui obj
  hObj = matpigui ( hFig, 'buttonHeight', 0.1, 'name', 'uigroup', 'Position', [0. 0. 1. 1.] );
  % Add each tab.
  hObj.addTab ( 'Plots', 0.1 , 'Callback',@(obj,event)Plots_SelCB ( hObj ), 'protected',0., 'titlebar',0., 'incCloseButton',0.);
  % Add any axes - all valid arg pairs can be passed in
  hObj.addAxes ( 'Plots', 'iAxes1', 'Position', [0.058962 0.08231 0.889937 0.632432] , 'iAxes', true, 'nextplot','replace');
  % Add any uic - all valid arg pairs can be passed in
  hObj.addUIC ( 'Plots', 'edit1', 'edit', 'Position', [0.4 0.944226 0.2 0.052088] , 'title', 'x vector (start:step:finish)', 'uicTitlePosition', 'left', ...
                 'String','-pi:0.01:pi', 'Callback',@(obj,event)Plots_SelCB ( hObj ));
  hObj.addUIC ( 'Plots', 'edit2', 'edit', 'Position', [0.4 0.861179 0.2 0.053563] , 'title', 'A:', 'uicTitlePosition', 'left', ...
                 'String','1', 'Callback',@(obj,event)Plots_SelCB ( hObj ));
  hObj.addUIC ( 'Plots', 'edit3', 'edit', 'Position', [0.4 0.780098 0.2 0.046929] , 'title', 'B:', 'uicTitlePosition', [0.35 0.78 0.05 0.04], ...
                 'String','1', 'Callback',@(obj,event)Plots_SelCB ( hObj ));
  hObj.addUIC ( 'Plots', 'popupmenu1', 'popupmenu', 'Position', [0.67673 0.858968 0.2 0.048894] , 'title', 'trig function', 'uicTitlePosition', 'above', ...
                  'String',{'sin' 'cos' 'tan' }, 'Callback',@(obj,event)Plots_SelCB ( hObj ));
  % Add each tab.
  hObj.addTab ( 'Data Viewer', 0.1 , 'Callback',@(obj,event)Data_SelCB ( hObj ), 'protected',0., 'titlebar',0., 'incCloseButton',0.);
 % Add any uic - all valid arg pairs can be passed in
  hObj.addUIC ( 'Data Viewer', 'uitable1', 'uitable', 'Position', [0.1 0.1 0.8 0.8] );
  
  % create a variable with setting properties
  % The settings var is split into sub groups:
  settings.plots.colour = { 'red'; 'green'; 'blue' };
  settings.plots.marker = { '.' 'o' 'x' '+' '*' 's' 'd' 'v' '^' '>' '<' 'p' 'h' };
  settings.plots.linestyle = {'-' ':' '-.' '--' 'none' };
  settings.plots.incMarker = true;
  settings.plots.incLine = true;
  % We create another field in settings and add other items to it.
  settings.general.clearAx = true;
  % Settings can have sub structs as well (this is not used in this code -
  %   just used for an example.
  settings.general.other.item = 10;
  % depending on the setting type - the matpigui framework will build the
  % appropriate UI type to give the user the ability to interact with it.
  
  % create a new tab called settings (same as before)
  hObj.addTab ( 'Settings' );
  
  % use the special method - to populate the settings tab
  %  with uicontrols to allow the user to interact with the
  %  settings
  hObj.addSettingsUI ( 'Settings', settings );
  

  % initialise the plots
  Plots_SelCB ( hObj )
end
% A callback associated with the selection of the plots tab.
function Plots_SelCB ( hObj )
  % get the axes handle from the class
  ax = hObj.getUIHandle ( 'Plots', 'iAxes1' );
  
  % get the stored data.  
  allData = hObj.getData ( 'y' );
  % clear the axes if the runtime setting flag it true.
  if hObj.userSettings.general.clearAx
    cla ( ax );
    allData = [];  % reset the internal data variable as well.
  end
  
  % the values of x, A and B must be retrieved - we can get it by providing:
  %  the name of the page and the name of the uicontrol using the get method
  x = str2num ( hObj.get ( 'Plots', 'edit1', 'String' ) );
  
  % dot notation can also be used to get properties:
  A = str2double ( hObj.hUIC.Plots.edit2.String );
  
  % some special get methods are coded in the get method
  B = hObj.get ( 'Plots', 'edit3', 'str2double' );
  
  % get the trig function to plot - again using a special method:
  % and calculcate y for ploting
  switch hObj.get ( 'Plots', 'popupmenu1', 'selectedString' )
    case 'sin'
      y = A .* sin ( B .* x );
    case 'cos'
      y = A .* cos ( B .* x );
    case 'tan'
      y = A .* tan ( B .* x );
    otherwise
      error ( 'matpi:WE01:PlotType', 'Unknown plot type' );
  end
  
  
  % settings can be retrieved using the method:
  colour    = hObj.getUserSetting ( 'plots', 'colour' );
  marker    = hObj.getUserSetting ( 'plots', 'marker' );
  lineStyle = hObj.getUserSetting ( 'plots', 'linestyle' );

  % settings can also be retrieved using dot notation
  incMarker = hObj.userSettings.plots.incMarker;
  incLine = hObj.userSettings.plots.incLine;
  
  % plot the data
  if iscell(colour); colour = colour{1}; end
  h = plot ( ax, x, y, 'color', colour );
  % set the marker and line style depending on the runtime flag.
  if incMarker
    set ( h, 'Marker', marker );
  else
    set ( h, 'Marker', 'none' );
  end
  if incLine
    set ( h, 'LineStyle', lineStyle );
  else
    set ( h, 'LineStyle', 'none' );
  end
  
  % add y to the allData variable, setting equal if it doesn't exist
  if isempty ( allData )
    allData = y';
  else
    allData(1:length(y),end+1) = y';
  end
  % Finally add the data to the class.
  hObj.addData ( 'y', allData );
end
% The callback for selecting the data viewer.
function Data_SelCB ( hObj )
  % Extract the data from the object
  y = hObj.getData ( 'y' );
  % Get the handle to the table
  h = hObj.getUIHandle ( 'Data Viewer', 'uitable1' );
  % Set the data in the table
  set ( h, 'Data', y )
end
