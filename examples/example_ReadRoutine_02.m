% example_ReadRoutine_02 ( filename, options, progresBarFcn )
%
%   This is a read routine with the option that the reading can be 
%    customised at run time - includes FASTREAD and progressbar 
%
%   These types of read routines are designed to be used with FASTREAD
%    where FASTREAD will ask the read routine what options are valid
%    for this read routine at runtime.
% 
%    FASTREAD will customise the uidialog according to these options.
%
%   The code includes persistent lastDir for making it easier to load
%    repeat file(s).
%
%   see also fastread, example_ReadRoutine_01
%
%    examples:
%
%    example_fileIO
%    muigetfile ( @example_ReadRoutine_01 )
%    muigetfile ( @example_ReadRoutine_02 )
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_ReadRoutine_02.m 215 2015-07-27 19:00:38Z Bob $
function [output, metaData] = example_ReadRoutine_02( filename, options, progressBarFcn )
  persistent lastDir                        % use a persistent variable to store the lastDir for this write routine method
  if isempty ( lastDir ); lastDir = pwd; end% init if empty
  if nargin == 0                            % uiputfile is requesting the runtime options
    [output, metaData] = GetOptions();      % get the default options and metaData
    output.lastDir = lastDir;               % populat the lastDir var
    return
  end
  output.filename = filename;               % A suggestion to store the filename in the output
  if nargin >= 2
    output.options = options;               % Store the runtime options
  else
    output.options = GetOptions;            % if not provided store the default options
  end
  %% Using fastread
  fRead = fastread ( filename, true );      % Initiate the fastread variable
  output.data = load ( fRead.filename );    % Load the data as normal
  
  if nargin == 3 % update the progressbar
    for ii=1:20
      progressBarFcn ( ii/20 );
      % immitate load process taking time
      pause(0.1);
    end
  end
  lastDir = fileparts ( filename );          % Store the lastDir persistent variable
end

function [options, metaData] = GetOptions ()
  options.openInEditor = true;                           % Flag to allow opening file in Matlab editor (only do this for txt files)
  options.userString = '';                               % A string passed into the write routine
  options.userNumber = 0;                                % A number passed into the write routine
  options.selection = { 'A' 'B' 'C' 'D' };               % User can select one of these items
  options.extension{1} = { 'Other Format' 'other'};      % File extension formats: "description" "extension"
  options.extension{2} = { 'Matlab BINARY File' 'mat'};  % Other file sextensions: "description" "extension"
  options.multipleFiles = false;                         % If true user can multi select files.
  
  % Meta data can be used to add other information to the uicontrols:
  metaData.openInEditor.ToolTip = sprintf ( 'Open selected file in editor\n Dont use on binary files' );
  metaData.userString.ToolTip = 'Input a string item';
  metaData.userNumber.ToolTip = 'Input a number';
  metaData.selection.ToolTip  = 'Select an item from the list';
  
  % overwrite is the final protected value which only works for saving
  % files, it true when saving it wont ask you to confirm overwrite.
  options.overwrite = true;        % If false -> then no overwrite check is asked (can be ddangerous...)
  options.incProgressBar = true;   % Include a progress bar in the uidialog.
end
