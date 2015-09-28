% muigetfile  read files -> customisation from read routine
%
%  This is the entry point to reading data where the user wants
%
%    1. Customisation of reading uidialog
%    2. Allow read routine author to dictate file filters
%    3. Allow progress bar updating
%
%    Returned data 100% controlled by read routine.
%
%   see also muiputfile, fastread
%
%    examples:
%
%    muigetfile ( @example_ReadRoutine_01, data )
%    muigetfile ( @example_ReadRoutine_02, data )
%
%  Author:    Robert Cumming
%  Copyright: Matpi Ltd.
%  $Id: muigetfile.m 215 2015-07-27 19:00:38Z Bob $
