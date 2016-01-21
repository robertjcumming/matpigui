%  MINPUTDLG - A heavily customisable inputdlg (interactive & auto)
%
%    Similar in structure to INPUTDLG but MUCH more customisable.
%
%    ANSWER = MINPUTDLG(PROMPT) creates modal dialog box that returns user
%    input for multiple prompts in the cell array ANSWER. PROMPT is a cell
%    array containing the PROMPT strings.  All data types returned are
%    strings.
%  
%    MINPUTDLG uses MUIWAIT to suspend execution until the user responds.
%  
%    ANSWER = MINPUTDLG(PROMPT,NAME) specifies the title for the dialog.
%  
%    To be consistent with the INPUTDLG the numlines can be provided as
%     an explicit input or as part of the OPTIONS struct:
%   
%    ANSWER = MINPUTDLG(PROMPT,NAME,NUMLINES) specifies the number of lines 
%    for each answer in NUMLINES. see NUMLINE below.
%
%    DEFAULTANSWER
%
%    ANSWER = MINPUTDLG(PROMPT,NAME,NUMLINES,DEFAULTANSWER) 
%  or
%    ANSWER = MINPUTDLG(PROMPT,NAME,DEFAULTANSWER) 
%
%    This specifies the default answer to display for each PROMPT. 
%    DEFAULTANSWER must contain  the same number of elements as PROMPT.
%    Unless TYPES is specified in the OPTIONS the variable class is used
%    to determine the question type:
%
%     TYPES
%             double  -> edit box which will return a double (str2double)
%             char    -> edit box which will return a string
%             boolean -> check box return true or false
%             cell    -> a popupmenu where the selected item is returned.*
%             struct  -> a popupmenu and dependent fields with multiple
%                          default values (see example below)
%
% * If cell array then the last item can be used to highlight what item 
%     should be selected as the default.
%
%  OPTIONS
% 
%   A struct which can contain the following parameters:
%
%   options.Resize      = ( 'on' )     | 'off'
%   options.WindowStyle = ( 'normal' ) | 'modal' ;
%   options.Interpreter = ( 'tex' )    | 'none' ;
%   options.numLines    = 1;           % see above
%   options.Types       = { ... }      % see below
%   options.Width       = 250                    % dialog width
%   options.Height      -> auto calc from input  % dialog height
%   options.heightFactor = 17;             % n pixels per question
%   options.OkayString   = 'Ok'        % string on Ok button
%   options.CancelString = 'Cancel'    % string on Cancel button
%   options.Parent       = handle      % Allow the minputdlg to be embedded
%   options.callingFig   = handle      % Force the inputdlg to be position over a calling fig
%
%    NUMLINES may be a constant value or a vector having one element per 
%    PROMPT that specifies how many lines per input field (only valid for
%    edit controls).
%  
%    TYPES
%    As detailed above with the following extra:
%
%          checkedit -> a checkbox and an edit box 
%                       edit string returned if checkbox selected
%                       otherwise empty returned
%                       If defaultanswer is a cell then the 1st value
%                       is expected to be a boolean to indicate if the
%                       checkbox is true/false and the 2nd value is the
%                       default value in the edit box.
%  
%          popedit ->   a popuipmenu and an edit box 
%                       edit string returned if checkbox selected
%                       otherwise empty returned
%                       If defaultanswer is a cell then the values 1:end-1 
%                       are input into pop.  The last value is 
%                       the value in the edit box.
%    Examples:
%  
%    prompt={'Enter a numeric value:','Enter the string value:' ...
%            'Enter a boolean value.','Select a popup value:' };
%    name='Input for input dialog';
%    numlines = 1;
%    defaultanswer={20,'hsv', true, { 'A' 'B' 'C' } };
%  
%    answer = MINPUTDLG(prompt,name,numlines,defaultanswer);
% % or
%    answer = MINPUTDLG(prompt,name,defaultanswer);
% 
% % Carry on from the above example:
%
%    prompt{5} = 'special type ex 1';
%    prompt{6} = 'special type ex 2';
%    prompt{7} = 'error message';       % you can add messages as well
%    defaultanswer{5} = false ;
%    defaultanswer{6} = 'default value';
%    defaultanswer{7} = [];   % provide something for error - no answer returned
% 
%    options.Types{5} = 'checkedit';
%    options.Types{6} = 'checkedit';
%    options.Types{7} = 'error+message'; 
%            Other types of messages are : 'warn+message' 'help+message'
%
%    answer = MINPUTDLG(prompt,name,numlines,defaultanswer,options);
%  
%    Use MINPUTDLG and a structure with multiple dependent children:
%
% %% Create a struct
%    for ii=1:3; 
%      myStruct.(sprintf('item%d',ii)) = struct ( 'number', rand(1), ...
%                                        'boolean',logical(mod(ii,2)), ...
%                                        'string', num2str(ii) ); 
%    end
%    [answer, ~, myStruct] = MINPUTDLG ( {'My Items'}, 'Title', {myStruct} );
%
%   Produces a struct where the user can select one of the items and modify
%     it if required before clicking on Ok.
%     All the items can be access from the 3rd output in this case
%
%     see also mlistdlg, mmsgbox, mwarndlg, merrordlg, 
%              muiwait, matpigui, inputdlg
%
%   For use in testing your GUI you can predetermine the results:
%        In this situation the next time it is called it will return
%        the values provided in predetermineResults.
%
%      MINPUTDLG ( [], predetermineResults );
%      MINPUTDLG() % resets any internal memory
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: minputdlg.m 263 2015-12-10 10:23:14Z robertcumming $

% TODO: types: checkpop, listbox, checkdouble (checkbox+double value)?
% TODO: embed inanother matpigui
function [output, dataBeforeCancel,arg3] = minputdlg ( varargin )
  persistent mode overrideOutput overrideBeforeCancel
  if isempty ( mode ); mode = 'normal'; overrideOutput = {}; overrideBeforeCancel = {}; end
  if nargin == 0; mode = 'normal'; overrideOutput = {}; overrideBeforeCancel = {}; return; end
  switch mode
    case 'override'
      output = overrideOutput{1};
      dataBeforeCancel = overrideBeforeCancel{1};
      overrideOutput(1) = [];
      overrideBeforeCancel(1) = [];
      % reset if required
      if isempty ( overrideOutput ); minputdlg(); end
      return
  end
  if isempty ( varargin{1} )
    overrideOutput{end+1} = varargin{2};
    if nargin == 3
      overrideBeforeCancel{end+1} = varargin{3};
    else
      overrideBeforeCancel{end+1} = '';
    end
    mode = 'override';
    return
  end
  
  % TODO allow for unit testing....
  questions = {};
  answers = [];
  dataBeforeCancel = [];
  numLines = 1;
  options.Resize = 'on';
  options.WindowStyle = 'normal';
  options.Interpreter = 'tex';
  title = 'minput dlg';
  if nargin >= 1;  questions = varargin{1}; end
  if nargin >= 2;  title     = varargin{2}; end
  if nargin >= 3;  
    if iscell ( varargin{3} ) % 3rd input is defaultanswers
      answers   = varargin{3};
      numLines = 1;
      if nargin > 4; error ( 'minputdlg:input:nArgIn', 'to many input arguments' ); end
    else
      numLines    = varargin{3}; 
      if nargin >= 4;  answers   = varargin{4}; end      
      if nargin > 5; error ( 'minputdlg:input:nArgIn', 'to many input arguments' ); end
    end
  end
  if ~iscell ( questions ); questions = { questions }; end
  if ~isempty ( answers ) && ~iscell ( answers ); answers = { answers }; end
  % process any input options
  if isstruct ( varargin{end} )    
    fnames = fieldnames ( varargin{end} );
    for ii=1:length(fnames)
      options.(fnames{ii}) = varargin{end}.(fnames{ii});
    end
  end
  % move the numLines property to the 
  if ~isfield ( options, 'numLines' ); options.numLines = numLines; end
  if ~isempty ( answers ) && length ( questions ) ~= length ( answers )
    error ( 'minputdlg:input', 'number of prompts and default answers must match' )
  end
  
  % Check for special case where a struct was provided
  dynamicCallback = false;
  if length ( answers ) == 1 && length ( questions ) == 1 && isstruct ( answers{1} )
    userStruct.data = answers{1};
    answers{1} = fieldnames(userStruct.data);
    subFields = fieldnames(userStruct.data.(answers{1}{1}));
    for ii=1:length(subFields)
      questions{end+1} = subFields{ii};
      answers{end+1} = userStruct.data.(answers{1}{1}).(subFields{ii});
    end
    userStruct.fields = subFields;
    dynamicCallback = true;
  end
  
  
  nQuest = length ( questions );
  if isempty ( answers )
    answers = cell(nQuest,1);
  end
  [types, pixels, options] = ExtractTypes ( nQuest, answers, options );
  if ~isfield ( options, 'heightFactor' );  options.heightFactor = 17; end
  if ~isfield ( options, 'Height' ); 
    options.Height = sum(pixels)+ options.heightFactor*nQuest + 75; 
  end
  if ~isfield ( options, 'Width' );        options.Width = 250; end
  if ~isfield ( options, 'OkayString' );   options.OkayString = 'Ok' ; end
  if ~isfield ( options, 'CancelString' ); options.CancelString = 'Cancel' ; end
  if ~isfield ( options, 'Parent' );       options.Parent = [] ; end
  if ~isfield ( options, 'callingFig' );   options.callingFig = [] ; end  
  
  % build the parent dialog - height comes from the number of pixels unless
  % provided.
  if isempty ( options.Parent )
    hFig = dialog ( 'WindowStyle', options.WindowStyle, 'position', [0 0 options.Width, options.Height], 'visible', 'off', 'name', title, 'resize', options.Resize );
  else
    hFig = options.Parent;
  end
  hObj = matpigui ( hFig, 'buttonHeight', 0 );
  hObj.addPage ( 'input' );
  % calculate where the top of the last ui control will be
  uiTop = 1-10/options.Height;
  for ii=1:nQuest
    uiTop = uiTop - ((16+pixels(ii))/options.Height); % 16 is 15 for title and 1 for offset.
    pos = [0.05 uiTop 0.9 pixels(ii)/options.Height];
    tPos = [0.05 pos(2)+pos(4)+1/options.Height 0.90 14/options.Height];
    switch types{ii}
      case { 'help+message' 'error+message' 'warn+message' }
        a = load('dialogicons.mat');
        switch types{ii}
          case 'help+message' % a message only - no user interaction
            IconData=a.helpIconData;
            a.helpIconMap(256,:)=get(hObj.hFig,'Color');
            iconMap = a.helpIconMap;
          case 'error+message' % a message only - no user interaction
            IconData=a.errorIconData;
            a.errorIconMap(256,:)=get(hObj.hFig,'Color');
            iconMap = a.errorIconMap;
          case 'warn+message' % a message only - no user interaction
            IconData=a.warnIconData;
            a.warnIconMap(256,:)=get(hObj.hFig,'Color');
            iconMap = a.warnIconMap;
        end        
        tPos = pos;
        tPos([1 3]) = [0.25 0.70];
        pos(3) = 0.15;
        aName1 = sprintf ( 'axes_%i', ii );
        aName2 = sprintf ( 'axes_%i', ii );
        hObj.addAxes ( 'input', aName1, 'Position', tPos, 'xtick', [], 'ytick', [], 'Visible', 'off' );
        text ( 0, 0.3, questions{ii}, 'parent', hObj.hUIC.input.(aName1) );
        hObj.addAxes ( 'input', aName2, 'position', pos, 'nextplot', 'replacechildren', 'xtick', [], 'ytick', [], 'yDir', 'reverse' );
        image(IconData,'Parent',hObj.hUIC.input.(aName2) );
        set(hObj.hFig, 'Colormap', iconMap)
        hObj.hUIC.input.(aName2).XLim = [1 50];
        hObj.hUIC.input.(aName2).YLim = [1 50];
        hObj.hUIC.input.(aName2).Visible = 'off';
        hObj.hUIC.input.(aName1).Visible = 'off';        
      case { 'str2double' 'str2num' } % edit box -> containing numbers
        hObj.addUIC ( 'input', num2str(ii), 'edit', 'String', num2str ( answers{ii} ), 'title', questions{ii}, 'Position', pos, 'uicTitlePosition', tPos, 'Max', options.numLines(ii));
      case 'String'     % edit box containing strings
        hObj.addUIC ( 'input', num2str(ii), 'edit', 'String', answers{ii}, 'title', questions{ii}, 'Position', pos, 'uicTitlePosition', tPos, 'Max', options.numLines(ii) );
      case 'Value'     % check box logical
        hObj.addUIC ( 'input', num2str(ii), 'checkbox', 'String', questions{ii}, 'Position', pos, 'Value', answers{ii} );
      case 'selectedString'     % popup menu containing strings
        value = 1;
        if length ( answers{ii} ) ~= length ( unique ( answers{ii} ) ) % assumption that the last item in the popup menu it the item to be selected from the list
          value = find ( strcmp ( answers{ii}(1:end-1), answers{ii}(end)) == 1 );
          answers{ii}(end) = [];
        end
        if dynamicCallback && ii == 1
          userStruct.types = types;          
          hObj.addUIC ( 'input', num2str(ii), 'popupmenu', 'String', answers{ii}, 'title', questions{ii}, 'Position', pos, 'uicTitlePosition', tPos, 'Max', options.numLines(ii), 'Callback', {@UpdateItems hObj userStruct}, 'Value', value );
        else
          hObj.addUIC ( 'input', num2str(ii), 'popupmenu', 'String', answers{ii}, 'title', questions{ii}, 'Position', pos, 'uicTitlePosition', tPos, 'Max', options.numLines(ii), 'Value', value );
        end
      case 'checkedit' % a checkbox next to a edit box.
        switch class ( answers{ii} )
          case 'boolean'
            value = answers{ii};
            str = '';
          case 'char'
            if isempty ( answers{ii} )
              str = '';
              value = false;
            else
              str = answers{ii};
              value = true;
            end
          case 'cell'
            value = false;
            if length ( answers{ii} ) == 2
              value = answers{ii}{1};
              str = answers{ii}{2};
            end
          otherwise
            value = false;
            str = '';
        end
        if value
          enableValue = 'on';
        else
          enableValue = 'off';
        end
          
        cName = sprintf ( 'B_%i', ii);
        eName = sprintf ( 'E_%i', ii);
        eTitle = sprintf ( 'uicTitle_%s', eName );
        hObj.addUIC ( 'input', cName, 'checkbox', 'String', '', 'Position', pos, 'Value', value, 'Callback', @(a,b)hObj.toggleUICEnable ( 'input', { eTitle eName } ) );
        pos = [0.15 uiTop 0.8 pixels(ii)/options.Height];
        hObj.addUIC ( 'input', eName, 'edit', 'String', str, 'title', questions{ii}, 'Position', pos, 'uicTitlePosition', tPos, 'enable', enableValue );
      case 'popedit' % a popupmenu next to a edit box.
        switch class ( answers{ii} )
          case 'cell'
            index = 1;
            if isnumeric ( answers{ii}{end} )
              value = answers{ii}(1:end-2);
              str = answers{ii}{end-1};
              index = answers{ii}{end};
            else
              value = answers{ii}(1:end-1);
              str = answers{ii}{end};
            end
          otherwise
            error ( 'minputdlg:popedit:defaults', 'popedit must be provided with the pop values and a default' );
        end
          
        cName = sprintf ( 'B_%i', ii);
        eName = sprintf ( 'E_%i', ii);
        pos = [0.05 uiTop 0.35 pixels(ii)/options.Height];
        hObj.addUIC ( 'input', cName, 'popupmenu', 'String', value, 'Position', pos, 'Value', index );
        pos = [0.40 uiTop 0.55 pixels(ii)/options.Height];
        hObj.addUIC ( 'input', eName, 'edit', 'String', str, 'title', questions{ii}, 'Position', pos, 'uicTitlePosition', tPos );
    end
  end
  % add the ok and cancel buttons
  pos = [0.05 15/options.Height 0.45 30/options.Height];
  hFig = ancestor ( hObj.hFig, 'figure' );
  hObj.addUIC ( 'input', 'minputdlg_Ok', 'pushbutton', 'string', options.OkayString, 'Position', pos, 'Callback', {@uiresume hFig} );
  pos = [0.50 15/options.Height 0.45 30/options.Height];
  
  hObj.addUIC ( 'input', 'minputdlg_Cancel', 'pushbutton', 'string', options.CancelString, 'Position', pos, 'Callback', @userCancel );
  % make the figure visible and centre screen.
  callingFig = ancestor(gcbo,'figure');
  if ~isempty ( options.callingFig )
    callingFig = options.callingFig;
  end
  if isempty ( options.Parent )
    if ~isempty ( callingFig )
      centerfig ( hObj.hFig, callingFig );
    else
      centerfig ( hObj.hFig );
    end
    hObj.hFig.Visible = 'on';
  end
  % wait for object to close
  muiwait ( ancestor ( hObj.hFig, 'figure' ) );
  
  % wait for dialog to close and then process and deliver the output.
  arg3 = [];
  if ishandle ( hObj.hFig )
    output = BuildOutput ( hObj, types, nQuest );
    dataBeforeCancel = output;
    if dynamicCallback
      %% for when a struct is passed in
      UpdateItems ( hObj, userStruct )
      fnames = fieldnames ( hObj.hUIC.input.F_1.UserData.userStruct.data );
      for ii=1:length(fnames)
        arg3.(fnames{ii}) = hObj.hUIC.input.F_1.UserData.userStruct.data.(fnames{ii}).value;
      end
    end
      
    hObj.close();
  else
    output = [];
  end  
  % embedded function to tell user what was selected before the Cancel button was pressed (not populated when X pressed.
  function userCancel(varargin)
    dataBeforeCancel = BuildOutput ( hObj, types, nQuest );
    hObj.close
    if ~isempty ( options.Parent )
      uiresume ( hFig );
    end
  end
end
function output = BuildOutput ( hObj, types, nQuest )
    output = cell(1, nQuest);
    for ii=1:nQuest
      switch types{ii}
        case 'help+message' % a message only - no user interaction
          output{ii} = [];
        case 'error+message' % a message only - no user interaction
          output{ii} = [];
        case 'warn+message' % a message only - no user interaction
          output{ii} = [];
        case 'popedit'
          cName = sprintf ( 'B_%i', ii);
          eName = sprintf ( 'E_%i', ii);
          output{ii}{1} = hObj.get ( 'input', cName, 'selectedString' );
          output{ii}{2} = hObj.get ( 'input', eName, 'String' );
        case 'checkedit'
          cName = sprintf ( 'B_%i', ii);
          eName = sprintf ( 'E_%i', ii);
          if hObj.get ( 'input', cName, 'Value' );
            output{ii} = hObj.get ( 'input', eName, 'String' );
          else
            output{ii} = [];
          end
        case 'logical'
          output{ii} = boolean(hObj.get ( 'input', num2str(ii), types{ii} ));
        otherwise
          if strcmp ( hObj.get ( 'input', num2str(ii), 'Style' ), 'checkbox' )
            output{ii} = logical(hObj.get ( 'input', num2str(ii), types{ii} ));
          else
            output{ii} = hObj.get ( 'input', num2str(ii), types{ii} );
          end
      end
    end
end
% extract out the types of variables and determine the type of input to be
% provided by the dialog.
function [types, pixels, options] = ExtractTypes ( nAnswers, answers, options )
  if length ( options.numLines ) == 1
    options.numLines = repmat ( options.numLines, 1, nAnswers );    
  end
  varTypes = cell(nAnswers,1);
  for ii=1:nAnswers
    if isempty ( answers{ii} )
      varTypes{ii} = 'char';
    else
      varTypes{ii} = class ( answers{ii} );
    end
  end
  if isfield ( options, 'Types' )  % over ride any types auto identified by 
    for ii=1:length ( options.Types ) % any input from the user.
      if ~isempty ( options.Types{ii} )
        varTypes{ii} = options.Types{ii};
      end
    end
  end
  pixels = zeros(nAnswers,1);
  types = cell(nAnswers,1);
  for ii=1:nAnswers
    if iscell ( varTypes{ii} ) % check for iCell
    end
    switch varTypes{ii}
      case 'warn+message'
        types{ii} = varTypes{ii};
        pixels(ii) = 50;
      case 'help+message'
        types{ii} = varTypes{ii};
        pixels(ii) = 50;
      case 'error+message'
        types{ii} = varTypes{ii};
        pixels(ii) = 50;
      case 'popedit'
        types{ii} = 'popedit';
        pixels(ii) = 30;
      case 'checkedit'
        types{ii} = 'checkedit';
        pixels(ii) = 30;
      case 'logical'
        types{ii} = 'Value';
        pixels(ii) = 30;
      case 'char'
        types{ii} = 'String';
        pixels(ii) = 15+13*options.numLines(ii);
      case 'double'
        if length ( answers ) > 1
          types{ii} = 'str2num';
        else
          types{ii} = 'str2double';
        end
        pixels(ii) = 15+13*options.numLines(ii);
      case 'cell'
        types{ii} = 'selectedString';
        pixels(ii) = 30;%15+13*options.numLines(ii);
      otherwise
        types{ii} = 'String';
        pixels(ii) = 15+13*options.numLines(ii);
    end
  end
end
function UpdateItems ( hObj, userStruct )
  popValue = hObj.get ( 'input', '1', 'selectedString' );
  if isempty ( hObj.hUIC.input.F_1.UserData ) % the last selection
    lastIndex = 1;
    
    hObj.hUIC.input.F_1.UserData.userStruct = userStruct;
  else
    lastIndex = hObj.hUIC.input.F_1.UserData.lastIndex;
    userStruct = hObj.hUIC.input.F_1.UserData.userStruct;
  end
  
  
  hObj.hUIC.input.F_1.UserData.lastIndex = popValue;
  for ii=2:length(userStruct.types)
    switch userStruct.types{ii}
      case 'Value'
        value = hObj.get ( 'input', num2str(ii), 'String' );
        hObj.set ( 'input', num2str(ii), 'Value', userStruct.data.(popValue).(userStruct.fields{ii-1}) );
      case 'String'
        value = hObj.get ( 'input', num2str(ii), 'String' );
        hObj.set ( 'input', num2str(ii), 'String', userStruct.data.(popValue).(userStruct.fields{ii-1}) );
      case 'str2double'
        value = hObj.get ( 'input', num2str(ii), 'str2double' );
        hObj.set ( 'input', num2str(ii), 'String', num2str(userStruct.data.(popValue).(userStruct.fields{ii-1})) );
      case 'selectedString'
        value = hObj.get ( 'input', num2str(ii), 'selectedString' );
        hObj.set ( 'input', num2str(ii), 'String', userStruct.data.(popValue).(userStruct.fields{ii-1}) );
    end
    str = hObj.get ( 'input', '1', 'String' );
    hObj.hUIC.input.F_1.UserData.userStruct.data.(str{lastIndex}).(userStruct.fields{ii-1}) = value;
  end
  hObj.hUIC.input.F_1.UserData.lastIndex = hObj.get ( 'input', '1', 'Value' );
end