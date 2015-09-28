% example_WriteRoutine_02 ( filename, data, options, progressBarFcn )
%
%   This is a write routine with the option that the reading can be 
%    customised at run time.
%
%   These types of write routines are designed to be used with FASTSAVE
%    where FASTSAVE will ask the write routine what options are valid
%    for this read routine at runtime.
% 
%    FASTSAVE will customise the uidialog according to these options.
%
%   This example uses the progressbar capability and the FASTSAVE function
%    which is used to save the file locally first (faster) then move to a 
%    network location
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
%  $Id: example_WriteRoutine_02.m 215 2015-07-27 19:00:38Z Bob $
function [output, metaData] = example_WriteRoutine_02( filename, data, options, progressBarFcn )
  persistent lastDir                         % use a persistent variable to store the lastDir for this write routine method
  if isempty ( lastDir ); lastDir = pwd; end % init if empty
  if nargin == 0                             % uiputfile is requesting the runtime options
    if nargout == 0
      error ( 'example_WriteRoutine_02:Usage', 'See help for correct usage' );
    end
    [output, metaData] = GetOptions();       % get the default options and meta data.
    output.lastDir = lastDir;                % if lastdir is provided -> it is the starting point for file selection.
    return                                   % quit
  end
  if nargin < 3                              % if no options provided use the default ones
    options = GetOptions;                    
  end
  % provide an output if required, maybe store the filename and the runtime options?
  output.filename = filename;
  output.options = options;
  % create a fastsave variable
  fSave = fastsave ( filename );
  % save the file - you could use any method to save
  save ( fSave.filename, 'data' );
  % dummy saving and updating the progress bar
  if nargin == 4
    nData = length(data);
     for ii=1:nData
      progressBarFcn ( ii/nData );
      % immitate load process taking time
      pause(0.1);
     end
  end
  
  % REMEMBER to finalise the fastsave variable
  fSave.close;
  % update the persistent variable.
  lastDir = fileparts ( filename );
end
% The following function is where the default options and meta data is created:
function [options, metaData] = GetOptions ()
  
  options.userString = '';                              % produces an edit uicontrol which contains a string
  options.userNumber = 0;                               % produces an edit uicontrol which contains numeric data
  options.userFlag = true;                              % produces a checkbox uicontrol
  options.selection = { 'A' 'B' 'C' 'D' };              % produces a popupmenu uicontrol
  options.extension{1} = { 'Other Format' 'other'};     % provide the file filters to the uidialog
  options.extension{2} = { 'Matlab BINARY File' 'mat'}; % provide another file fileter to the uidialog
  
  % Add meta data 
  metaData.userString.ToolTip = 'Input a string item';  % tooltip
  metaData.userNumber.ToolTip = 'Input a number';       %  ""
  metaData.userFlag.ToolTip = 'Input a number';         %  ""
  metaData.userFlag.ForegroundColor = [1 0 0];          %  change another property
  metaData.selection.ToolTip  = 'Select an item from the list';
  
  % overwrite if true when saving it wont ask you to confirm overwrite.
  options.overwrite = false;                            % default is false
  options.incProgressBar = true;                        % include progress bar or not.
end


