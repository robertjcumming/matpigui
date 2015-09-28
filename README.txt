MATPIGUI Toolbox
----------------

A GUI toolbox which can be used to create advanced GUIs very easily.

No handles
No guidata
Tabs &/or multiple pages
Work on all versions of Matlab
Advanced data linking and brushing
Interactive 2D plotting (simple zooming and panning)

This is a DEMO version which has an expiry built into it.


For any questions or comments please contact us on contact@matpi.com

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INSTALLATION      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

Upzip to a new folder
Launch Matlab and cd to that folder.
Run the file setupmatpi to set up the paths.

Note: In the latest Matlab version(s) the help is built into Matlab doc.
So you can access help by typing "doc matpigui"


%%%%%%%%%%%%%%%%%%%%%%%%%
%%% MGUIDE & MATPIGUI %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

To launch the mguide GUI builder please type:

  mguide

at the matlab command line.

You will be able to build graphical applications in which will use the iAxes, matpigui classes.  For full help see the documentation.

Create a GUI in mguide - save it as a .mat file -> then you can use this in the following way

	myApp = matpigui ( 'yourApplication.mat' );

By doing this (instead of saving to a .m file) you will be able to continue to develop your GUI in mguide.


MATPIGUI: This is the underly class where all GUI's are built - to utlilise it fully see the documentation and the examples.

Note:
The majority of our users (& our consultancy jobs) create GUI's from the commands using the matpigui object directly, to fully
appreciate the power of the matpigui class you are encouraged to learn how to create GUI's using the class directly.
A number of clients use mguide to learn the command and then copy them from the inbuilt editor into their own application.


%%%%%%%%%%%%%%%
%%% IAXES   %%%
%%%%%%%%%%%%%%%
A 2D axes with interactive zooming & magnification.

See the demo m-file example_iAxes  which creates an iAxes and shows how the features work.

In 2D axes you can left click near the labels to set the min range, right click to set min and middle click to set auto.
Double Left click on the axes to bring up a magnifying glass.
Double Right click on the xes to bring up a annotation GUI.

%%%%%%%%%%%%%%%%%%%%
%%% DYNAMICPANEL %%%
%%%%%%%%%%%%%%%%%%%%
See the demo file example_dynamicPanel  which creates an GUI with a dynamic panel and shows how the features work.

A m-file is included:

example_dynamicPanel

Which shows how to create a dynamicPanel and how to automate some of the features.

It is designed for interactive use - after creating a panel hover the mouse near the edge where the panel is (for 2 seconds) and the panel will appear.
You can fix it in position using the pin.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FILE IO Capabilities %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The toolbox has the following FILEIO capabilites:

muigetfile - customisable uigetfile dialog (run time customisation of file retrieval + progress bar updates on loading)
muiputfile - customisable uiputfile dialog (run time customisation of file saving + progress bar updates on loading)
fastsave   - improved saving of network files*
fastread   - improved loading of network files*

* PC Only - Network performance is usually slower than reading locally - improvements cannot be guaranteed but in all our testing it is faster for large files.

See details below and example_fileIO

Other examples:
data = muigetfile ( @example_ReadRoutine_01 )
data = muigetfile ( @example_ReadRoutine_02 )
muiputfile ( @example_WriteRoutine_01, rand(10) )
muiputfile ( @example_WriteRoutine_02, rand(10) )


%%%%%%%%%%%%%%%%%%%%%%%%
%%% LINKDATA & BRUSH %%%
%%%%%%%%%%%%%%%%%%%%%%%%

Linkdata and brush are advanced capabilities which offer much more than the standard Matlab functions.

example_linkBrush.m
% close the msg box (demo loading more data -> causes plots to auto update)
% left click on axes to start selection, move mouse and left click again to close
%    clicking right after left will convert the mode to lasso
% hold down control before selecting to multi select.
% change the page (popupmenu in toolbar) to see brushed data in another page

There are 6 examples of brushing & linking

The latest release includes:

	Brushing of 3D data
	Highlighting points by moving over them with a user defined circle/square/rect of custom shape (see example 03 and selet from toolbar)
	Putting data into different groups so you can choose whether all data are brushed or just certain lines
		The groups can be individually formatted.
	Brushing data plotted using the hist function.

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% UNDOCKING UIPANELS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

One of the latest features is the ability to undock a uipanel to be hosted in a new figure - you can undock the original or make a copy during the undocking

Three 3 examples are included in the examples folder which start from the most basic to more advanced use where the GUI is set up to allow for the undocking 
 and shows how you can prepare for this in your callbacks from the uicontrol in the panel which is undocked.


%%%%%%%%%%%%%%%
%%% UITREE  %%%
%%%%%%%%%%%%%%%

The ability to build uitrees is included - uitrees are undocmented in Matlab and this development only covers the current incarnation of uitrees ~R2012b onwards.

The matpigui framework can build 2 different types of trees:

1. From a structure variable      (example_uitree_01)
2. Of a directory/file strucutre  (example_uitree_02)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  GUI RUNTIME SETTINGS  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

One of the more powerful but under utilized by our customers (info obtained through questionaire) is the runtime settings

This allows for really quick evolution in GUI development, a runtime setting can be added in one line of code and it is available in the code but ALSO a GUI item 
is automatically created so that the setting can be altered at runtime by the user.

See example_userSettings


%%%%%%%%%%%%%%%
%%% GUI2PDF %%%
%%%%%%%%%%%%%%%
Store your GUI images into a PDF.  This requires an installation of ghostscript (http://www.ghostscript.com/)

See example_gui2pdf.m

%%%%%%%%%%%%%%%
%%% GENERAL %%%
%%%%%%%%%%%%%%%

There are MANY examples in the examples folder and working examples can be found @ www.matpi.com

Please CONTACT US if you would like to see other capability.


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    MATPIGUITEST   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

For R2013a onwards - UNIT TESTS

In the testing folder there are 3 examples of how you can unit test the GUI.


cd to the folder where you unzipped the files and in matlab type:


  % to run the case where all unit tests are saved to PDF
  runtests unitTest_Working_Example_01_AllPDF

  % to run the case where only a dummy failed tests are saved to PDF
  runtests unitTest_Working_Example_01_PDF

