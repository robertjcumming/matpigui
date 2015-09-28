% muiputfile  write files -> customisation from write routine
%
%  This is the entry point to writing data where the user wants
%
%    1. Customisation of writing via uidialog
%    2. Allow write routine author to dictate file filters
%    3. Allow progress bar updating
%
%    Writing of data 100% controlled by write routine.
%
%   see also muigetfile
%
%    examples:
%
%    muiputfile ( @example_WriteRoutine_01, data )
%    muiputfile ( @example_WriteRoutine_02, data )
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
