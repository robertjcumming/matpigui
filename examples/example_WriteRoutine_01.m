% example_WriteRoutine_01 ( filename, data, options, progressBarFcn )
%
%   This is a write routine with the option that the reading can be 
%    customised at run time.
%
%   These types of write routines are designed to be used with CUIPUTFILE
%    where CUIPUTFILE will ask the write routine what options are valid
%    for this read routine at runtime.
% 
%    CUIPUTFILE will customise the uidialog according to these options.
%
%   see also example_fileIO, fastsave
%
%    examples:
%
%    example_fileIO
%    muiputfile ( @example_WriteRoutine_01, rand(10) )
%    muiputfile ( @example_WriteRoutine_02, rand(10) )
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_WriteRoutine_01.m 215 2015-07-27 19:00:38Z Bob $
function [output, metaData] = example_WriteRoutine_01( filename, data, options )
  persistent lastDir                            % see example_WriteRoutine_02 for detailed comments.
  if isempty ( lastDir ); lastDir = pwd; end
  if nargin == 0
    if nargout == 0
      error ( 'example_WriteRoutine_01:Usage', 'See help for correct usage' );
    end
    [output, metaData] = GetOptions();
    output.lastDir = lastDir;
    return
  end
  output.filename = filename;
  output.options = options;
  save ( filename, 'data' )
  lastDir = fileparts ( filename );
end

function [options, metaData] = GetOptions ()
  options.userString = '';
  options.userNumber = 0;
  options.selection = { 'A' 'B' 'C' 'D' };
  options.extension{1} = { 'Other Format' 'other'};
  options.extension{2} = { 'Matlab BINARY File' 'mat'};
  
  metaData.userString.ToolTip = 'Input a string item';
  metaData.userNumber.ToolTip = 'Input a number';
  metaData.selection.ToolTip  = 'Select an item from the list';
end
