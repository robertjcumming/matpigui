% MLISTDLG - A list dialog which can be used interactively or automatically
%
%  In normal more it uses Matlabs provided LISTDLG
%
%  You can override the results from mlistdlg as follows:
%
%    MLISTDLG ( 'override', 5, 1 )
%
%  the next time the MLISTDLG is called it will not show the listdlg but
%   will instead return seletion = 5 and value = 1.
%
%  preselections can be stacked on top of each other:
%
%    MLISTDLG ( 'override', [], 0 )
%    MLISTDLG ( 'override', 5, 1 )
%
%    In this case the next 2 calls to MLISTDLG will be overruled.
%
%  Note: No checks are performed that the selection is valid:
%       It does not check the length of selection against the selectionMode
%       It does not check that selection is within the provided list.
%       It does not check that selection is empty when flag is false
%       In short it relies on your useage.
%
%  You can get info on the current stored overrides:
%
%    MLISTDLG ( 'info' );
%
%    MLISTDLG(); % resets the internal state.
%
%  see also listdlg mmsgbox minputdlg mquestdlg mwarndlg merrordlg
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: mlistdlg.m 216 2015-07-27 19:08:53Z Bob $
function [selection, flag] = mlistdlg ( varargin )
  persistent override overrideSelection overrideFlag
  if isempty ( override ); override = 'normal'; overrideSelection = ''; overrideFlag = []; end
  if nargin == 0; override = 'normal'; overrideSelection = ''; overrideFlag = []; return; end
  if ischar ( varargin{1} ) 
    if strcmp ( varargin{1}, 'override' )
      if nargin == 3
        override = 'override';
        if isempty ( overrideSelection )
          overrideSelection{1} = varargin{2};
          overrideFlag{1} = varargin{3};
        else
          overrideSelection{end+1} = varargin{2};
          overrideFlag{end+1} = varargin{3};
        end
      else
        error ( 'mlistdlg:override:invalidinput', 'in override mode only 3 inputs can be passed in' );
      end
      return
    elseif strcmp ( varargin{1}, 'info' )
      nOverride = length ( overrideSelection );
      fprintf ( '  No of override = %d\n', nOverride );
      for ii=1:nOverride
        fprintf ( 'Value = %d      Selection = [ ', overrideFlag{ii} );
        for jj=1:length ( overrideSelection{ii} );
          fprintf ( '%d ', overrideSelection{ii}(jj) );
        end
        fprintf ( ']\n' );
      end
      return
    end
  end
  
  switch override
    case 'override'
      selection = overrideSelection{1};
      flag = overrideFlag{1};
      overrideSelection(1) = [];
      overrideFlag(1) = [];
      if isempty ( overrideFlag )
        override = 'normal';
      end
      return
    otherwise
      [selection, flag] = listdlg ( varargin{:} );
  end
end