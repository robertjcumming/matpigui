%  example_dynamicPanel - a demo version of dynamicPanel
%
%   This is a demo function which will show how dynamic panel works
%    and it recreates the user interaction with the panel.
%
%   it is intended for teaching and demonstration
%
%
%  see also dynammicPanel
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_dynamicPanel.m 215 2015-07-27 19:00:38Z Bob $
function example_dynamicPanel
  %% Dynamic Testing Example
  % create a figure
  d = dialog ( 'name', 'www.matpi.com - Dynamic Panel Example', 'windowstyle', 'normal' );
  % place a uipanel on a figure
  uipA = uipanel ( 'parent', d, 'position', [0.05 0.05 0.85 0.9], 'backgroundColor', 'green' );
  % create another uipanel inside that one (this is used to verify the positioning of the panels
  uip = uipanel ( 'parent', uipA, 'position', [0.2 0.2 0.6 0.6] );
  % for visualisation place an axes on the panel
  axes ( 'parent', uip );
  % Create a dynamic Panel - attached to uip which when shown will have
  % a widths as shwon:
  dPanel = dynamicPanel ( uip, [0.15 0.1 0.1 0.05], {'top' 'right' 'left' 'bottom'}, 'backgroundColor', 'blue', 'borderWidth', 0 );
  % You can add controls to the dynamic panel:
  for ii=1:3
    uicontrol ( 'parent', dPanel.getDynPanel( ii ), 'style', 'pushbutton', 'units', ...
      'normalized', 'position', [0.1 0.1 0.8 0.2], 'string', sprintf ( 'Button %d', ii ) );
  end
  % Add a message to the GUI
  txt = uicontrol ( 'style', 'text', 'string', 'Immitation of user interacting with dynamic panels', 'units', 'normalized', 'position', [0 0 1 0.1], 'fontsize', 12, 'parent', uipA )
  
  % Toogle panels to display (this is representing the user hovering the mouse near the edge of the panel.
  dPanel.togglePanel ( 'right' );
  dPanel.togglePanel ( 'top' );
  dPanel.togglePanel ( 'left' );
  dPanel.togglePanel ( 'bottom' );
  
  % User moves the primary panel - dynamic panels will move to.
  set ( uip, 'Position', [0.1 0.3 0.6 0.6] );
  % This next line is not required in later releases of Matlab -> since the
  % addlistener capability does it for you (automatically).
  % It is included here to cover all versions of Matlab (R2008a onwards)
  dPanel.updatePanelPositions
  
  % Toggle some panels
  dPanel.togglePanel ( 'top' );
  dPanel.togglePanel ( 'left' );
  
  % Move the primary panel again
  set ( uip, 'Position', [0.3 0.1 0.7 0.9] );
  dPanel.updatePanelPositions
  
  % Toggle some panels
  dPanel.togglePanel ( 'top' );
  dPanel.togglePanel ( 'left' );
  
  % Hide all panels - immediately
  dPanel.hideAllPanel( 'fast' );
  
  % Show the top panel again
  dPanel.togglePanel ( 'top' );
  
  % You can remove panels as well.
  dPanel.deletePanel ( 'right' );

  % You can pin panels in position as well.
  dPanel.pin ( 'top' );

  % Panels can be permanently pinned - the user cannot "unpin"
%   dPanel.pin ( 'top', true );
  
  pause ( 0.5 );  
  % however you can always unpin via code:
  dPanel.unPin ( 'top' );
  
  
  set ( txt, 'string', sprintf ( 'Place the mouse near the left hand edge to make the panel appear\n  Then move into the centre to make then hide.' ) );
  
end