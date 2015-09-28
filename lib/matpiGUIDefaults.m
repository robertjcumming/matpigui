%  MATPIGUIDEFAULTS - change some defaults
%
% matpiGUIDefaults ( 'selectedColor', [1 0 0] );
% matpiGUIDefaults ( 'reset' );
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: matpiGUIDefaults.m 216 2015-07-27 19:08:53Z Bob $
function output = matpiGUIDefaults ( varargin )
  persistent defaults
  if isempty ( defaults ) || nargin == 1 && strcmp ( varargin{1}, 'reset' )
    defaults = struct;
    defaults.titleColour = 'cyan';
    defaults.titleTextColour = 'black';
    defaults.tabWidth = 0.1;
    defaults.uicBackgroundColor = 'white';
    defaults.uicTitlePosition = 'left';
    defaults.uicUnits = 'normalized';
    defaults.uicFontSize = get (0,'DefaultUIControlFontSize');%
    defaults.uicFontWeight = get (0,'DefaultUIControlFontWeight');%
    defaults.unitTestHighlightBackground = [0 0 1];
    defaults.unitTestHighlightForeground = [1 1 1];
    % shortcut keys
    defaults.keys.copy = 'c';
%     defaults.keys.toggleCopyUI = 'u';
  end
  if nargin > 1
    for ii=1:2:nargin
      defaults.(varargin{ii}) = varargin{ii+1};
    end
  end
  
  output = defaults;
end