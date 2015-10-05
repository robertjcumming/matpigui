% MGUIDE - a class for interactively creating GUI's
%
%  MGUIDE can be used to show you what can be done in terms of building GUI's
%
%    You can create your GUI in mguide and then use it in your application
%      as follows:
%
%
%     examples:
%
%        mguide            % launches a new instance
%
%        mguide ( 'example_Application.mat' )   % load an example provided.
%
%        load example_Application.mat
%        mguide ( mfig );
%
%    % How to use and develop your code:
%
%    Create your GUI and save to YOURAPPLICATION.mat
%
%    Create a new m-file:
%     yourapplication.m
%
%      function myApp = yourapplication
%
%         myApp = matpigui ( 'YOURAPPLICATION.mat' );
%
%         % continue your code.
%         % note that any changes to the GUI you make here will not 
%         %  be seen in mguide
%         %  But you can load the .mat file into mguide to continue developing.
%
%      end
%
%     
%  
%  see also matpigui, example_mguide
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: mguide.m 248 2015-10-05 09:03:19Z robertcumming $
classdef mguide < handle % hgsetget & handle
  properties (GetAccess=public, SetAccess=protected)
    version = '1.0.0.EH'
  end
  
  % Public Methods
  %   some methods have to be public to allow for the embedded child tab groups - this is not ideal.
  methods  % public
    function obj = mguide ( varargin )
      % MGUIDE Constructor
      %
      %  mguide
      %  mguide ( struct )
      %  mguide ( 'filename'mat' )
      %
    end
  end
end
