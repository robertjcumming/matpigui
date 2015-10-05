% example_createAxesUsingSubplot - create sub plots and embed in MATPIGUI
%
%  An example of how to embed axes generated from subplot into your GUI
%
%  When axes are built normally in matpigui the position is required
%
%   You can use this trick to create them using subplot and embed
%   then into the application.
%
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
% $Id: example_fileIO.m 215 2015-07-27 19:00:38Z Bob $
function example_createAxesUsingSubplot
  hGui = matpigui();
  hGui.addTab ( 'tab1' );
  hPage = hGui.getPageHandle('tab1');
  % create the plot using sub plot
  ax1 = subplot(1,3,1, 'parent', hPage );
  ax2 = subplot(1,3,2, 'parent', hPage );
  % use the undocumented method:
  hGui.registerObj ( 'axes', ax1, 'tab1', 'axes01' );
  hGui.registerObj ( 'axes', ax2, 'tab1', 'axes01' );
  % 'axes'   -  type of object to be added
  % ax       - handle to object
  % 'tab1'   - name of page/tab to add object to
  % 'axes01' - is the name of the axes to be added - when you add a new object this must be unique
  %            new object this must be unique
  
  % add multiple in a loop
  hGui.addTab ( 'tab2' );
  hPage = hGui.getPageHandle('tab2');
  % loop to create many
  for ii=1:12
    ax1 = subplot(4,3,ii, 'parent', hPage );
    hGui.registerObj ( 'axes', ax1, 'tab2', sprintf ( 'axes%i', ii ) );
  end
  
end