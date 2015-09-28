% MBRUSH - example to show how you can group data to brush independently
%  
%   Data added to MBRUSH can be put into different groups
%     These groups can be used for:
%        1. Only brushing certain data at a given time
%        2. Change format of data brushed (highlight different sources)
%
%   This example will automatically select different groups and select
%       data before allowing the user to work interactively.
%
%  see also mbrush, mlink, mEvent, matpigui, example_linkBrush_01
%           example_linkBrush_02, example_linkBrush_3D, example_linkBrush_hist
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
% $Id: example_linkBrush_03.m 219 2015-08-03 07:37:33Z robertcumming $
function [myApp, hBrush] = example_linkBrush_03( pauseLength )
  if nargin == 0; pauseLength = 2; end
  hFig = dialog ( 'position', [200 200 800 600], 'windowStyle', 'normal', 'name', 'Brush & Link Data example - www.matpi.com' );
  centerfig ( hFig );
  
  % Create a matpi gui object
  myApp = matpigui ( hFig );
  % add a page with an axes
  myApp.addPage ( 'primary' );
  myApp.addAxes( 'primary', 'ax' );
  
  % create some data
  data.s1.x = [0:0.1:10];
  data.s1.y = [0:0.1:10];
  data.s2.x = [0:0.1:10];
  data.s2.y = [10:-0.1:0];
  
  % add data to the gui
  myApp.addData ( 'exData', data );
  myApp.disableFigure();
    
  % get the axes and create the plots
  ax = myApp.hUIC.primary.ax;
  h1 = plot ( ax, data.s1.x, data.s1.y, 'kx' );
  h2 = plot ( ax, data.s2.x, data.s2.y, 'rx' );
  
  % set the axes title
  t{1} = 'Demo of how different plots can be added to different groups';
  t{2} = '2 Different Plots added to 2 different Groups';
  title ( ax, t );
  
  % create a mbrush object
  hBrush = mbrush( ax );
  
  % set the hit test off for all children in ax
  hBrush.setHitTest ( ax, 'off' );
  
  % add h1 ONLY to be brushed (this will be added to group 1 by default)
  hBrush.addPlotsToBrush ( h1 );
  
  % set the colour of the plots that are brushed in group 1.
  hBrush.groupFormat{1}.Color = [0 0 1];
  
  % Change the group and add the second plot
  hBrush.changeGroup(2);
  hBrush.addPlotsToBrush ( h2 );

  % set the colour of the plots that are brushed in group 2.
  hBrush.groupFormat{2}.Color = [0 1 0];
  
  % demo interactive selection of data
  hBrush.rectBrush ( ax, [2.5 7.5], [2.5 7.5] );
  % update the title.
  t{2} = 'Brush only plots in group 2';  title ( ax, t );
  pause ( pauseLength );
  
  % remove the selection
  hBrush.deleteSelection();
  % update the title
  t{2} = 'Clean Lasso and change to brush group 1 only';  title ( ax, t );
  pause ( pauseLength );
  % chagne the group one and demo interactive selection
  hBrush.changeGroup(1);
  hBrush.rectBrush ( ax, [2.5 7.5], [2.5 7.5] );
  % update tht title
  t{2} = 'Brush only plots in group 1';  title ( ax, t );
  pause ( pauseLength );
  
  % remove the selection
  hBrush.deleteSelection();
  t{2} = 'Clean Lasso and change to brush all groups';  title ( ax, t );
  pause ( pauseLength );
  t{2} = 'Brush only plots in all groups';  title ( ax, t );
  
  % set brushing to be active on all groups.
  hBrush.brushAllGroups(true);
  hBrush.rectBrush ( ax, [2.5 7.5], [2.5 7.5] );
  pause(pauseLength);
  % update the title
  t{2} = 'Change groups via the toolbar (on startup "All" selected)';  title ( ax, t );
  t{3} = 'Format can be changed interactively by right click on brushed data';  title ( ax, t );
  % remove all selection
  hBrush.deleteSelection();

  % set up the mlink object
  link = mlink ( myApp ); 
  % add the two plots to the link object
  link.addChildLink ( h1, { 's1.x' 's1.y' } ); 
  link.addChildLink ( h2, { 's2.x' 's2.y' } ); 
  
  % init the toolbar and add the mbrush items to the toolbar
  myApp.toolbar ( 'init' );
  hBrush.incOriginalSelectionInToolbar = true;
  hBrush.add2ToolBar( hFig );
  % option to force control on
%   hBrush.multiSelect = true;
  % enable the figure
  myApp.enableFigure();
end

