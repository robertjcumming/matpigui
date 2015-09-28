% EXAMPLE_UITREE_02  - A simple example how to build a tree from a file system
%
%  Creates a GUI which has a page containg a uitree of a dir structure
%    taken from the matpigui object and converted into a uitree.
%
%   Includes a callback to show how to extract the path of the selected item in the tree.
%
%  Note: each leaf is expanded at runtime - so you can put C:\ for example in
%        the root and it wont cause any performance issues.
%
%   see also matpigui, example_uitree_01
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_uitree_02.m 215 2015-07-27 19:00:38Z Bob $
function example_uitree_02
  
  % Create a new object
  hGui = matpigui();
  % Add a tab
  hGui.addPage ( 'treePage', 0.5 );
  % Build the tree
  hGui.addUITreeOfDirectory ( 'treePage', 'treeName', pwd, '.m', 'Position', [0 0 1 1] )
  
  % add a callback to run when a mouse press occurs
  hGui.addUITreeCallback ( 'treePage', 'treeName', 'MousePressedCallback', @(obj,event)MousePressedCallback ( obj, event, hGui) );  
  
end
function MousePressedCallback ( obj, event, hGui )
  clickX = event.getX;
  clickY = event.getY;
  mTree = event.getSource;
  treePath = mTree.getPathForLocation(clickX, clickY);
  if ~isempty ( treePath )
    mNode = treePath.getLastPathComponent;
    nodes = mNode.getPath;
    nodePath = '';
    for ii=2:length(nodes)
      name = char(nodes(ii).getName);
      name = html2str(name);
      nodePath = fullfile ( nodePath, name );
    end
    disp ( nodePath );
  end
end