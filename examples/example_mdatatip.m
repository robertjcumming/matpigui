% A script with a number of examples of how to use the mdatatip function
%  advised to open in editor and run each section on its own.
%
% $Id: example_mdatatip.m 223 2015-09-01 20:43:34Z robertcumming $

%% This creates a plot where you can add datatips to a given line
clear
f = figure;
ax = axes ( 'parent', f );
iAxes(ax); % this allows you to zoom in and out by clicking on the x/y label area.
x = 0:0.1:pi;
y = sin(2*x);
h=plot ( ax, x, y );
mdatatip(h);
%% This creates a plot where you can add datatips to a given line
%  Note the first line ('r-x') you cannot find the datatips
clear
f = figure;
ax = axes ( 'parent', f );
iAxes(ax);
x = 0:0.1:pi;
y = sin(2*x);
plot ( ax, x, -y, 'rx-' );
h=plot ( ax, x, y, 'b-o' );
mdatatip(h);
legend ( 'no datatip', 'datatip' )
%% This creates a plot where you can add datatips to multile lines
clear
f = figure;
ax = axes ( 'parent', f );
iAxes(ax);
x = 0:0.1:pi;
y = sin(2*x);
h(1)= plot ( ax, x, -y, 'rx-' );
h(2)=plot ( ax, x, y, 'b-o' );
mdatatip(h);
legend ( 'datatip 1', 'datatip 2' )
%% Add a line which can be inspected & a add a datatip programmatically
% Programmatically add a datatip (note this can be on a line which was not
%  added at mdatatip creation.
clear
f = figure;
ax = axes ( 'parent', f );
iAxes(ax);
x = 0:0.1:pi;
y = sin(2*x);
h = plot ( ax, x, -y, 'bx-' );
hh= plot ( ax, x, y, 'rx-' );
m = mdatatip(h);
% add a tip programatiicaly -> the code will find the nearest point to the 
%   one provided in the object hh.
m.showDataTip(hh,1.20,0.7)

%% Add a tooltip of your own design with extra inputs and control the formatting
clear
f = figure;
ax = axes ( 'parent', f );
iAxes(ax);
x = 0:0.1:pi;
y = sin(2*x);
plot ( ax, x, -y, 'rx-' );
h=plot ( ax, x, y, 'b-o' );
abc = @(a,b,ref) sprintf ( 'Ref: %s\nIndex %i  (x,y)=%.2f,%.2f', ref, b.index, b.x, b.y );
reference = 'ABC';
mdatatip(h,abc, reference);
legend ( 'no datatip', 'datatip' )
