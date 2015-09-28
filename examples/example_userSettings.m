% EXAMPLE_USERSETTINGS  - test function to show how to use runtime settings
%
%  Creates a GUI which has 2 pages
%   1. containing a plot
%   2. containing the automatically built settings
%
%   Run the GUI and change to the settings tab
%     Alter some of the settings and change back to the Main Gui page
%
%   Once you have changed some of the settings, exit out of the application
%     and reload it. 
%   You will see that the application has automatically saved your
%     changes to the settings.
%   
%
%   see also matpigui
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_userSettings.m 215 2015-07-27 19:00:38Z Bob $
function myApp = example_userSettings ( varargin )
  myApp = matpigui();
  myApp.addPage ( 'Main Gui', 'Callback', @(obj,event)UpdatePlot(myApp) );
  myApp.addAxes ( 'Main Gui', 'axes01' );
  % Create a settings structure
  settings.group1.plotType = { 'sin' 'cos' };  % this will create a popupmenu
  settings.group1.var1 = 10;                   % creates an edit box which contains a number
  settings.group1.var2 = 4;                    % creates an edit box which contains a number
  settings.group1.cla = true;                  % creates an check box to clear the plot or not
  % you can have 2 sub levels of fields:
  settings.group2.color.format = { 'r' 'g' 'b' };             % creates an popupmenu containing colours
  settings.group2.line.style = { '-' ':' '-.' '--' 'none' };  % creates an popupmenu containing line styles
    
  % Create a page for the settings to go
  myApp.addPage ( 'Settings' );
  % add the settings variable
  myApp.addSettingsUI ( 'Settings', settings ); 
  % load any user changes to the settings
  myApp.importSettingsFromFile ( 'example_userSettings.mat' ); 
  % init the toolbar
  myApp.toolbar ( 'init' );
  
  % update the plot
  UpdatePlot ( myApp )
end
% A function for updating the plot
function UpdatePlot ( myApp )
  % Get teh axes handle
  ax = myApp.getUIHandle ( 'Main Gui', 'axes01' );
  % or you could have done: 
  %   ax = myApp.hUIC.Main_Gui.axes01
  
  % Check setting for clearing hte axes
  if myApp.userSettings.group1.cla
    cla(ax);
  end
  % prepare and extract setting/plot information
  x = [0:0.01:4*pi];
  A = myApp.userSettings.group1.var1;
  B = myApp.userSettings.group1.var2;
  % switch the plot type:
  switch myApp.userSettings.group1.plotType
    case 'sin'
      y = A* sin(B*x);
    case 'cos'
      y = A* cos(B*x);
  end
  % Create the plot
  plot ( ax, x, y, 'color', myApp.userSettings.group2.color.format, 'linestyle', myApp.userSettings.group2.line.style );
  
end