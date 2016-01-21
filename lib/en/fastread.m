% FASTREAD - method for speeding up the reading of network files
%
%  FASTREAD is for PC Only
%
%   FASTREAD will make a copy of a network file locally for loading
%
%   The 1st time it loads a file it makes a copy locally and then 
%    the user loads this file.
%
%   Subsequent calls to load that file check for an update to the file.
%   If the file is the same then no copy is made and the user will load
%   the local file.
%
%    Syntax
%
%     fRead = fastread ( filename, verbose )
%
%     filename - file to be loaded/read
%     verbose  - optional flag to tell user a copy is being made (cmd line)
%
%   If the filecopy for any reason fails the fRead.filename variable
%   is the original filename -> therefore worse case scenario is that the 
%   original file will be loaded.
%
%  The copy flag checks for the file size and datestamp.  If either of them
%   are different then a new copy is made.
%
%  FASTREAD will not copy the file if the path starts with C:\ or D:\
% 
%   example:
%
%     fRead = fastread ( filename )
%
%   The user then uses this as follows:
%
%      load ( fRead.filename );
%
%   or 
% 
%      fid = fopen ( fRead.filename, 'r' )
%      data  = dlmread ( fRead.filename )
%
%  see also muigetfile fastsave
%
%  Note: The copied files are saved in:
%
%     tmpdir = fullfile ( tempdir, 'fastread' );
% 
%
%  Author:    Robert Cumming
%  Copyright: Matpi Ltd.
%  $Id: fastread.m 251 2015-10-16 12:51:44Z robertcumming $
classdef fastread
  properties ( SetAccess = private )
    sourceFilename                          % File provided by the user (i.e. the network file)
    localFilename                           % The local file where the copy has been made)
    localCopy = false                       % has a local copy been made?
    filename                                % The variable you should use in your subsequent calls
    version = '1.0.0.EN'
  end
  methods 
    function obj = fastread ( filename, verbose )
      % fRead = fastread ( filename, verbose )
    end
  end
end
