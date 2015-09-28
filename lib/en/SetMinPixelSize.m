% SetMinPixelSize  - fix one panel to a give size
%
%    SetMinPixelSize ( uipanel01, uipanel02, mode, size )
%
%      mode = 'left' or 'right'
%          uipanel01 - panel on the right hand side
%          uipanel02 - panel on the left hand side
%
%      mode = 'top' or 'bottom'
%          uipanel01 - panel on the bottom
%          uipanel02 - panel on the top
%
%    size - in pixels to fix one of the panels.
%
%
%   Examples:
%   ---------
%     % Fix a uipanel at the top
%     f = figure;
%     uiTop    = uipanel ( 'parent', f, 'Units', 'normalized', 'Position', [0.0 0.0 1 0.8] );
%     uiBottom = uipanel ( 'parent', f, 'Units', 'normalized', 'Position', [0.0 0.8 1 0.2] );
%     SetMinPixelSize ( uiBottom, uiTop, 'top', 25 );
%     %%
%     % Fix a uipanel at the bottom
%     f = figure;
%     uiTop    = uipanel ( 'parent', f, 'Units', 'normalized', 'Position', [0.0 0.0 1 0.8] );
%     uiBottom = uipanel ( 'parent', f, 'Units', 'normalized', 'Position', [0.0 0.8 1 0.2] );
%     SetMinPixelSize ( uiBottom, uiTop, 'bottom', 25 );
%     %%
%     % Fix a uipanel at the the left hand side
%     f = figure;
%     uiLeft  = uipanel ( 'parent', f, 'Units', 'normalized', 'Position', [0.0 0 0.8 1] );
%     uiRight = uipanel ( 'parent', f, 'Units', 'normalized', 'Position', [0.8 0 0.2 1] );
%     SetMinPixelSize ( uiRight, uiLeft, 'left', 125 );
%     %%
%     % Fix a uipanel at the the right hand side
%     f = figure;
%     uiLeft  = uipanel ( 'parent', f, 'Units', 'normalized', 'Position', [0.0 0 0.8 1] );
%     uiRight = uipanel ( 'parent', f, 'Units', 'normalized', 'Position', [0.8 0 0.2 1] );
%     SetMinPixelSize ( uiRight, uiLeft, 'right', 125 );
%
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: SetMinPixelSize.m 216 2015-07-27 19:08:53Z Bob $
