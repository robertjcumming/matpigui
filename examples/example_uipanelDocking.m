% EXAMPLE_UIPANELDOCKING Simple example of undocking panels
%
%   A basic example of how to create a GUI with 4 panels which 
%     can be undocked in both traditional method and as a separate copy.
%
%   see also matpigui, example_uipanelDocking_02, example_uipanelDocking_03
%
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_uipanelDocking.m 215 2015-07-27 19:00:38Z Bob $
function example_uipanelDocking
  h = matpigui();
  h.addPage ( 'Primary' );
  names = { 'TopLeft', 'BottomLeft', 'TopRight', 'BottomRight' };
  h.split ( 'Primary', [2 2], names )
  uipanelDocking ( h, names, names, [0.95 0.95 0.05 0.05] )
end