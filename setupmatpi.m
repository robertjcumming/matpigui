%  SETUPMATPI - set up the paths for the Matpi Toolbox
%
%  Adds the path to the example and the library.
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
function setupmatpi
  addpath ( fullfile ( pwd, 'examples' ) );
  addpath ( fullfile ( pwd, 'lib' ) );
  addpath ( fullfile ( pwd, 'testing' ) );
  disp ( ' ' );
  disp ( ' See examples in the "examples" folder' );
  disp ( '  See the help on them individually as they are a collection of scripts, functions and classes' );
  disp ( ' Documentation is built into the Matlab doc, e.g. doc matpigui  doc matpigui.addTab' );
  disp ( ' ' );
end