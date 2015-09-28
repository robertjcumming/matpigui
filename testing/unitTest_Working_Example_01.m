%
%   This is an example file showing how the matlab unit test framework
%     and the matpiguiTest class
%
%   This example shows how the user can write tests for and run the GUI
%   to check for failures.  This test is not as detailed as a real test
%   could be, but shows how and what you could test.
%
%   This is a first introduction to the matpiguiTest, it does not contain
%   all the methods which are available.
%
%
%  Author:    Robert Cumming
%  Copyright: Matpi Ltd.
%  $Id: unitTest_Working_Example_01.m 215 2015-07-27 19:00:38Z Bob $
classdef unitTest_Working_Example_01 < matpiguiTest   
  properties
     %     Add any individual proerties here for this class
  end
  %%------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  % methods which will run before a any test is started.
  %%------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  methods (TestClassSetup)
    function RunsBeforeAllTests(obj)
      obj.hGui = Working_Example_01; % hGui is a property of the matpiguiTest
                                     % It MUST be a matpigui object
    end
  end
  % method to run at the end of all the tests
  methods (TestClassTeardown)
    function RunsAfterAllTests(obj)
      obj.hGui.close() % close the gui using the matpigui close function
    end
  end
  %%------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  % Runs this function before individiual test is run.
  %%------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  methods(TestMethodSetup)
    function obj = RunsBeforeEachTest(obj)      
      % if we were checking the startup and shut down of the gui we could
      % launch a gui here before the test is run for example.
      %
      % In this example I reset the plot variables 
      obj.setUIC ( 'Plots', 'popupmenu1', 'Value', 1 );
      % an expression can be passed in and it is parsed
      obj.setUIC ( 'Plots', 'edit1', 'String', '-pi:0.01:pi' );
      obj.setUIC ( 'Plots', 'edit2', 'String', '1' );
      % numeric values can be passed in and they are converted to a string
      % automatically
      obj.setUIC ( 'Plots', 'edit3', 'String', 1 );
    end
  end  
  % methods to run after each individual test
  methods(TestMethodTeardown)
    function obj = RunsAfterEachTest(obj)      
    end
  end
  %------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  %  Start of the individual tests
  %------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  methods ( Test )
    % 1st test to verify that the test is set up correctly.
    function VerifySetUpCorrectly(obj)
      % if this fails - then all other tests are expected to fail.
      obj.verifyEqual ( 'matpigui', class(obj.hGui), 'The internal Variable hGui must be a "matpigui" object' );
    end
      
    function OnLaunchCheckPlotHasChildren(obj)
      % check that on launch the a plot is drawn in the axes
      obj.selectTab ( 'Plots' );                                  % select the tab
      axChildren = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );  % find the axes children
      % verification is done on the axes children not being empty.
      obj.verifyTrue ( ~isempty ( axChildren ), 'Check on launch that plot is shown failed' );
    end
    % Continue with other tests
    function OnChangeTrigFunction(obj)
      % before running the tests extract the children of the axes
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );     
      % extract the ydata
      ydata = get ( child1, 'ydata' );
      % change the trig function
      obj.setUIC ( 'Plots', 'popupmenu1', 'Value', 2 );
      % changing the trig function should trigger a call to update the plot
      % extract the children
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );      
      % check that the ydata has changed.
      obj.verifyTrue ( ~isequal ( ydata, get ( child2, 'ydata' )), 'Check changing trig function -> plot did not change' );
    end
    function OnChangeValueB(obj)
      % this test is similar to the one above - instead we are changing the
      % value of the edit3 uicontrol (the value B).
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );           
      ydata = get ( child1, 'ydata' );
      obj.setUIC ( 'Plots', 'edit3', 'String', '2' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );      
      obj.verifyTrue ( ~isequal ( ydata, get ( child2, 'ydata' )), 'Check changing B value -> plot did not change' );
    end
    function OnChangeValueA(obj)
      % this test is similar to the one above - instead we are changing the
      % value of the edit2 uicontrol (the value A)
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );           
      ydata = get ( child1, 'ydata' );
      obj.setUIC ( 'Plots', 'edit2', 'String', '2' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );      
      obj.verifyTrue ( ~isequal ( ydata, get ( child2, 'ydata' )), 'Check changing A value > plot did not change' );
    end
    function OnChangeValueX(obj)
      % this test is similar to the one above - instead we are changing the
      % value of the edit1 and checking the xdata of the plots)
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );           
      xdata = get ( child1, 'xdata' );
      obj.setUIC ( 'Plots', 'edit1', 'String', '[0:0.01:1]' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );      
      obj.verifyTrue ( ~isequal ( xdata, get ( child2, 'xdata' )), 'Check changing x vector -> plot did not change' );
    end
    
    % functions to check the data in the table
    function OnCheckDataTableEmptyOnStart(obj)
      % check that the data viewer is empty if the tab has not been
      % selected
      data = obj.getUIC ( 'Data Viewer', 'uitable1', 'Data' );           
      obj.verifyTrue ( isempty ( data ), 'Check that uitable data not populated on launch' );
    end
    function OnCheckDataTablePopulatedOnTabSelection(obj)
      % post selecting the data viewer check that the data is populated.
      obj.selectTab ( 'Data Viewer' );
      data = obj.getUIC ( 'Data Viewer', 'uitable1', 'Data' );           
      obj.verifyTrue ( ~isempty ( data ), 'Check that uitable data populated on selection' );
    end
    function OnCheckDataTableChangePostPlot(obj)
      % extract out the data from the table
      % then update the plot and check that the data changed.
      obj.selectTab ( 'Data Viewer' );
      data1 = obj.getUIC ( 'Data Viewer', 'uitable1', 'Data' );           
      obj.selectTab ( 'Plots' );
      obj.setUIC ( 'Plots', 'edit2', 'String', 2 );
      obj.selectTab ( 'Data Viewer' );
      data2 = obj.getUIC ( 'Data Viewer', 'uitable1', 'Data' );           
      obj.verifyTrue ( ~isequal ( data1, data2 ), 'Check that uitable data changed on plot change failed' );
    end
    
    % Check that changing a setting has the desired impact.
    function CheckColourChange ( obj )
      % change the colour selection in the setting and check that when the
      % plot is updated the color is different
      %  (a better check would be to verify the actual color)
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      color = child1.Color;
      obj.selectTab ( 'Settings' );
      obj.setUIC ( 'Settings', 'colour', 'selectString', 'green' );
      obj.selectTab ( 'Plots' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      obj.verifyTrue ( ~isequal ( color, child2.Color ), 'Check that uitable data populated on selection' );
    end
    function CheckMarkerChange ( obj )
      % as above but checking the marker
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      marker = child1.Marker;
      obj.selectTab ( 'Settings' );
      obj.setUIC ( 'Settings', 'marker', 'Value', 2 );
      obj.selectTab ( 'Plots' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      obj.verifyTrue ( ~isequal ( marker, child2.Marker ), 'Check that uitable data populated on selection' );
    end
    function CheckColourLine ( obj )
      % as above but checking the line.
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      lineStyle = child1.LineStyle;
      obj.selectTab ( 'Settings' );
      obj.setUIC ( 'Settings', 'linestyle', 'Value', 2 );
      obj.selectTab ( 'Plots' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      obj.verifyTrue ( ~isequal ( lineStyle, child2.LineStyle ), 'Check that uitable data populated on selection' );
    end
    function CheckColourIncMarker ( obj )
      % as above but checking the inclusion of the marker.
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      marker = child1.Marker;
      obj.selectTab ( 'Settings' );
      obj.setUIC ( 'Settings', 'incMarker', 'Value', 0 );
      obj.selectTab ( 'Plots' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      obj.verifyTrue ( ~isequal ( marker, child2.Marker ), 'Check that uitable data populated on selection' );
    end
    function CheckColourIncLine ( obj )
      % as above but checking the inclusion of a line in the plot.
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      lineStyle = child1.LineStyle;
      obj.selectTab ( 'Settings' );
      obj.setUIC ( 'Settings', 'incLine', 'Value', 0 );
      obj.selectTab ( 'Plots' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      obj.verifyTrue ( ~isequal ( lineStyle, child2.LineStyle ), 'Check that uitable data populated on selection' );
    end
    function SettingsGeneralCLA ( obj )
      % another setting in the gui was to clear the axes before updating
      % the plot.  This checks that if that is set to 0 then check that the
      % next plot is added to the gui.
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      nChild = length ( child1 );
      obj.selectTab ( 'Settings' );
      obj.setUIC ( 'Settings', 'incMarker', 'Value', 1 );
      obj.setUIC ( 'Settings', 'incLine', 'Value', 1 );
      obj.setUIC ( 'Settings', 'userList', 'Value', 2 );
      obj.setUIC ( 'Settings', 'clearAx', 'Value', 0 );
      obj.selectTab ( 'Plots' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      obj.verifyTrue ( ~isequal ( nChild, length ( child2 )), 'Check that uitable data populated on selection' );
    end
  end
end
