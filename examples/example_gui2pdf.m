% EXAMPLE_GUI2PDF - demo of how to save GUI screen shots into PDF
%
%   You need a version of ghostscript to use this -> this can be obtained
%     online from www.ghostscript.com
%
%    see also gui2pdf
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
% $Id: example_gui2pdf.m 215 2015-07-27 19:00:38Z Bob $
function example_gui2pdf
  % create the gui2pdf object 
  obj = gui2pdf( 'DEMO - Example' );
  % createa your gui
  d = figure;
  ax = axes ( 'visible', 'off' );
  text ( 0.5, 0.7, 'Demo GUI2PDF Generation', 'parent', ax, 'horizontalalignment', 'center' );
  text ( 0.5, 0.5, 'Code Developed By Matpi Ltd.', 'parent', ax, 'horizontalalignment', 'center' );
  % capture the image
  pause(1);
  obj.captureImage ( d );
  cla(ax);
  set ( ax, 'visible', 'on' );
  x = -pi:0.01:pi;
  % now do some random plotting
  for i=1:10
    plot ( ax, x, sin(5*i*x) );
    obj.captureImage ( d );
  end
  delete ( d );
  % once plotting has finished update some of the txt properties
  obj.addTxtProperty ( 'topLeft', 'color', 'red' );
  obj.addTxtProperty ( 'topLeft', 'FontSize', 12 );
  % add a blank page
  obj.addBlankPage();
  % add some custom text to that page only
  obj.addTextToPage ( 'FINISHED!!!', -1, [0.1 0.4], 'color', 'blue' );
  % multiple text objects can be added
  obj.addTextToPage ( 'multiple text objects can be added to a page', -1, [0.1 0.2], 'color', 'blue', 'interpreter', 'tex' );
  %
  % Update some PDF generation parameters
  obj.openPDF = true;
  obj.progressBar = true;
  % write the PDF
  obj.pdfFilename = 'test.pdf';
  obj.tempPSname = 'gui2pdf.ps';
  obj.ps2pdfExtras = {'deletePSFile', 1, 'gscommand', 'C:\Program Files\gs\gs9.16\bin\gswin64.exe' ...
                                         'gslibpath', 'C:\Program Files\gs\gs9.16\lib' };
  obj.writePDF();
end