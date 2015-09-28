% example_PrintingEvent - example of capturing print events
%
%    This will show how to use the print start and finish events
%    
%    3 different methods of saving/printing are shown
%
%       1. copy to clipboard
%       2. Save a sub image (of a tab only - no tab headers)
%       3. The full GUI to file.
%
%  The event captured will add a date string to the saved image
% 
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_PrintingEvent.m 215 2015-07-27 19:00:38Z Bob $
function example_PrintingEvent
  h = matpigui ();
  h.addTab ( 'Tab 1' );
  h.addAxes ( 'Tab 1', 'myAxes' );
  
  addlistener ( h, 'matpiguiBeingPrinted', @yourPrintCallback);
  addlistener ( h, 'finishedPrinting', @yourPrintCallback);
  
  % copy whole to clipboard
  h.copyFigureToClipboard;
    
  % Save only page details to file
  %  in doing this it creates a copy of the page for printing 
  %   - you must use that differently in the callback (see below)
  h.saveSubImage ( 'Tab 1', 'tabOnly.png' );
  
  % The full GUI can be saved here
  h.saveAs ( 'fullGUI.png' );  
  
end
% an example print event function
function yourPrintCallback ( hObj, mEvent )
  % Switch is it a print start or print clean up event
  switch mEvent.EventName
    case 'matpiguiBeingPrinted'
      % Generate the string which will contain the current time.
      str = sprintf ( 'image captured @ %s', datestr(now) );
      % Is the image a sub copy?
      if mEvent.data.subCopy
        % In this instance it is a simple figure handle where you need
        %  to add uicontrols manually to the image
        uicontrol ( 'parent', mEvent.data.printHandle, 'style', 'text', ...
          'string', str, 'units', 'normalized', 'position', [0 0 1, 0.05] );
      else
        % In this instance you can add uicontrols manualy but its easier
        %   to add them using the matpigui methods
        hObj.addUIC ( hObj.activeName, 'printString', 'text', ...
          'string', str, 'units', 'normalized', 'position', [0 0 1, 0.05] );
      end
    case 'finishedPrinting'
      % when printing is finished you need to remove any items added.
      if mEvent.data.subCopy
        % This is handled internally -> you dont need to do anything
      else
        % Use the delete method to remove the items you added.
        hObj.deleteUIC ( hObj.activeName, 'printString' );
      end
  end
end