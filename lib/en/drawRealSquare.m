% DRAWREALAQUARE - draw a visual square on an axes
%  
%  for axes where x and y are not equal you need to draw an
%   rectangle to make it look like a square, this function does that.
%
%      [h, xCenter, yCenter] = DRAWREALSQUARE ( ax, x, y )
%
%      where x & y are a 2x1 vectors contain 2 points
%      From these 2 points a distance is calculated for the
%      square to be drawn.
%
%    The square is a black circle with the hit test set to off.
%
%   example:
%
%       f = figure;
%       ax = axes ( 'parent', f, 'XLimMode', 'manual', 'YLimMode', 'manual', 'nextplot', 'add' );
%       set ( ax, 'XLim', [0 100], 'YLim', [0 10] );
%       drawRealSquare ( ax, [5 10], [5 6] );
%
%
%  see also drawRealCircle
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
% $Id: drawRealSquare.m 217 2015-07-27 19:10:38Z Bob $
