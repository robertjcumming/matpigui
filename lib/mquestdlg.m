% MQUESTDLG - A questdlg which can be used interactively and automatically
%
%  Primary interactive use - see also questdlg
%
%  For automated use (testing)
%
%   MQUESTDLG ( 'override', autoAnswer );
%
%    Where autoAnswer is:
%           char:           A single question will be asked
%           cell of char:   Where N questions will be asked & auto answered
%
%   Note: In automatic mode - the answer is validated against the input 
%         options at runtime - if no match is found (its case sensitive)
%         then an error is thrown:
%
%    error ( 'matpi:mquestdlg:invalidOverride', ...
%       sprintf ( 'User attempted to override with incorrect answer "%s"', answer );
%
%  see also matpiwait matpilistdlg 
%           uiwait listdlg questdlg
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: mquestdlg.m 216 2015-07-27 19:08:53Z Bob $
function [answer] = mquestdlg ( varargin )
  persistent override overrideString 
  if isempty ( override ); override = 'normal'; overrideString = ''; end
  if nargin == 0; override = 'normal'; overrideString = ''; return; end
  if ischar ( varargin{1} ) 
    if strcmp ( varargin{1}, 'override' )
      override = 'override';
      if ~iscell ( varargin{2} ); varargin{2} = {varargin{2}}; end
      overrideString = varargin{2};
      return
    elseif strcmp ( varargin{1}, 'reset' )
      overrideString = '';
      return
    end
  end
  
  switch override
    case 'override'
      
      answer = overrideString{1};
      if isntValidAnswer ( answer, varargin{:} )
        disp ( varargin );
        error ( 'matpi:mquestdlg:invalidOverride', 'User attempted to override with incorrect answer "%s"', answer );
      end
      overrideString(1) = [];
      if isempty ( overrideString ); 
        overrideString = ''; 
        override = 'normal';
      end
      h = msgbox ( sprintf ( 'Quest Dlg - Override with Answer: "%s"', answer ) );
      pause ( 0.25 );
      delete ( h );
      return
    otherwise
      answer = questdlg ( varargin{:} );
  end
end
% this function is similar to the matlab questdlg input - use the same logic to extract out which items
%   are the button strings - so we can check that the override is valid option
%  This is tested upto R2014a.
function flag = isntValidAnswer ( override, Question,Title,Btn1,Btn2,Btn3,Default ) %#ok<INUSD,INUSL>
  nInput = nargin - 1;
  if nInput <= 3,
    Btn1 = 'Yes'; 
    Btn2 = 'No';
    Btn3 = 'Cancel';
  end
  if nInput == 4,
    Btn2 = [];
    Btn3 = [];
  end
  if nargin == 5
    Btn3 = [];
  end
  flag = ~any ( strcmp ( override, { Btn1, Btn2, Btn3 } ) );
end