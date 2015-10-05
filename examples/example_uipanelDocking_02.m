% EXAMPLE_UIPANELDOCKING_02 
%
%  This shows an application having 2 panels which can both be undocked
%   It includes code to show how your callbacks should manage the fact
%   that you may have undocked panels.
%
%   when panels are undocked (duplicate) then new uicontrols/axes etc...
%    are created which means that the callbacks need to be prepared for this.
%
%
%   see also matpigui, example_uipanelDocking, example_uipanelDocking_03
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_uipanelDocking_02.m 215 2015-07-27 19:00:38Z Bob $
function example_uipanelDocking_02
  % initialise the object
  myApp = matpigui();
  % add a page
  myApp.addPage ( 'Primary' );
  % add 2 splits.
  names = { 'Left', 'Right'  };
  % add the splits
  myApp.split ( 'Primary', [1 2], names );
  % create some parameters for the uicontrols
  plotTypes = { 'sin' 'cos' 'tan' };
  colours = { 'r' 'b' 'g' };
  % in each split we will add two child uipanels
  for ii=1:length(names)
    % create names for the top and main panels
    % When using the docking feature its important to make these names linked
    %   e.g. build then from the uipanel name.
    controlNames{ii} = sprintf ( '%s_Title', names{ii} );
    mainUINames{ii} = sprintf ( '%s_Main', names{ii} );
    % Add the uipanels to each split.
    myApp.addUIC ( names{ii}, mainUINames{ii}, 'uipanel', 'Position', [0 0 0.9 1], 'BorderWidth', 0 );
    myApp.addUIC ( names{ii}, controlNames{ii}, 'uipanel', 'Position', [0.9 0 0.1 1], 'BorderWidth', 0 );
    % Add an axes to the main panel
    myApp.addAxes ( mainUINames{ii}, 'axes01', 'Position', [0.1 0.1 0.8 0.8] );
    % Add uicontrols to the controlPanel
    %   For the callbacks we add the app object and the UIControl.
    myApp.addUIC ( controlNames{ii}, 'plot',   'pushbutton', 'String', 'Plot',    'Position', [0 0.85 1 .1], 'Callback', @(obj,b)UpdatePlot ( myApp, obj ) );
    myApp.addUIC ( controlNames{ii}, 'type',   'listbox',    'String', plotTypes, 'Position', [0 0.55 1 .3], 'Callback', @(obj,b)UpdatePlot ( myApp, obj ) );
    myApp.addUIC ( controlNames{ii}, 'factor', 'edit',       'String', '10',      'Position', [0 0.45 1 .1], 'Callback', @(obj,b)UpdatePlot ( myApp, obj ) );
    myApp.addUIC ( controlNames{ii}, 'color',  'listbox',    'String', colours,   'Position', [0 0.15 1 .3], 'Callback', @(obj,b)UpdatePlot ( myApp, obj ) );
    % extract the panel handles:
    topPanel = myApp.getPageHandle ( controlNames{ii} );
    bottomPanel = myApp.getPageHandle ( mainUINames{ii} );
    % Set the pixel size.
    SetMinPixelSize ( topPanel, bottomPanel, 'right', 50 );
  end
  % add the docking capability
  %   names panels which are docked/undocked
  %   The controlNames -> the uipanel where the dock object will be placed.
  myApp.uipanelDocking ( names, controlNames, [0 0.95 1 0.05] );
end
function UpdatePlot ( myApp, uiObj )
  % This callback is for the normal panels - but since we have undock capability we need to allow for that.
  % We can get the parent name (the name of the control panel where the object is held
  parentName = myApp.getObjectName ( get ( uiObj, 'Parent' ) );
  
  % From the parent name we can use the fact the names are linked (see the construction comment above)
  %  to obtain the name of the main panel -> from this we can get the axes handle.
  mainName = regexprep ( parentName, 'Title', 'Main' );
  axH = myApp.hUIC.(mainName).axes01;
  
  % Get the uicontrol selection and values
  plotType = myApp.get ( parentName, 'type',   'selectedString' );
  factor   = myApp.get ( parentName, 'factor', 'str2double' );
  color    = myApp.get ( parentName, 'color',  'selectedString' );
  
  % Prep & plot
  x = [0:0.01:4*pi];
  switch plotType
    case 'sin'
      y = factor*sin(x);
    case 'cos'
      y = factor*cos(x);
    case 'tan'
      y = factor*tan(x);
  end
      
  % clear axes and plot
  cla( axH );
  plot ( axH, x, y, color );
  
end