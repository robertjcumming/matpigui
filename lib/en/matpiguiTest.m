%  MATPIGUITEST - The unit test constructor
%
%   A wrapper for the matlab unit test environment
%     linked to the matpigui class
%
%   Used to create repeatable test cases to use with your GUI
%
%    see also unitTest_Working_Example_01
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
classdef matpiguiTest < matlab.unittest.TestCase & handle % & matlab.unittest.plugins.TestRunnerPlugin
  
  properties
    hGui                   % store your matpigui object in this var
    g2pdf = [];            % store the gui2pdf object here
    pausePDF = false;      % option to pause while PDF is being created
    logFailedOnly = true;  % flag to log only failed tests in the pdf
  end
  properties ( SetAccess = private )
    passed = 0;                % number of tests passed
    failed = 0;                % number of tests failed
%     NumPassingAssertions = 0;  % not used
%     NumFailingAssertions = 0;  % not used
  end
%   events 
%     VerificationPassed
%     VerificationFailed
%   end
  methods (TestClassSetup)
    function SetUpEvents ( obj )
      % This function is run in advance of setting up all tests
    end
  end
  methods (TestClassTeardown)
    function obj = ResetAllDialogs(obj)
      % This functions runs at the very end to close the GUI2PDF object if it was created
    end
  end
  methods ( TestMethodSetup )
    function obj = initTestMethod ( obj )
      % initialise the internatl variables for each test
    end
  end
  methods
    function obj = matpiguiTest() 
      % constructor.
    end
    function obj = evaluateCallback( obj, pagename, uic )
      % Evaluate a uic callback
      %
      %  obj.evaluateCallback ( pageName, uicName )
      %
      %  Please ensure pageName and uicName are valid names before running
    end
    function output = getUIC ( obj, varargin )
      % Get a UIC property from a uigroup
      %
      %  obj.get ( page, uicName, property )
      %  obj.get ( childUIGroupName, page, uicName, property )
    end
    function [flag, nDialog, messages]= isPopUpDialog ( obj, mode, varargin )
      % is a popup dialog shown?
      %
      %  [flag, nDialogs, nMessages] = obj.isPopUpDialog ( mode, varargin )
      %
      %  mode: error
      %        warn
      %        msgbox
      %        user     % see vararigin
      %
      %  varargin{1} = tag
      %  varargin{2} = expected number of dialog
      % 
    end
    function obj = selectTab ( obj, varargin )
      % Select a tab
      %
      %  obj.selectTab ( tabName )
      %  obj.selectTab ( uiGroupName, tabName )
    end
    function obj = setUIC ( obj, varargin )
      % Set a property in a uicontrol
      %
      %  obj.setUIC ( pageName, uicName, prop, value )
      %  obj.setUIC ( uiGroupName, pageName, uicName, prop, value )
    end
  end
end
