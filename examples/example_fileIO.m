% EXAMPLE_FILEIO - example use of fastread and fastsave functions
%
%    see also fastsave and fastread
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
% $Id: example_fileIO.m 215 2015-07-27 19:00:38Z Bob $
function example_fileIO
  
  hFig = dialog ( 'windowstyle', 'normal', 'Name', 'File IO with Customisable Options Example (www.matpi.com)' );
  p = get ( hFig, 'Position' );
  p(3) = 800;
  p(4) = 600;
  set ( hFig, 'Position', p );
  centerfig ( hFig );
  
  hMenu = uimenu ( 'Label', 'File', 'parent', hFig );
  readRoutines = readRoutineList;
  readMenu = uimenu ( hMenu, 'Label', 'Read' );
  for ii=1:length(readRoutines)
    uimenu ( readMenu, 'Label', readRoutines{ii}{1}, 'Callback', @(a,b)LoadData ( readRoutines{ii}{2} ) );    
  end
  saveRoutines = writeRoutineList;
  saveMenu = uimenu ( hMenu, 'Label', 'Save' );
  for ii=1:length(saveRoutines)
    uimenu ( saveMenu, 'Label', saveRoutines{ii}{1}, 'Callback', @(a,b)SaveData ( saveRoutines{ii}{2} ) );    
  end
  
  msg = sprintf ( 'This is a quick demo on the capabilities of MUIGETFILE, MUIPUTFILE, FASTSAVE and FASTREAD\n\n' );
  msg = sprintf ( '%sMUIGETFILE & MUIPUTFILE are methods which allow you to add customisation to the UILOAD and UISAVE dialogs\n\n', msg );
  msg = sprintf ( '%sIn this example the read and write routines can be customised (runtime options) and these options are available to the user when the select the file to load/save\n\n', msg );
  msg = sprintf ( '%sStep 01:  MENU-FILE-SAVE-WRITEROUTINE - "Input a filename to save some data to"\n', msg );
  msg = sprintf ( '%s       :  You will see in the commandline to runtime customisation options\n', msg );
  msg = sprintf ( '%sStep 02:  MENU-FILE-SAVE-SAVE(FSAVE+PROGRESS) - "Input a (network) filename to save some data to"\n', msg );
  msg = sprintf ( '%s       :  This uses the fast save capability and immitates the use of a progress bar\n', msg );
  msg = sprintf ( '%s\n', msg );
  msg = sprintf ( '%sNow load the data back again\n', msg );
  msg = sprintf ( '%sStep 03: MENU-FILE-READ-READROUTINE - "Select the file you saved earlier\n', msg );
  msg = sprintf ( '%s       : Again you will see the customisation options displayed at the commandline\n', msg );
  msg = sprintf ( '%sStep 04: MENU-FILE-READ-READ(FREAD+PROGRESSBAR) - "Select the network file from above\n', msg );
  msg = sprintf ( '%s       : As well as the options it will state the the network file has been copied locally\n', msg );
  msg = sprintf ( '%sStep 05: Repeat step 04 this time the file will not be copied\n', msg );
  msg = sprintf ( '%s\n', msg );
  
  uicontrol ( 'parent', hFig, 'style', 'text', 'string', msg, 'units', 'normalized', 'position', [0.05 0.05 .9 .9], 'horizontalalignment', 'left', 'fontname', 'monospaced' );
  
end
function LoadData ( funcHandle )
  data = muigetfile ( funcHandle );
  if isstruct ( data )
    disp ( 'finished loading - options selected were:' );
    disp ( data.options );
  end
end
function SaveData ( funcHandle )
  data = muiputfile ( funcHandle, rand(100,1) );
  if isstruct ( data )
    disp ( 'finished saving - options selected were:' );
    disp ( data.options );
  end
end

function output = readRoutineList
  output{1} = { 'Read Routine', @example_ReadRoutine_01 };
  output{2} = { 'Read Using FREAD+PROGRESSBAR', @example_ReadRoutine_02 };  
end
function output = writeRoutineList
  output{1} = { 'WriteRoutine', @example_WriteRoutine_01 };
  output{2} = { 'Save Using FSAVE+PROGRESSBAR', @example_WriteRoutine_02 };  
end