%% A script showing different ways of using the muisetcolor class.
% $Id: example_muisetcolor.m 215 2015-07-27 19:00:38Z Bob $

%% Test MUISETCOLOR
disp ( 'A script to test a number of different features of muisetcolor' );
%% launch standalone
color = muisetcolor;
disp ( color.selectedColor )

%% launch standalone with preselected color
color = muisetcolor ( [1 0 0] );
disp ( color.selectedColor )

%% lauch standalone linked to the color of a uicontrol
h = uicontrol ( 'string', 'ABC' );
color = muisetcolor ( h );
disp ( color.selectedColor )

%% launch standalone linked to the color of a uicontrol & set title
h = uicontrol ( 'string', 'ABC' );
color = muisetcolor ( h, 'title', 'Live Update of UIC' );
disp ( color.selectedColor )

%% launch standalone non-modal linked to the color of a uicontrol & set title
h = uicontrol ( 'string', 'ABC' );
color = muisetcolor ( h, 'title', 'Live Update of UIC', 'modal', false );


%% lauch standalone linked to the color of a plot & set title
h = plot ( rand(10), rand(10), 'r' );
color = muisetcolor ( h, 'title', 'Live Update of Plot' );
disp ( color.selectedColor )

%% embed into a moveable uipanel on a figure
f = figure;
uip = uipanel ( 'parent', f, 'Position', [0 0 0.4 0.4] );
var = muisetcolor(f,uip);

 
%% To embed into your own GUI and remain alive:
f = figure;
upb = uicontrol ( 'Style', 'pushbutton', 'String', 'Change Color - I will update', 'parent', f, 'Units', 'norm', 'Position', [0.6 0.6 0.4 0.2] );
uip = uipanel ( 'parent', f, 'Position', [0 0 0.4 0.4] );
var = muisetcolor(upb, uip, 'modal', false);
% 
% You can listen for user interaction
if exist ( 'mEvent.p', 'file' ) == 2 || exist ( 'mEvent.m', 'file' ) == 2 
%  If you have the mEvent class from the matpigui toolbox:
  addlistener ( var, 'userSelectedColor', @(a,v)fprintf('user changed color R:%f G:%f B:%f\n', v.data.selectedColor) )
  addlistener ( var, 'userApply',         @(a,v)fprintf('user applied color R:%f G:%f B:%f\n', v.data.selectedColor) )
else
  addlistener ( var, 'userSelectedColor', @(a,v)disp('user changed color') )
  addlistener ( var, 'userApply',         @(a,v)disp('user applied color change') )
end
% 
