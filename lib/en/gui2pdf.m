%  GUI2PDF - save images from your GUI into a PDF document
%
%   A class for storing image data from your GUI and at the
%   end saving it to a PDF file
%
%   see also example_gui2pdf
%
% Copyright Robert Cumming @ Matpi Ltd.
% www.matpi.com
classdef gui2pdf < handle
  properties % public
    topLeft     = 'Project'        % text to be placed in top left location
    topMiddle   = '*companyName*'  % text to be placed in top middle location
    topRight    = '*date*'         % text to be placed in top right (auto date)
    bottomLeft  = '*pageNo*'       % text to be placed in bottom left (auto page number)
    bottomRight = '*pdfFilename*'  % text to be placed in bottom right (auto filename)
    
    % internal values
    pdfFilename = 'gui2pdf.pdf';    % internal variables used in auto generation process
    companyName = 'Matpi Ltd';     % used in copyright name
    tempPSname = '.gui2pdf.temp.ps';       % temp file used in generation
    pageFormatStr = 'Page %i / %i';% format of page number generation.
    
    % PS format options
    printFormat = '-dpsc2'         % format used in print command (must save to .ps)
    printExtras = {};              % any extra param pairs to pass into print command
    ps2pdfExtras = {'deletePSFile', 1} % extra args to ps2pdf
    openPDF = false;               % flag to open the pdf when finished (true/false)
    progressBar = false;           % progressbar flag
    userData = struct;             % a place for you to store information.
  end
  
  properties (SetAccess = private )
    version = '1.0.0.EE'
    otherText = cell(0);            % other text items can be added here
  end
  
  methods
    function obj = gui2pdf ( varargin )
      % obj = gui2pdf()
      % text strings can be passed in to preset the txt controls:
      % obj = gui2pdf(topLeft,topMiddle,topRight,bottomLeft,bottomRight)
    end
    function obj = addBlankPage ( obj )
      %  obj.addBlankPage()
      % add a blank page.
    end
    function obj = addTextToPage ( obj, string, page, position, varargin )
      % obj.addTextToPage ( 'text', pageNo, [x y], argPairs )
      % pageNo == -1 : will add to the last page.
    end
    function obj = captureImage ( obj, hFig )
      % capture an image on HFig: uses getframe (hFig)
%       try
%         if exist ( 'screenCapture.m', 'file' ) == 2
%           obj.imData{end+1} = screencapture ( hFig );
%         end
%       catch
    end
    function obj = addTxtProperty ( obj, control, varargin )
      % obj.addTxtProperty ( txtControlName, arg-pairs )
      %
      % obj.addTxtProperty ( 'topLeft', 'color', 'red' );
      % obj.addTxtProperty ( 'topLeft', 'Position', [0.5 0.5 0] );
    end
    function output = noPages ( obj )
      % obj.noPages()
    end
    function obj = removePages ( obj, pages )
      % obj.removePages ( [1 4] );
    end
    function obj = reset ( obj )
      % obj.reset()
      %  resets all stored image data.
    end
    function obj = writePDF ( obj, filename )
      % obj.writePDF()  % uses obj.pdfFilename
      % obj.writePDF( fileame )
    end
  end
end
