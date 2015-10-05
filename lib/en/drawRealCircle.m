% DRAWREALCIRCLE - draw a visual circle on an axes
%  
%  for axes where x and y are not equal you need to draw an
%   ellipse to make it look like a circle, this function does that.
%
%      [h, xCenter, yCenter] = DRAWREALCIRCLE ( ax, x, y )
%
%      where x & y are a 2x1 vectors contain 2 points
%      From these 2 points a radius is calculated for the
%      ellipse to be drawn.
%
%   For an axis equal axes - you can specify the center and a radius
%      h = DRAWREALCIRCLE ( ax, [x,y], radius )
%
%    The following defaults are set:
%         colour = 'k'
%         HitTest = 'off'
%
%      These can be overridden by proving them as arg pairs:
%
%    You can add arg pairs:
%      [h, xCenter, yCenter] = DRAWREALCIRCLE ( ax, x,  y,   argPairs )
%      [h, xCenter, yCenter] = DRAWREALCIRCLE ( ax, xy, rad, argPairs )
%
%       where arg pairs are any valid properties for a line
%
%
%    You can update a circle (for when the axes limits or position changes:
%
%      DRAWREALCIRCLE ( ax, h );
%
%      ax is the axes that the circle is plotted on
%      h  is an array of circle objects.
%
%
%  Examples:
%       f = figure;
%       ax = axes ( 'parent', f, 'XLimMode', 'manual', 'YLimMode', 'manual', 'nextplot', 'add' );
%       set ( ax, 'XLim', [0 100], 'YLim', [0 10] );
%       drawRealCircle ( ax, [5 10], [5 6] );
%
%   Add a to the figure position/size changing listener to update the image:
%     f = figure;
%     ax = axes ( 'parent', f, 'XLimMode', 'manual', 'YLimMode', 'manual', 'nextplot', 'add' );
%     set ( ax, 'XLim', [0 100], 'YLim', [0 10] );
%     h = drawRealCircle ( ax, [5 10], [5 6] );
%     addlistener ( f, 'SizeChanged', @(a,b)drawRealCircle ( ax, h ) )
%
%   Add a to the figure XLim/YLim changing listener to update the image:
%     f = figure;
%     ax = axes ( 'parent', f, 'XLimMode', 'manual', 'YLimMode', 'manual', 'nextplot', 'add' );
%     set ( ax, 'XLim', [0 100], 'YLim', [0 10] );
%     h = drawRealCircle ( ax, [5 10], [5 6], 'color', [1 0 0] );
%     addlistener ( f, 'SizeChanged', @(a,b)drawRealCircle ( ax, h ) );
%     addlistener ( ax, 'XLim', 'PostSet', @(a,b)drawRealCircle ( ax, h ) );
%     addlistener ( ax, 'YLim', 'PostSet', @(a,b)drawRealCircle ( ax, h ) );
%
%
%  see also drawRealSquare
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
% $Id: drawRealCircle.m 249 2015-10-05 09:55:34Z robertcumming $
