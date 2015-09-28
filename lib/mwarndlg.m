% MWARNDLG - A warndlg which can be used interactively or automatically
%
%  In normal more it uses Matlabs provided warndlg
%
%  You can tell MWARNDLG what the next expected input will be:
%
%    MWARNDLG ( '', 'The warn Message', 'The Warn Title' )
%
%   The next time it is called it checks the internal state and adds 
%    variables to the warndlg UserData
%            UserData.flag  =   are the message and title as expected?
%            UserData.message = the actual dialog error message
%            UserData.title   = the actual dialog title (if provided)
%   This is used in the matpiguiTest class to check that the correct error
%     was thrown during testing for example.
%
%   In a test where multiple errors are expected the expected errors can be
%     stacked:
%        MWARNDLG ( '', 'The 1st error Message', 'The 1st Error Title' )
%        MWARNDLG ( '', 'The 2nd error Message', 'The 2nd Error Title' )
%
%
%   To reset any internal state call with no args:
%    MWARNDLG()
%
%   see also warndlg, merrordlg, muiwait
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: mwarndlg.m 216 2015-07-27 19:08:53Z Bob $
function varargout = mwarndlg ( varargin )
  persistent override overrideMessage overrideTitle 
  if nargin == 0 || isempty ( override ); override = 'normal'; overrideMessage = {}; overrideTitle = {};  end
  if nargin == 0; 
    return
  end
  
  switch override
    case 'override'
      if nargin == 3 && strcmp ( varargin{3}, 'modal' ) % override the modal input as in testing the code must be allowed to run...
        varargin{3} = 'normal';
      end
  end
  if isempty ( varargin{1} )
    overrideMessage{end+1} = varargin{2};
    if nargin == 3
      overrideTitle{end+1} = varargin{3};
    else
      overrideTitle{end+1} = '';
    end
    override = 'override';
%     if nargin == 4 && varargin{4}
%       permOverride = true;
%     end
    return
  end
  if nargin < 2; varargin{2} = ''; end
  if nargin < 3
    varargin{3} = 'non-modal';
  end
  
  h = warndlg ( varargin{:} );
  switch override
    case 'override'
      set ( h, 'Tag', 'matpiguiTest_MWarnDlg' );
      flag = false;
      if ~isempty( overrideMessage ) && ~isempty ( overrideTitle )
        flag(1) = strcmp ( varargin{1}, overrideMessage{1} );
        overrideMessage(1) = [];
        if nargin >= 2
          flag(2) = strcmp ( varargin{2}, overrideTitle{1} );
        end
        overrideTitle(1) = [];
      end
      userData.flag = all(flag);
      userData.message = varargin{1};
      if nargin >= 2
        userData.title = varargin{2};
      else
        userData.title = '';
      end
      set ( h, 'UserData', userData );
      if isempty ( overrideMessage ); override = 'normal'; end
  end
  if nargout == 1;
    varargout{1} = h;
  end
end
