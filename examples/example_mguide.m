% EXAMPLE_MGUIDE  - how to continue development with mguide
%
%   GUI development is a continual process - to facilitate this you can use
%   MGUIDE to do this.
%   
%   Create a gui in mguide and save it to an MAT file
%
%   
%   see also matpigui
%
% Copyright Robert Cumming, rcumming @ matpi.com
% website:  www.matpi.com
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_mguide.m 215 2015-07-27 19:00:38Z Bob $
function myApp = example_mguide ( )
  if exist ( 'My_Application.mat', 'file' ) == 2
    myApp = matpigui ( 'My_Application.mat' );
  else
    %% mguide
    msg{1} = 'Create a GUI and save as "My_Application.mat" - in the examples folder.';
    msg{2} = ' ';
    msg{3} = 'The next time you run this function it will automatically build your GUI from the MAT file';
    msg{4} = 'You can continue to develop your GUI in MGUIDE by:';
    msg{5} = '   mguide ( ''MY_Application.mat'' )';
    uiwait ( msgbox ( msg, 'MGUIDE instructions' ) );
    mguide
    return
  end
  % continue your development here.
  % The GUI object is myApp
end
