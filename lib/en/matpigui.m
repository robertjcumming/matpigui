%  MATPIGUI - GUI framework class for creating and managing GUI.
%
%  A GUI class to build your GUI in an easy and efficent way
%   
%   Designed around pages/tabs/uipanels which are identified by names,
%    The user then adds uicontrols (which have names) to each individual
%    page/tab/panels
%
%   All future access to/from the uicontrols is done via the name of the 
%    page/tab/panel and the uicontrol
%
%   Many other capabilities exist:
%
%    Java uicontrols
%    uitree
%    dynamic panels
%    toolbar
%    docking/undocking of uipanels
%    GUI builds uicontrols associated with runtime settings structure.
%
%
%  Examples:
%    
%      see all the examples in the examples folder which build GUI using
%        this framework from scratch
%
%      You can create a new GUI from guide which you can save to a MAT file
%        You can run that mat file by the following:
%
%      matpigui ( 'example_Application.mat' )
%
%
%
%    Pre R2014b you can use the colourmap feature to have multiple colourmaps in a single GUI
%       since R2014b Matlab introduced this feature directly.
%    
%  
%  see also mguide, iAxes, dynamicPanel
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
% $Id: matpigui.m 248 2015-10-05 09:03:19Z robertcumming $
classdef matpigui < handle % hgsetget & handle
  properties % public
%     name
    iAxes = struct;          % handle to all iAxes objects,                                    e.g. hGui.iAxes.page.axesName
    hUIC = struct;           % handle to all UI controls and axes properties - read and write. e.g. hGui.hUIC.page.uicName
    hTree = struct;          % handle to any uitrees   
    hRte  = struct           % handle to any rich text editors
    childGroup = struct;     % sub field to childGroup UI groups,                              e.g. hGui.childGroup.uigroupName
    userSettings = struct;   % user settings which are transformed into uicontrols at runtime.
    gui2pdf                  % place holder for a gui2pdf object
    data = [];               % any user data stored within the uigroup
    appData = [];            % place to store application data.
  end
  
  properties (GetAccess=public, SetAccess=protected)
    hTab = cell(0);        % this is required for child to access other tabs to e.g. for mouse down on splits with multiple uigroups - Access is opened for internal development and management - use with caution.
    name = 'TabMain';      % the name of the matpigui tab group
    activeName             % the name of the active tab/page for this tabgroup
    hFig                   % the handle to the primary figure
    Position = [0 0 1 1];  % the default position for a new matpi tabgroup
    isTabGroup = true      % does it contain a tab group or a page group
    allNames = {};         % all names of tabs/pages and uipanels
    hNames = {};           % these are the names of tabs and pages
    panelNames = {};       % names of uipanels and splits.
    parent = struct        % a struct containing parent information (tab and uigroup)
    dPanel = struct        % pointer to the dynamicPanel class objects
  end
  
  
  properties ( Constant = true )
    sourceChangeEventName  = 'sourceChanged'; % This IS the EVENT name when a var changes
                                              % e.g.
                                              %    userEvent = hGui.sourceChangeEventName;
                                              %    addlistener ( hGui, userEvent, @Callback )
    updateMethod           = 'addData';       % The class update data function.
                                              %  e.g.
                                              %    hGui.(hGui.updateMethod) ( var, data )
                                              %    this is the same as:
                                              %    hGui.addData( var, data )    
  end
  events
    sourceChanged          % The actual event - see sourceChangeEventName
                           %    Event contains information on which variable has changed and the new data
    tabChanged             % Page/Tab changed.
                           %    Event contains information on the new tab/page name.
    matpiguiBeingPrinted   % About to print or saveas (includes filename of data being printed)
    finishedPrinting       % Just finished printing/saving
    undock                 % A uipanel is being undocked
                           %    Event contains new figure and newly created panel name(s)
    dock                   % A uipanel is being docked
                           %    Event contains docked panel name(s)
    tabDelete              % Event notification for when a tab is deleted.
  end
  
  % Public Methods
  %   some methods have to be public to allow for the embedded child tab groups - this is not ideal.
  methods  % public Constructor & License 
    function obj = matpigui ( varargin )
      %   The primary constructor to create a matpigui object.
      %   matpigui            % no args works
      %   matpigui ( figure ) % pass in figure handle. 
      %   matpigui ( hFig, varargin ) % pass in figure handle. 
      %   matpigui ( hFig, 'pages' )  % Create a uigroup with pages instead of tabs
      %  
      %   varargin:
      %    buttonHeight,    0.1       % normalised height of tab buttons
      %    position    , [x y w h]    % normalised size of uigroup - [0 0 1 1];
      %
      %  Examples: Pages can be createad:
      %   obj = matpigui ( hFig, 'pages' );
      %   obj = matpigui ( hFig, 'buttonHeight', 0.05 );
      %
      %  A struct (or mat file) can be passed in (save a struct from mguide to see struct constuction:
      %
      %  obj = matpigui ( mstruct );
      %  obj = matpigui ( 'My_Application.mat' );
      %
    end
    function output = LicenseInfo ( obj, parentPanel )
      % output the license info to a var or load into a uipanel.
      % output = obj.LicenseInfo()
      % obj.licenseInfo ( hPanel )
      %
      % return the license info - or display in a GUI
      % 
      % Example
      %   h = matpigui(); % Create a object
      %   h.addTab ( 'Tab 1' ); % Create a tab
      %   h.addTab ( 'About' ); % Create an about tab
      %   Get the handle to the panel
      %   hPanel = h.getTabHandle ( 'About' );
      %   h.LicenseInfo (hPanel);
      %
      % see also: example_About which contains other examples of how to display the license info in an about panel/gui.      
    end
    function output = remainingDays ( obj )
      % Demo only - Return the number of days remaining in the demo
      % output = obj.remainingDays
      %
    end
  end
  methods  % public
    function obj = addAxes ( obj, parentName, newName, varargin )
      % Add an axes to a tab/page/uipanel.
      % obj.addAxes ( 'parentName', 'axesName', varargin )
      %
      % Note 1: units are by default normalized.
      % Note 2: nextplot property is by default set to "add"
      %       : - this is different to matlab default.
      % Note 3: An additional property pair "iAxes" will add an axes with the iAxes methods.
      %
      % obj.addAxes ( parentName, axesName, position, [.1 .1 .8 .8], 'iAxes', true )
    end
    function obj = addCallback ( obj, tabName, callback )
      % Add a callback to run when a tab/page becomes active.
      % obj.addCallback ( 'name', callback );
      %
      %  This is a callback to a page/tab to run when becoming active
      %
      %  see also event tabChanged
      %
      % Note: They cannot be added to a uisplit/uipanel to run when it becomes active.
    end
    function obj = addColorBar ( obj, varargin )
      % add a color bar to an axes
      % two method to call:
      %   obj.addColorBar ( 'page', 'axesName', varargin )
      %   obj.addColorBar ( axH, varargin )
      %
      %  varargin is:
      %     position    currently supports 'right' only
      %     colorbars   the color bar index in the gui, integer
      %     userLimits  define the ylimits e.g. [0 1]
      % 
    end
    function obj = addColorMap ( obj, map )
      % add a colourmap to the ancesteral figure
      % obj.addColorMap ( map )
      %
      % Note: R2014b introduced capability to reduce the requirement for this feature.
    end
    function obj = addData ( obj, name, variable )
      % add user data to the matpi uigroup.   
      % obj.addData ( name, variable );
      % obj.addData ( 'struct.field', variable )
      % obj.addData ( 'struct.field.anyNumber.fields.value', variable )
      %
      % see also the event notification when data changes.
    end
    function obj = addDynamicPanel ( obj, varargin )
      % Add a dynamic panel to a tab/page/uipanel.
      % obj.addDynamicPanel ( parentName, dynPanelWidth, location, varargin )
      %
      % parentName - name of the parent Tab, Page or uipanel (can be splitpanel)
      % width      - normalised width of the dynamic panel to be added
      % location   - location of dynamic panel - 'right', 'left', 'top', 'bottom'
      % varargin   - arg pairs which are valid for a uipanel      
    end
    function obj = addFrame ( obj )
      % Undocumented - not active.
    end
    function obj = addGui2PDF ( obj, varargin )
      % Create a gui2pdf object
      % obj.Gui2PDF ( varargin )
      %
      %       varargin - valid input arguments to gui2pdf (see help)
    end
    function obj = addManyUIC ( obj, parent, pos, names, types, varargin )
      %  Add many UIC stacked vertically.
      % obj.addManyUIC ( 'parentName', position, names, types, varargin )
      %
      %
      % parentName - name of the parent to add the UIC to.
      % position   - start position of the 1st uicontrol.
      %            - the 4th position indicates height and
      %            - sign indicates the direction for any further uic to be added.
      % names      - cell array containing names of the uic to be added.
      % types      - cell array containing types of the uic to be added.
      % varargin   - cell array containing any extra arg pairs to be added,
      %            - must be cell array.
      %            - the arg pairs can be empty - to skip certain UIC.
    end
    function obj = addMultipleUIS ( obj, tabName, startPos, nameOfUI, typeOfUI, varargin )
      % Deprecated: Use addManyUIC instead
    end
    function obj = addPage ( obj, varargin )
      % Add a page to a uigroup.
      % obj.addPage ( 'pageName', varargin )
      %
      %  Add a page to the uigroup
      %    varargin is valid arg pairs:
      %      'callback', callbackFcn
      %      'incCloseButton', true | ( false )
      %      'titleBar', true | ( false )
      %      'titleHelp', callbackFcn
      %      'titleBarName', 'string to be placed in title bar' | ( '' )
      %      'protected', true | ( false )
      %      'enable', ( 'on' ) | 'off'
    end
    function obj = addRTE ( obj, parentName, rteName, string, varargin )
      % Add a rich text editor to your GUI
      % obj.addRTE ( parentName, rteName, string, varargin );
      %
      % parentName: Name of the page/tab/uipanel where the RTE located
      % rteName   : Name to associate with the rich text editor
      % string    : Initial string in the rich text editor
      % varargin  : valid arg pairs
      %   special : 'textFormat', 'matlab'
    end
    function obj = addSettingsUI ( obj, varargin )
      % Add runtime settings -> this is a struct which the framework will convert into UICONTROLS.
      % obj.addSettingsUI ( 'Settings', settings, 'Callback', fcnCallback, 'ignore', ignore );
      % obj.addSettingsUI ( 'Defaults', defaults, 'Settings', settings, 'Callback', fcnCallback, 'ignore', ignore ); 
      %
      % settings - is a struct containing default settings -> matpigui extracts the setting type based on variable type
      % callback   is a function to call when any setting is changed
      % ignore     is a cell array of paths in the settings to ignore when generating the settings GUI
    end
    function obj = addTab ( obj, varargin )
      % Add a tab to a uigroup
      % obj.addTab ( 'tabName', varargin )
      % obj.addTab ( 'tabName', width, varargin )
      %
      %   tabName: name of tab to be added 
      %   width: normalized width of tab
      %
      %  Add a tab to the uigroup
      %   varargin is valid arg pairs:
      %     'callback', callbackFcn
      %     'incCloseButton', true | ( false )
      %     'titleBar', true | ( false )
      %     'titleHelp', callbackFcn
      %     'titleBarName', 'string to be placed in title bar' | ( '' )
      %     'protected', true | ( false )
      %     'enable', ( 'on' ) | 'off'
    end
    function obj = addToolbar ( obj, varargin )
      % Create a toolbar in the GUI
      %     obj.addToolbar ( mode )
      % 
      %     mode: 'init' (adds all items below)
      %           'pages'         Adds a combo box to the toolbar containing all pages
      %           'tabs'          As above but tabs
      %           'saveImage'     Adds a icon to save the figure to file
      %           'CopyClipboard' Copies the image to the clipboard (PC only)
      %           'help'          Adds a help toolbar which is linked to the active tab/page help.      
      %
      % 
    end
    function obj = addUIC ( obj, parent, name, style, varargin )
      % Add a uicontrol to a page/tab/uipanel
      % obj.addUIC ( 'parentName', 'uicName', 'style', varargin )
      %
      %   parentName - name of page/tab/uipanel/splitPanel to add the uicontrol to.
      %   uicName    - name of the UIC to be added (see also get/set)
      %   style      - the uicontrol style:
      %                                     checkbox
      %                                     edit
      %                                     listbox - or list
      %                                     popupmenu - or pop
      %                                     protectededit
      %                                     pushbutton - or btn, pb
      %                                     radiobutton
      %                                     slider
      %                                     text
      %                                     togglebutton
      %                                     uibuttongroup
      %                                     uipanel
      %                                     uitable
      %
      %   varargin - valid arg pairs for the uicontrol requested, See matlab help for valid inputs.
      %
      % Note 1: units are expected to be normalized
      % Note 2: The following arg pairs:
      %         title : 'string'
      %         uicTitlePosition : { ( 'left' ), 'right', 'above', 'below', [0 0 1 1] }
      %         This will add a text control containing 'string' next to the parent uicontrol.
      %
      % Note 3: Background colors of checkbox, listbox, edit and slider are set to white
      %         by default (this is defined in the function matpuGUIDefaults.m      
      %
      % If it is not a supported matlab sytle - it will assume it is the name of a java
      % component and attempt to add the Java control.
    end
    function obj = addUIGroup ( obj, parentName, newName, varargin )
      % Add a child uigroup (i.e. another tab group, or page group)
      % obj.addUIGroup ( 'parentName', 'newName', varargin )
      %  parentName: The name of the tab/page/splitpage/uipanel new uigroup added to
      %  newName   : The new name of the uigroup.
      %  varargin  : args to be passed into the new uigroup (e.g. buttonHeight)
      %
      % add a new uigroup - this is within an existing tab./page/uipanel
      % - (see example in mguide)
    end
    function obj = addUIJava( obj, parentName, newname, javaComp, model, modelProperties, varargin )
      % Add a uijava object.
      %obj.addUIJava ( pName, uiName, javaComp, javaModel, javaModelProperties, varargin );
      %obj.addUIJava ( 'Parent Name', 'uiName', 'JComboBox', ...
      %    'DefaultComboBoxModel', {default options}, ...
      %  varargin: e.g.
      %    'position', [0.3 0.8 0.5 0.07], 
      %    'setEditable', true, 
      %    'ActionPerformedCallback', @(a,b)ChangeInspection(iGroup) );
    end
    function obj = addUITree ( obj, parentName, newName, node, varargin )
      % Add a uitree 
      % obj.addUITree ( parentName, newName, node, varargin )
      %
      %  parentName:   name of page/tab/uipanel
      %  newName   :   name of tree
      %  node      :   a uitreenode
      %  varargin  :   arg pairs to be pssed to the matlab tree created
    end
    function obj = addUITreeOfDirectory ( obj, parentName, treeName, rootDir, format, varargin )
      % Add a uitree to display files and directory
      % obj.addUITreeOfDirectory ( parentName, treeName, rootDir, format, varargin )
      %
      %  parentName:   name of page/tab/uipanel
      %  treeName  :   name of tree
      %  rootDir   :   root directory for tree to start in   (*pwd*) will select the working dir.
      %  format    :   any wildcard to filter the files found in the directory
      %  varargin  :   arg pairs to be pssed to the matlab tree created
    end
    function obj = addUITreeCallback ( obj, parentName, treeName, action, callback )
      % Add a callback to an action on a uitree.
      % obj.addUITreeCallback ( parentName, treeName, action, callback
      %
      %  parentName:   name of page/tab/uipanel
      %  treeName  :   name of tree
      %  action    :   e.g. NodeWillExpandCallback
      %  callback  :   function handle.
    end
    function obj = addWebPage ( obj, parentName, containerName, url, varargin )
      % Add a webpage viewer to your tab/page/panel.
      %   hGui.addWebPage ( 'Support', 'containername, 'www.matpi.com', 'Position', [0.,0.0,1,1] );
      %
      %  parentName    :  name of page/tab/uipanel (must exist)
      %  containerName :  name of container to be created (java component)
      %  url           :  web address to host
      %  varargin      :  arg pair to apply to the container created
    end
    function obj = buildUITreeFromStruct ( obj, parentName, treeName, rootName, varPath, varargin )
      % Build a uitree from one of the internal variables (structure) in the matpigui object.
      % obj.addUITreeOfDirectory ( parentName, treeName, rootName, varPath, varargin )
      %
      %  parentName:   name of page/tab/uipanel
      %  treeName  :   name of tree
      %  rootName  :   root directory for tree to start in
      %  varPath   :   The name of the data variable in the matpi gui object (must be a var
      %            :     because each leaf is created on the fly (i.e. when requested).
      %  varargin  :   arg pairs to be pssed to the matlab tree created
    end
    function obj = rebuildUITreeChildren ( obj, parentName, treeName, node, varPath )
      % Rebuild a child node on a uitree (e.g. the data has changed)
      % obj.rebuildUITreeChildren ( obj, parentName, treeName, node, varPath )
      %
      %  parentName:   name of page/tab/uipanel
      %  treeName  :   name of tree
      %  node      :   the tree node to rebuild
      %  varPath   :   The var path to rebuild the tree from.
    end
    function obj = copyFigureToClipboard ( obj )
      % PC Only - copy figure to clipboard.
      %
      % obj.copyFigureToClipboard()
    end
    function obj = close ( obj, childFlag, unused2 )
      % Close the matpi object.
      % obj.close()
      % 
      % close a uigroup and delete all data/objects
    end
    function obj = changeSplitPanelPosition ( obj, pageName, panelName, mode, newPos )
      % obj.changeSplitPanelPosition ( pageName, 'panelName', 'height', [min max] );
      %
      %    To be used in conjunction with horzsplit or vertsplit to set the panel
      %     sizes of the different rows/columns by code.
      %       vertsplit - can only set custom height at creation
      %       horzsplit - can only set custom width at creation
      %
      %  Use this method to custom set the width or height
      %
      %  Warning: Note ued in the wrong way -> this can set panels to 
      %           be hidden behind other ones if no partners are found
      %
      %           i.e for horzsplit -> only use height mode.
      %                   vertsplit -> only use width mode.
      %
      %               no checks are done on this so use with caution.
      %
      %  % Create a horz split and set the first width
      %    h = matpigui;
      %    h.addPage ( 'pageA' );
      %    h.horzsplit ( 'pageA', [3 2], '*auto*', 0.2 );
      %    % Manipuldate the height of the middle panel in the 1st column
      %    h.changeSplitPanelPosition ( 'pageA', 'pageA-R2C1', 'height', [0.2 0.4] );
    end
    function obj = customiseSettings ( obj, varargin )
      % Customise the UICONTROLS created by the userSettings feature.
      %
      % Customise the settings - hide, readonly, uigetfile, uigetdir, etc...
      % obj.customiseSettings();                         % force the building of the GUI (use after customising)
      % obj.customiseSettings ( 'item', 'hidden', true ) % hide the top level setting.(item) from being interactive
      % obj.customiseSettings ( 'settingField', 'settingVar', 'parameter', value )  % Customise the setting
      % obj.customiseSettings ( 'settingField', 'settingSubField1', 'settingVar', 'parameter', value )  % Customise the setting
      % obj.customiseSettings ( 'settingField', 'settingSubField1', 'settingSubField2', 'settingVar', 'parameter', value )  % Customise the setting
      %  Change the display text:
      % obj.customiseSettings ( 'settingField', 'settingVar', 'displayString', 'Text To Display' )
    end
    function obj = customiseSettingsType ( obj, varargin )
      %  Customise the type of uicontrol created by the userSettings API.
      %
      % change the settings var type - currently only supports changing list/popup to multi edit.
      % obj.customiseSettingsType ( 'settingGroup', 'subField', 'edit' );
      %
      %  When a settings variable is parsed to generate defaults - there is no method to create
      %   a multi edit - this method allows the type to be changed to be a multi line edit.
    end
    function obj = deleteAxes ( obj, pageName, axesName )
      % Delete an axes handle and info from the framework.
      %
      % obj.deleteAxes ( 'parentName', 'axesName' )
    end
    function obj = deleteChild ( obj, name )
      % Delete an uigroup and info from the framework.
      % obj.deleteChild ( name );
      %
      % Delete a child matpi ui group from the object.
    end
    function obj = deleteDynamicPanel ( obj, name )
      % Delete dlynamic panel from the framework.
      % obj.deleteDynamicPanel( name )
    end
    function obj = deletePage ( obj, varargin )  
      % Delete a page handle and info from the framework.
      %
      % obj.deletePage ( name, userCallbackFlag )
      %
      % name             - name of the page to be deleted
      % userCallbackFlag - flag to run the selectTab callback of the newly selected page
    end
    function obj = deleteTab ( obj, name, runUserCallback )
      % Delete tab(s) from the gui matpi group.
      %
      % obj.deleteTab ( name, runUserCallback )
      %
      %
      % name - name of tab to delete
      % runUserCallback (true) - run the user select tab callback at the end of the delete (could be a lot of drawing -> slow)
    end
    function obj = deleteUIC ( obj, pageName, uicName )
      % Delete uicontrol handle and info from the object.
      %
      % parentName - name of the tab/page/uisplit/uipanel where uic is located
      % uicName    - name of the uic to be deleted      
    end
    function obj = deleteUISplit ( obj, name )
      % Delete split handle(s) and info from the object.
      %
      % obj.deleteUISplit ( 'parentName' )
      %
      % parentName - name of the tab/page/uisplit/uipanel where split is located
    end
    function obj = disableFigure ( obj )
      % Disable the GUI (pointer only);
      %
      % obj.disableFigure()
      %
      % Disable the figure (currently only the mouse pointer is made busy).
    end
    function obj = enable ( obj, name, flag )
      % Enable/Diable a tab from being selected
      %
      % obj.enable ( name, flag )
      %
      %  name = name of Tab to enable on/off
      %  flag ('on')  - enable on/off the tab (can be numeric/logical true/false as well as char 'on' | 'off'
      %  obj.enable ( [], 'off' ); % set all tabs enable to off
    end
    function obj = enableFigure ( obj )
      % Enable the GUI (pointer only);
      %
      % obj.enableFigure()
      %
      % Set the mouse pointer back to the previous status before it was disabled.
    end
    function output = get ( obj, tabName, uicName, property )
      % Get a property from a uicontrol/axes object
      %
      % output = obj.get ( tabName, uicName, property )
      %
      %  tabName:  tab/page/uisplit name
      %  uicName:  name of the uicontrol
      %  property: property to get (see specials)
      %                str2double      - will convert the UIC string value to a number
      %                protectedString - if UIC is protected (****) returns the protected string
      %                selectedString  - if listbox/pop then it returns the current selected string
      %                getSelectedNumbers - if listbox/pop then return selection as a double.
    end
    function output = getData ( obj, name )
      % Get data var from the object
      %
      % output = obj.getData ( name )
      % output = obj.getData ( 'struct.field' )
      %
    end
    function output = getHColorBar ( obj, varargin )
      % Get the figure/axes colour bar
      % output = obj.getHColorBar ( tabName, axesName, colourBarIndex )
      % output = obj.getHColorBar ( axHandle, colourBarIndex )
    end
    function output = getNames ( obj )
      % Get the names of the tabs/pages
      %
      % obj.getNames
    end
    function output = getNoColorMap ( obj )
      % Get the number of colour maps in the ancestral figure
      %
      % output = obj.getNoColorMap()
      %
      % Note: R2014b introduced capability to reduce the requirement for this feature.
      %
    end
    function output = getObjectName ( obj, uiObject )
      % From a uicontrol -> find out whats its name is
      %
      % output = obj.getObjectName ( uiObject )
      %
      %
    end
    function output = getRTEStr ( obj, parent, name )
    end
    function output = getPageHandle ( obj, name )
      % Get the handle of a specific tab/page.
      % index = obj.getPageHandle ( name ); 
    end
    function output = getPageProperty ( obj, name, property )
      % Get a page property
      %
      % output = getPageProperty ( name, property )
      %
      %  property:  'callback' - user function to run when becomes active
      %  type    :  'the type - i.e. a page!
    end
    function [flag,names,allPanels] = getPageSplitInfo ( obj, name )
      % Get page split information (i.e. does it contain uisplits and the names)
      %
      % [flag,names] = obj.getPageSplitInfo ( name )
      % flag - is it split or not?
      % names - the names of the uisplits     
    end
    function [bg, fore] = getUnitTestHighLightColor ( obj ) 
      %  Get the background and foreground colours used in the unit test highlighting
      %
      % [bgColor,foreColor] = obj.getUnitTestHighLightColor()
    end
    function output = getTabColours ( obj, name )
      % Get the background and foreground colours of a tab
      % obj.getTabColours ( name )
      %                     name - the tab name
    end
    function output = getTabHandle ( obj, name )
      % Get the handle of a specific tab/page.
      %
      %  output = obj.getTabHandle ( name );
    end
    function output = getTabProperty ( obj, name, property )
      % Get a tab property
      %
      % output = getPageProperty ( name, property )
      %
      %  property:  'callback' - user function to run when becomes active
      %  type    :  'the type - i.e. a tab.
      %  width   :  'the width (normalized) of the tab.
    end
    function output = getToolbarHandle ( obj, name )
      % Get a toolbar item handle
      %
      %  output = getToobarHandle ( name )
      %
      %   name of the item when it was added
    end
    function [parentName] = getPageSplitParent ( obj, name )
      % Get the name of the split parent
      %
      % output = obj.getPageSplitParent ( 'splitName' )
      %
      % output is the name of the page/tab where the split is located.
      % If splitName is not a split panel - then the 'splitName' is returned      
    end
    function output = getUIHandle ( obj, parentName, fname )
      % Get the handle to a uicontrol
      %
      %  output = obj.getUIHandle ( parent, uicName )
    end
    function [output, allPath] = getUIPanelAncestor ( obj, name, allPath )
      % Get a uipanel ancestor
      %
      % [name, ancestorPath] = obj.getUIPanelAncestor ( 'parentName', 'uipanelName' );
      %
      % name         = parentName
      % ancestorPath = the path to the uipanel (which could be a child of a tab or a uipanel etc...)      
    end
    function output = getUserSetting ( obj, varargin )
      % Return a user setting
      %
      % output = obj.getUserSetting ( varargin )
      %
      % varargin - strings detailing the struct path to the setting requested
      % example:
      %
      % setting = obj.getUserSetting ( 'general', 'settingA' );      
      %
      % recall that the userSetting is a public access variable
    end
    function output = getVersion ( obj )
      % Get the version
      % 
      %  output = obj.getVersion();
    end
    function obj = imwrite ( obj, img, filename, varargin )
      % obj.imwrite ( img );
      % obj.imwrite ( img, filename );
      % obj.imwrite ( img, '-clipboard' );
    end
    function obj = initVideo ( obj, filename )
      % Undocumented
    end
    function output = isUserSetting ( obj, varargin )
      % Check if a user setting exists.
      %
      % output = obj.isUserSetting ( varargin )
      % varargin - cell array of path into user setting
    end
    function output = isUIGroupVisible ( obj, childName )
      % Is child group visible
      %
      % output = obj.isUIGroupVisible ( 'childName' )      
    end
    function output = isSplitGroup ( obj, name )
      % Is 'name' part of a split group
      %
      % output = obj.isSplitGroup ( 'name' )      
    end
    function output = isUIButtonGroup ( obj, name )
      % Is 'name' part of a uibutton group
      %
      % output = obj.isUIButtonGroup ( 'name' )      
    end
    function output = isUIPanel ( obj, name )
      % Is 'name' a uipanel
      %
      % output = obj.isUIPanel ( 'name' )      
    end
    function obj = importSettingsFromFile ( obj, fileName )
      % Merge user customised (saved) settings with the defaults.
      %
      % obj.importSettingsFromFile ( filename )
      %
      % Used with user settings - example usage:
      %
      % Your applications default settings
      %        settings = YourDefaultSettingsFunction();
      %        % Add the settings to the GUI
      %        hGui.addSettingsUI ( 'Settings', settings );
      %        % Update the settings from the user file
      %        % (if no path in filename -> assumed in user local settings)
      %        hGui.importSettingsFromFile ( 'yourApplication.mat' );
    end
    function obj = saveModifiedSettings ( obj, fileName )
      % Save the user settings (saving any changed the user has made)
      %
      % obj.saveModifiedSettings ( filename )
      %
      % Example usage: On closing your application then you can save any settings the
      %    % user has changed:
      %    % (if no path in filename -> assumed in user local settings)
      %    hGui.saveModifiedSettings ( 'yourApplication.mat' );      
    end
    function obj = initColorMap ( obj, map )
      % init a colour map
      %  
      %  obj.ColorMap ( 'init', jet(64) )
      %
      % Note: R2014b introduced capability to reduce the requirement for this feature.
    end
    function obj = linkUIGroups ( obj, primary, linkedGroup )
      % Link two uigroups (so when one changes so does another
      %
      %  obj.linkUIGroups ( primary, linkedGroup )
      %
      %  Name of two child groups to link
      %   When one tab/page is selected the same index in the other is selected
    end
    function userTab = parseMguideStruct ( obj, userTab, mstruct, embed )
      % Parse a structure to build a GUI (very advanced use)
      %
      % see matpigui ( mstruct )
      % matpigui ( matlabStructure )
      % % where matlabStructure is a struct which is a valid format for matpigui.      
    end
    function obj = registerObj ( obj, varargin )
      % UNDOCUMENTED
    end
    function obj = saveAs ( obj, filename, varargin )
      % Save the figure to file
      %
      %  obj.saveAs()
      %  obj.saveAs( filename )
    end
    function obj = saveSubImage ( obj, pageName, fileFlag, varargin )
      % Save a individual tab/page/uipanel to file
      %
      % obj.saveSubImage ();                        % copy to clipboard
      % obj.saveSubImage ( name );                  % copy to clipboard
      % obj.saveSubImage ( name, false, varargin )  % copy to clipboard
      % obj.saveSubImage ( name, true, varargin )   % save to file (interactively select the file)
      % obj.saveSubImage ( name, 'filename.format', varargin ) % save to the file in the format give (if supported)
      %
      %  name     - page/tab/uipanel name
      %  flag     - false -> copy to clipboard (PC only)
      %           - true  -> uiselect file
      %           - filename -> auto save to the file
    end
    function obj = selectPage ( obj, varargin )
      % Make a page(or tab) active.
      %
      % obj.selectPage ( name, exeCallback, protectedTabOverride )
      %
      % name                 - name of the tab/page or index
      % exeCallback          - (true) | false Boolean flag to trigger user callback.
      % protectedTabOverride - (false) | true Boolean flag for selecting protected - tabs/pages
    end
    function obj = selectTab ( obj, option, exeCallback, overrideProtection )
      % Make a tab/page active.
      %
      % obj.selectTab ( name, exeCallback, protectedTabOverride )
      %
      % name                 - name of the tab/page or index
      % exeCallback          - (true) | false Boolean flag to trigger user callback.
      % protectedTabOverride - (false) | true Boolean flag for selecting protected - tabs/pages
%       profile on
% fprintf ( 'starting select tab\n' );
% disp ( 'in select tab' );
    end
    function obj = set ( obj, tabName, uicName, varargin )
      % Set a ui property
      %
      % obj.set ( 'parentName', 'uicName', 'property', value, 'property2', value2,  'propertyN', valueN' )
      %
      % Set a number of UI property, all valid uicontrol properties can be set plus the
      % following:
      %            'appendString' - Append a string to the end of the string property
      %                           - (designed for popup and listbox)
      %            'enable'       - Enable can be true or false as well as 'on', 'inactive', 'off'
      %            'removeString' - Remove indexed string from a list of strings
      %                           - 'end' - remove the last item
      %                           - 'first' - remove the 1st item
      %            'selectEnd'    - if pair is true - select the last item in the list
      %            'selectString' - select the string provided
      %            'string'       - as design unless value > length (string) -> value is set = 1      
    end
    function obj = setColorMap ( obj, varargin )
      % set a color map to an axes
      % obj.setColorMap ( 'parentName', 'axesName', map )
      % obj.setColorMap ( axesHandle, map )
      % map - the index of the map to assign to the axes      
      %
      % Note: R2014b introduced capability to reduce the requirement for this feature.      
    end
    function obj = setCopyFigure ( obj, flag )
      % Toggle on/off the ctrl-c copy shortcut*
      %
      % obj.setCopyFigure ( flag )
      % flag = true | ( false )
      % The default is for the code to use CTRL-C to copy a figure (if set to true) to the
      % clipboard. This can interupt the matlab process - so the KEY part of the ctrl-KEY can
      % be changed in the matpiGUIDefaults.m file.
      %
      % To change for the matlab session only:
      %     keys.copy = 'a';
      %     matpiGUIDefaults ( 'keys', keys )
      % * Windows only.      
    end
    function obj = setUIGroupCopy ( obj, copyName )
      % Change the uigroup which is copied (to clipboard) when setCopyFigure is true*
      %
      % obj.setUIGroupCopy ( childUIGroupName )
      % % The default is to copy the primary (first) uigroup - but this can be changed to copy
      % a sub image when the user uses the shortcut keys (default CTRL-C) to copy the image to
      % the clipboard
      % * Windows only.      
    end
    function obj = setLink ( obj, linkName )
      % see linkUIGroups instead
    end
    function obj = setChildRegistration ( obj, flag )
      % Set uigroup child registration at the root
      %
      % obj.setChildRegistration ( flag )
      %
      % When a uigroup is added to a child - this flag will determine if any child of a
      % child is registered at the root level
    end
    function obj = setTabColours ( obj, name, colors )
      % set the tab colours
      % obj.setTabColours ( name, color )
      %
      % name  - name of tab to set
      % color - struct containing two variables:
      %     color.bg (background)
      %     color.fore (foreground colour)      
    end
    function obj = setProtectedPage ( obj, name, flag )
      % set a Tab/Page to be protected
      %
      % obj.setProtectedPage ( name, flag )
      % name - name of the page to set
      % flag - Boolean flag to protect or unprotect a page
      %      - (e.g. unprotect after a password has provided access)
    end
    function obj = setPageProperty ( obj, name, property, value )
      % update a runtime page property
      % obj.setPageProperty ( 'name', 'property', value )
      % property:
      % 'name'     - update the name of the page
      % 'callback' - update the callback      
    end
    function obj = setTabProperty ( obj, name, property, value )
      % update a runtime tab property
      % obj.setPageProperty ( 'name', 'property', value )
      % property:
      % 'name'     - update the name of the page
      % 'callback' - update the callback      
      % 'width'    - update the tab width (normalized)
    end
    function obj = setUICFocus ( obj, page, uic )
      % Set the focuse on a specified uicontrol
      %
      %  obj.setUICFocus ( name, uicName );
    end
    function obj = setToolbarComboItems ( obj, toolbarName, items, maxWidth )
      % Set a toolbar combo box items
      %
      % obj.setToolbarComboItems ( toolbarName, items, maxWidth )
      %
      %  toolbarName : name of toolbar
      %  items       : combo box items
      %  maxWidth    : max width in pixels. (optional)
    end
    function obj = split     ( obj, varargin )
      % Add a split group which is split evenly
      %
      % obj.split ( 'parentName', dims, names, iWidth, iHeight, interactiveFlag )
      %
      % dims   - Vector - number rows and columns (e.g. [2 3])
      % names  - Cell array of names of each uipanel to be created
      % iWidth - Internal width positions of panels
      %        - e.g. two panels positions could be [0.5]
      % iHeight - internal height positions of panels
      %         - e.g. two panels positions could be [0.5]
      % interactiveFlag - whether the splits can be resized dynamically      
    end
    function obj = horzsplit ( obj, varargin )
    % add a split group which is split horizontally
    %
    % obj.horzsplit ( 'parentName', dims, names, '*auto*', '*auto*',interactiveFlag)
    %
    % dims            - vector - number of rows in each column (e.g. [1 3 1])
    % names           - cell array of names of each uipanel to be created
    % interactiveFlag - whether the splits can be resized dynamically      
    end
    function obj = vertsplit ( obj, varargin )
      % Add a split group which is split vertically
      %
      % obj.vertsplit ( 'parentName', dims, names, '*auto*', '*auto*',interactiveFlag)
      %
      % dims   - vector - number of columns in each row (e.g. [1 3 1])
      % names  - cell array of names of each uipanel to be created
      % interactiveFlag - whether the splits can be resized dynamically      
    end
    function obj = toggleButtons ( obj, state, height )
      % Toggle on/off and set the height of tab buttons
      %
      % obj.toggleButtons ( state, height )
      % state  - 'on' | 'off'
      % height - normalized height of the buttons
    end
    function obj = toolbar ( obj, mode, varargin )
      % Deprecated use obj.addToolbar ( mode, varargin )
      %  
      % Create a toolbar in the GUI
      %     obj.toolbar ( mode )
      % 
      %     mode: 'init' (adds all items below)
      %           'pages'         Adds a combo box to the toolbar containing all pages
      %           'tabs'          As above but tabs
      %           'saveImage'     Adds a icon to save the figure to file
      %           'CopyClipboard' Copies the image to the clipboard (PC only)
      %           'help'          Adds a help toolbar which is linked to the active tab/page help.      
      %           'zoomin'        Adds a help toolbar which is linked to the active tab/page help.      
      %           'zoomout'       Adds a help toolbar which is linked to the active tab/page help.      
      %
      %   Add your own custom (make sure name doesn't clash with a name above.
      %           '*custom*' 
      %            obj.toolbar ( '*custom*', '', 'name', toolbar arg pairs );
      %     To put it only on a specific page:
      %            obj.toolbar ( '*custom*', 'pagename', 'name', toolbar arg pairs );
    end
    function obj = toggleUICEnable ( obj, tabName, uicName )
      % Toggle a UIC enable status
      %
      % obj.toggleUICEnable ( 'parentName', 'uicName' )
      %
      % parentName - name of tab/page/uisplit/uipanel
      % uicName    - char or cell of char of uics to toggle      
    end
    function obj = freezeInteractiveSplits ( obj )
      % Freeze the splits on the active page
    end
    function obj = unFreezeInteractiveSplits ( obj )
      % Unfreeze the splits on the active page
    end
    function obj = uimenu ( obj, hMenu, hideButtons )
      % Add a uimenu to select tabs/pages
      % obj.uimenu ( hMenu, hideButtons )
      % hMenu - a menu object to add the tabs/pages menus to
      % hideButtons - (true) | ( false ) - if tabs hide the interactive tab selection.      
    end
    function obj = uipanelDocking ( obj, parentName, dockPanel, position )
      % Enable undocking of uipanels
      %
      %  obj.uipanelDocking ( parentName, panelName, position )
      %
      %  parentName - name of panel to undock
      %  name of panel for undock uicontrol to be placed
      %  position on the undock uicontrol.
      %
      %  This creates a undock uicontrol in the positon specified.  
      %   The parentPanel is undocked when the user clicks on 
      %   the undock object.
      %  The image changes and the uipanel is docked when it is either
      %   closed or the dock button is pressed.  
      %  Other UIPanels resize to take up the space left by the undocked
      %   panel
      %
      % If the user holds CONTROL while undocking then a COPY of the uipanel
      %  is undocked.
      %  This is a fully functioning independent panel.
      %
      %  The name of the panel is changed to have _Copy## appended to the 
      %  panel name - this allows you to access all the properties 
      %  of the panel and to interact with it.
      %
      %  ## is a 2 digit number - you can keep undocking and each new
      %    panel that is created will have an incremented index.
      %
    end
  end
end
