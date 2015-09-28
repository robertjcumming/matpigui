% MUIWAIT - A uiwait which can be used interactively or automatically
%
%     muiwait ( 'override' ) % overrides the next call to uiwait
%                              % same as uiresume being called
%     muiwait ( 'kill' )    % overrides the next call to uiwait
%                              % same as dialog being deleted.
%     muiwait ( 'reset' )    % resets any unused uiwait.
%
%  Example usage:
%     muiwait ( 'override' ) 
%     muiwait ( hFig ) - no wait is done in this instance
%                        used for testing of gui.
%
%  see also listdlg
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: muiwait.m 216 2015-07-27 19:08:53Z Bob $
function muiwait ( varargin )
  persistent block mode nBlock
  if isempty ( block )
    block = false;
    mode = 'none';
  end
  if nargin >= 1 && ischar ( varargin{1} )
    switch varargin{1}
      case 'kill'
        block = true;
        mode = 'delete';
      case 'override'
        block = true;
        mode = 'uiresume';
      case 'reset'
        block = false;
        mode = 'none';
      otherwise
        error ( 'matpi:muiwait:inputerror', 'error on input by user "%s"', varargin{1} );
    end
    nBlock = 1;
    if nargin == 2
      nBlock = varargin{2};
    end
    return
  end
  if block == false
    uiwait ( varargin{:} );
  else
    pause(0.25);
    switch mode
      case { 'none' 'uiresume' }
      case 'delete'
        delete ( varargin{1} );
    end      
    nBlock = nBlock - 1;
    if nBlock <= 0
      block = false;
      mode = 'none';
    end
  end
end