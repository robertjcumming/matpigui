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
%  $Id: unitTest_Working_Example_01_PDF.m 215 2015-07-27 19:00:38Z Bob $
classdef unitTest_Working_Example_01_PDF < matpiguiTest   
  properties
     %     Add any individual proerties here for this class
  end
  %%------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  % methods which will run before a any test is started.
  %%------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  methods (TestClassSetup)
    function obj = RunsBeforeAllTests(obj)
      obj.hGui = Working_Example_01; % hGui is a property of the matpiguiTest
                                     % It MUST be a matpigui object
      % create a gui2pdf object
      obj.g2pdf = gui2pdf('MatpiGUI UnitTest Example');
      % update the top left text properties
      obj.g2pdf.addTxtProperty ( 'topLeft', 'Color', 'red', 'FontWeight', 'bold' );
      obj.g2pdf.addTxtProperty ( 'topLeft', 'FontSize', 12 );
      % at the end of the test, show the progress of the pdf generation and
      % open the pdf when finished
      obj.g2pdf.openPDF = true;
      obj.g2pdf.progressBar = true;
      % update the filename of the pdf
      obj.g2pdf.pdfFilename = 'unitTest_Working_Example_01_PDF.pdf';
      % You may have to add this command (check YOUR version of ghostscript)
      obj.g2pdf.ps2pdfExtras = {'gscommand', 'C:\Program Files\gs\gs9.16\bin\gswin64.exe' ...
                                         'gslibpath', 'C:\Program Files\gs\gs9.16\lib' };      % add a black page with some text - this is the pdf front page.
      % add a black page with some text - this is the pdf front page.
      obj.g2pdf.addBlankPage();
      % add some text to the front page.
      obj.g2pdf.addTextToPage ( 'Running unitTest Working Example 01 PDF', -1, [0.1 0.8], 'FontSize', 15, 'FontWeight', 'Bold' );
    end
  end
  % method to run at the end of all the tests
  methods (TestClassTeardown)
    function obj = RunsAfterAllTests(obj)
      % the g2pdf object keeps a running total of the passed and failed
      % tests - when finishing the pdf we can add summary information to
      % the front page (page 1)
      if obj.g2pdf.userData.fail ~= 0
        obj.g2pdf.addTextToPage ( sprintf ( '%i Failed', obj.g2pdf.userData.fail ), 1, [0.1 0.2], 'FontSize', 12, 'FontWeight', 'Bold', 'Color', 'red' );
      end
      % only write the passed test if they are documented in the pdf (you
      % could of course still write this even if the failed only were
      % logged)
      if obj.logFailedOnly == false
        obj.g2pdf.addTextToPage ( sprintf ( '%i Passed', obj.g2pdf.userData.pass ), 1, [0.1 0.3], 'FontSize', 12, 'FontWeight', 'Bold', 'Color', 'blue' );
      end
      obj.hGui.close(); % close the gui using the matpigui close function
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
      % In this example reset the plot variables 
      obj.pausePDF = true;
      obj.setUIC ( 'Plots', 'popupmenu1', 'Value', 1 );
      % an expression can be passed in and it is parsed
      obj.setUIC ( 'Plots', 'edit1', 'String', '-pi:0.01:pi' );
      obj.setUIC ( 'Plots', 'edit2', 'String', '1' );
      % numeric values can be passed in and they are converted to a string
      % automatically
      obj.setUIC ( 'Plots', 'edit3', 'String', 1 );
      obj.pausePDF = false;
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
    function obj = VerifySetUpCorrectly(obj)
      % if this fails - then all other tests are expected to fail.
      % in all tests we add a black page with some text on it -> this
      % should describe what the next page(s) wwill show.
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Running VerifySetUpCorrectly (Contains no Visuals)', -1, [0.1 0.5], 'FontSize', 20 );
      obj.verifyEqual ( 'matpigui', class(obj.hGui), 'The internal Variable hGui must be a "matpigui" object' );
    end
    
    %% DUMMY FAIL
    function obj = OnLaunchCheckPlotHasNoChildren(obj)
      % check that on launch the a plot is drawn in the axes
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Running Expected Fail - Plot Empty', -1, [0.1 0.5], 'FontSize', 20 );
      obj.selectTab ( 'Plots' );                                  % select the tab
      axChildren = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );  % find the axes children
      % verification is done on the axes children not being empty.
      obj.verifyTrue ( isempty ( axChildren ), 'Check on launch that plot is empty failed' );
    end
    function obj = OnLaunchCheckPlotHasChildren(obj)
      % check that on launch the a plot is drawn in the axes
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Running Launch Check - Plot Shown', -1, [0.1 0.5], 'FontSize', 20 );
      obj.selectTab ( 'Plots' );                                  % select the tab
      axChildren = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );  % find the axes children
      % verification is done on the axes children not being empty.
      obj.verifyTrue ( ~isempty ( axChildren ), 'Check on launch that plot has children failed' );
    end
    % Continue with other tests
    function OnChangeTrigFunction(obj)
      % before running the tests extract the children of the axes
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Running Check On Trig Function Changing - Plot Updated', -1, [0.1 0.5], 'FontSize', 20 );
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
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Running Check On Value B Changing - Plot Updated', -1, [0.1 0.5], 'FontSize', 20 );
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );           
      ydata = get ( child1, 'ydata' );
      obj.setUIC ( 'Plots', 'edit3', 'String', '2' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );      
      obj.verifyTrue ( ~isequal ( ydata, get ( child2, 'ydata' )), 'Check changing B value -> plot did not change' );
    end
    function OnChangeValueA(obj)
      % this test is similar to the one above - instead we are changing the
      % value of the edit2 uicontrol (the value A)
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Running Check On Value A Changing - Plot Updated', -1, [0.1 0.5], 'FontSize', 20 );
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );           
      ydata = get ( child1, 'ydata' );
      obj.setUIC ( 'Plots', 'edit2', 'String', '2' );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );      
      obj.verifyTrue ( ~isequal ( ydata, get ( child2, 'ydata' )), 'Check changing A value > plot did not change' );
    end
    function OnChangeValueX(obj)
      % this test is similar to the one above - instead we are changing the
      % value of the edit1 and checking the xdata of the plots)
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Running Check On X Value Changing - Plot Updated', -1, [0.1 0.5], 'FontSize', 20 );
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
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Running Check On Data Table Empty On Launch', -1, [0.1 0.5], 'FontSize', 20 );
      data = obj.getUIC ( 'Data Viewer', 'uitable1', 'Data' );           
      obj.verifyTrue ( isempty ( data ), 'Check that uitable data not populated on launch' );
    end
    function OnCheckDataTablePopulatedOnTabSelection(obj)
      % post selecting the data viewer check that the data is populated.
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Running Check On Data Table Populated On Selection', -1, [0.1 0.5], 'FontSize', 20 );
      obj.selectTab ( 'Data Viewer' );
      data = obj.getUIC ( 'Data Viewer', 'uitable1', 'Data' );           
      obj.verifyTrue ( ~isempty ( data ), 'Check that uitable data populated on selection' );
    end
    function OnCheckDataTableChangePostPlot(obj)
      % extract out the data from the table
      % then update the plot and check that the data changed.
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Running Check On Data Table Updated on Plot Change', -1, [0.1 0.5], 'FontSize', 20 );
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
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Check User Changing Color Setting -> Plot Color Updated', -1, [0.1 0.5], 'FontSize', 20 );
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
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Check User Changing Marker Setting -> Plot Marker Updated', -1, [0.1 0.5], 'FontSize', 20 );
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
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Check User Changing Line Setting -> Plot Line Updated', -1, [0.1 0.5], 'FontSize', 20 );
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
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Check User Changing Marker Flag Setting -> Plot Marker Removed', -1, [0.1 0.5], 'FontSize', 20 );
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
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Check User Changing Line Flag Setting -> Plot Line Removed', -1, [0.1 0.5], 'FontSize', 20 );
      obj.setUIC ( 'Settings', 'incMarker', 'Value', 1 );
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
      obj.g2pdf.addBlankPage();
      obj.g2pdf.addTextToPage ( 'Check User Changing CLA Flag Setting -> Plot Not Cleared', -1, [0.1 0.5], 'FontSize', 20 );
      child1 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      nChild = length ( child1 );
      obj.selectTab ( 'Settings' );
      obj.setUIC ( 'Settings', 'incMarker', 'Value', 1 );
      obj.setUIC ( 'Settings', 'incLine', 'Value', 1 );
      obj.setUIC ( 'Settings', 'userList', 'Value', 2 );
      obj.setUIC ( 'Settings', 'clearAx', 'Value', 0 );
      obj.selectTab ( 'Plots' );
      obj.setUIC ( 'Plots', 'popupmenu1', 'Value', 2 );
      child2 = obj.getUIC ( 'Plots', 'iAxes1', 'Children' );
      obj.verifyTrue ( ~isequal ( nChild, length ( child2 )), 'Check that uitable data populated on selection' );
    end
  end
end
