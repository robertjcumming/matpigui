% example_ReadRoutine_01 ( filename, options )
%
%   This is a read routine with the option that the reading can be 
%    customised at run time.
%
%   These types of read routines are designed to be used with FASTREAD
%    where FASTREAD will ask the read routine what options are valid
%    for this read routine at runtime.
% 
%    FASTREAD will customise the uidialog according to these options.
%
%
%   see also fastread, example_ReadRoutine_02
%
%    examples:
%
%    example_fileIO
%    muigetfile ( @example_ReadRoutine_01 )
%    muigetfile ( @example_ReadRoutine_02 )
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_ReadRoutine_01.m 250 2015-10-05 19:57:02Z Bob $
function [output, metaData] = example_ReadRoutine_01( filename, options )
  persistent lastDir                         % see example_ReadRoutine_02 for detailed comments.
  % capture peopl running this example directly from command line with no input and output arguments
  if length(dbstack) == 1 && nargin == 0 && nargout == 0
    example_fileIO
    return
  end
  if isempty ( lastDir ); lastDir = pwd; end
  if nargin == 0
    [output, metaData] = GetOptions();
    output.lastDir = lastDir;
    return
  end
  if nargin == 1
    options = GetOptions();
  end    
  output.filename = filename;
  output.options = options;
  output.data = load ( filename );
  lastDir = fileparts ( filename );
end

function [options, metaData] = GetOptions ()
  options.openInEditor = true;
  options.userString = '';
  options.userNumber = 0;
  options.selection = { 'A' 'B' 'C' 'D' };
  options.extension{1} = { 'Other Format' 'other'};
  options.extension{2} = { 'Matlab BINARY File' 'mat'};
  
  metaData.openInEditor.ToolTip = sprintf ( 'Open selected file in editor\n Dont use on binary files' );
  metaData.userString.ToolTip = 'Input a string item';
  metaData.userNumber.ToolTip = 'Input a number';
  metaData.selection.ToolTip  = 'Select an item from the list';
  % overwrite is the final protected value which only works for saving
  % files, it true when saving it wont ask you to confirm overwrite.
  options.overwrite = true;
end
