% EXAMPLE_UITREE_01  - A simple example how to build a tree from a struct
%
%  Creates a GUI which has 2 pages both containing examples of structs
%    taken from the matpigui object and converted into a uitree.
%
%   This example creates a uitree from a structure and shows how 
%    to use 2 keywords to pass other information to a callback
%    This can be useful to react to users interacting with your GUI.
%
%
%   see also matpigui, example_uitree_02
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_uitree_01.m 215 2015-07-27 19:00:38Z Bob $
function example_uitree_01
  % Create a structure
  myStruct.fruit.apples = 1;
  myStruct.fruit.pears = 2;
  myStruct.fruit.grapes(1).uiTreeNodeName = 'UK Grapes'; % use this key name to give a name to the node
  myStruct.fruit.grapes(1).uiTreeNodeCode = 'extra var to pass to callback';% use this keyword to pass a var to the callback
  myStruct.fruit.grapes.red = 3;
  myStruct.fruit.grapes.green = 0;
  myStruct.fruit.grapes.black = 20;
  myStruct.fruit.grapes(2).uiTreeNodeName = 'EU Grapes';% use this key name to give a name to the node
  myStruct.fruit.grapes(2).uiTreeNodeCode = 'extra var to pass to callback';% use this keyword to pass a var to the callback
  myStruct.fruit.grapes(2).red = 30;
  myStruct.fruit.grapes(2).green = 100;
  myStruct.fruit.grapes(2).black = 123;
  
  % Create a new object
  hGui = matpigui();
  % Add a tab
  hGui.addTab ( 'uitreeTab', 0.5 );
  % Store the data in the GUI
  hGui.addData ( 'myStruct', myStruct );
  % Build the tree
  hGui.buildUITreeFromStruct ( 'uitreeTab', 'treeName', 'Stock', 'myStruct', 'position', [0 0 1 1] );
  % Expand the root automatically
  root = hGui.hTree.uitreeTab.treeName.mTree.getRoot;
  hGui.hTree.uitreeTab.treeName.mTree.expand(root);
  hGui.addUITreeCallback ( 'uitreeTab', 'treeName', 'MousePressedCallback', @(obj,event)MousePressedCallback ( obj, event, hGui) );  
  
  
  hGui.addTab ( 'anotherTab', 0.5 );
  % Store the data in the GUI
  hGui.buildUITreeFromStruct ( 'anotherTab', 'treeName', 'Fruit Only', 'myStruct.fruit', 'position', [0 0 1 1] );
  % Expand the root automatically
  root = hGui.hTree.anotherTab.treeName.mTree.getRoot;
  % expand the root.
  hGui.hTree.anotherTab.treeName.mTree.expand(root);
  
end
function MousePressedCallback ( obj, event, hGui )
  clickX = event.getX;
  clickY = event.getY;
  mTree = event.getSource;
  treePath = mTree.getPathForLocation(clickX, clickY);
  if ~isempty ( treePath )
    mNode = treePath.getLastPathComponent;
    userData = mNode.getUserObject;
    % Check for the extra items which were passed in.
    if length(userData) == 2 
      disp ( char(userData(2)) ) ;
    end
  end
end