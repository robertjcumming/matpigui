% FASTSAVE - method for speeding up the saving of network files
%
%  FASTSAVE is for PC Only
%
%   FASTSAVE will save a local file then move it to the network location
%
%    Syntax
%
%     fSave = fastsave ( filename )
%
%  Generates a object with a filename variable:
%
%     fSave.filename         
%
%  After the file is written then you need to close it using:
%
%    fSave.close();
%
%   Example:
%
%     data = rand(100,1);
%     nData = length(data);
%
%     fSave ( filename );
%     % here you can use your normal routines:
%
%          fid = fopen ( fSave.filename, 'w' ) % or
%          dlmwrite ( fSave.filename, ... );
%          save ( fSave.filename, .... );
%
%     After you have finished saving (if require use fclose ( fid )
%     you MUST use:
%
%       fSave.close
%     
%  see also muiputfile fastread
%
%
%  Author:    Robert Cumming
%  Copyright: Matpi Ltd.
%  $Id: fastsave.m 215 2015-07-27 19:00:38Z Bob $
classdef fastsave
  properties ( SetAccess = private )
    filename                                % The name of the target file to save
    version = '1.0.0.EE'
  end
  methods
    function obj = fastsave ( filename )
      % obj = fastsave ( filename )
      %
      % Create a fastsave object use it in the following way:
      %          fid = fopen ( fSave.filename, 'w' ) % or
      %          dlmwrite ( fSave.filename, ... );   % or
      %          save ( fSave.filename, .... );
    end
    function obj = close ( obj )
      % obj.close()
      %
      % Once you have finished with the object you should close it.
    end
  end
end
