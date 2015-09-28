% CPROGRESS - a circular progress bar (with 2 circular progress notifications)
%
%    Similar to waitbar but has 2 circular 
%
%   Initialise
%   ----------
%     h = CPROGRESS ( initValue, userText, optArg, argValue );
%
%      initValue  - the initial value (normally 0);
%                 - or 'busy' -> this indicates a unknown process length
%      updateText - update the user controlled text string.
%      optArg     - see valid options below
%      argValue      - the value
%
%      % Valid optArgs to cusomise the GUI:
%         options.innerBar   = false;         % inc inner bar true | false
%         options.outerColor = [0 1 0];       % outer bar colour
%         options.innerColor = [0 0.8 0];     % inner bar colour
%         options.edgeColor  = [0.7 0.7 0.7]; % edge colour
%         options.fade       = true;          % fade older bars true | false
%         options.forceFocus = false;         % force focus of ui on each call
%         options.parent     = [];            % embed in a user GUI component
%     Normal mode only
%         options.estTime    = false;         % include an time estimate
%     Busy mode only:
%         options.timer      = true;          % use with busy mode only
%         options.dTime      = 0.1;           % time between timer calls
%
%        To extract the most upto date list of options:
%         options = CPROGRESS;
%
%
%   Update at runtime:
%   ------------------
%      CPROGRESS ( value, h );
%      CPROGRESS ( value, h, updateText );
%
%      value      - value in percent that bar should be displayed
%      updateText - update the user controlled text string.
%
%    When using a double progress bar:
%
%      CPROGRESS ( [outerValue innerValue], h );
%
%      outerValue - value in percent that outer bar should be displayed
%      innerValue - value in percent that inner bar should be displayed
%                 - only valid if bar initialised at start by using
%                   the "innerBar" optArg pair (see example)
%
%   Run internal demo:
%   ------------------
%    cProgress ( 'demo' );
%    cProgress ( 'embedDemo' );
%    cProgress ( 'busyDemo' );
%    cProgress ( 'busyTimer' );
%
%   Stand alone example:
%   --------
%   Create the dialog specifying that the inner bar is included:
%   h = cProgress (0, 'Running Demo...', 'innerBar', true );
%    
%   Update the bars [outer inner]
%   cProgress ( [25 40], h )
%
%   Busy Example:
%   -------------
%   h = cProgress ('busy', 'Close to quit' );
%   while ( true )
%     % Your code goes here
%     cProgress ( 'busy', h );
%     % Some condition goes here
%     %  to break the while
%     %
%     if ~ishandle ( h ); break ;end
%     pause ( 0.025 );
%   end
%
%   Embed Example:
%   --------------
%    f = figure; 
%    uip = uipanel ( 'parent', f, 'position', [0.2 0.2 0.4 0.4] );
%    h = cProgress ( 0, 'Embedded', 'parent', uip )
%    for i=1:100
%      % Your code goes here...
%      cProgress ( i, h )
%    end
%    % Clean up the uipanel when its finished
%    delete ( h );
%
%   Notes:
%   ------
%
%   1. If the dialog is closed before your calling loop is finished it 
%      will continue to run (but not display)
%   2. Dont make to many calls to this function -> it can slow down
%      the over all progess of your code.
%   3. You can embed the progress bar into your own GUI by creating
%      a new panel for the bar to be drawn on.
%   4. For a busy progress bar -> the user must indicate when it is to 
%      be updated - you can initiate this via a timer if you desire
%
%
%  see also waitbar
%
% $Id: cProgress.m 227 2015-09-04 13:39:45Z Bob $
