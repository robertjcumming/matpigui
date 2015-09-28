% EXAMPLE_IAXES - an example demonstrating the iAxes capabilities
%
%  see also iAxes, matpigui
%
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
% $Id: example_iAxes.m 215 2015-07-27 19:00:38Z Bob $
function example_iAxes
  % iAxes example
  home
  % create a figure for plotting
  f = figure;
  u1 = uipanel ( 'parent', f, 'position', [0 0 1 0.4] );
  u2 = uipanel ( 'parent', f, 'position', [0 0.4 1 0.6] );
%   u2 = uipanel ( 'parent', f, 'position', [0 0.0 1 1.0] );
  
  % create 2 axes
  ax(1) = axes ( 'parent', u2, 'position', [0.05 0.05 0.85 0.35], 'nextplot', 'add' ); title ( ax(1), 'axes 1' );
  ax(2) = axes ( 'parent', u2, 'position', [0.05 0.55 0.85 0.35], 'nextplot', 'add' ); title ( ax(2), 'axes 2' )
  x = [1:0.1:45];
  color = { 'r.-' 'b.-' 'ko-' 'm' };
  for i=1:2
    rnd = rand(1,length(x));
    plot ( ax(i), x, 4*sin(x)+cos(2*x)+x/4, color{i} );
    plot ( ax(i), x, sin(x)+rnd+x/4, color{i} );
    rnd = rand(1,length(x));
    plot ( ax(i), x, 2*sin(x)-rnd+x/4, color{i} );
    grid ( ax(i), 'on' );
    plot ( [0 45], [1 1], 'k-' )
  end

  % add a callback to the button down fcn to show that it is not overruled by the class:
  plt = @(a,b) set ( gca, 'Color', [rand(3,1)] );
  set ( ax(2), 'ButtonDownFcn', {plt} );
  % create the aAxes object.  By passing in 2 axes
  axObj = iAxes ( ax, 'xZoom', 1, 'yZoom', 1, 'magnifyAll', 1, 'xLink', 1, 'zoomLabel', 1 );
  axObj.magBorderColor = [1 0 0];
  
  % Manually add a magnificaiton at:
%   axObj.addMagnificationAt ( ax(2), [10 10] )
  
  % some instructions to the user
  uicontrol ( 'parent', u1, 'style', 'text', 'units', 'normalized', 'position', [0.02 0.8 0.96 0.1], 'string', 'Double left click on the axes to bring up a magnification glass - note that it is shown on both axes' )
  uicontrol ( 'parent', u1, 'style', 'text', 'units', 'normalized', 'position', [0.02 0.72 0.96 0.1], 'string', '   Left click on the magnification and move the mouse around and the magnification will move with you' )
  uicontrol ( 'parent', u1, 'style', 'text', 'units', 'normalized', 'position', [0.02 0.64 0.96 0.1], 'string', '   Use the mouse wheel scroll to zoom in and out of the current position' )
  uicontrol ( 'parent', u1, 'style', 'text', 'units', 'normalized', 'position', [0.02 0.56 0.96 0.1], 'string', '   Left click again to stop movement.  Double click away form the obj to remove it.' )
  uicontrol ( 'parent', u1, 'style', 'text', 'units', 'normalized', 'position', [0.02 0.48 0.96 0.1], 'string', '   Right click on the magnification to drag the fixed zoom plot to another location' )
  
  uicontrol ( 'parent', u1, 'style', 'text', 'units', 'normalized', 'position', [0.02 0.34 0.96 0.1], 'string', 'You can zoom by left (min) and right (max) clicking on the tick label area (just below the white axes) ', 'foregroundcolor', 'blue' )
  uicontrol ( 'parent', u1, 'style', 'text', 'units', 'normalized', 'position', [0.02 0.26 0.96 0.1], 'string', '  To reset middle click in the same area.', 'foregroundcolor', 'blue' )

  uicontrol ( 'parent', u1, 'style', 'text', 'units', 'normalized', 'position', [0.02 0.08 0.96 0.1], 'string', 'Double right click on the axes to bring up a annotation dialog for inserting text, arrows and measurements' )
end
