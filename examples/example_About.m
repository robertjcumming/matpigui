%  EXAMPLE_ABOUT Creates 3 GUI's with different About GUIs
%
%
%  Copyright Robert Cumming @ Matpi Ltd.
%  www.matpi.com
%  $Id: example_About.m 215 2015-07-27 19:00:38Z Bob $
function example_About
  %%  Option 1
  h = matpigui();
  h.addTab ( 'Tab 1' );
  h.addTab ( 'About' );
  h.LicenseInfo ('About'); % this will add the license info to the about page.
  
  
  %% Option 2
  h = matpigui();
  h.addTab ( 'Tab 1' );
  h.addTab ( 'About' );
  % get a handle to a page/panel
  hPanel = h.getTabHandle ( 'About' );
  h.LicenseInfo (hPanel);
  
  %% Option 3
  h = matpigui();
  h.addTab ( 'Tab 1' );
  h.addTab ( 'About' );
  h.split ( 'About', [2 1], {'YourAbout', 'matpiGUIAbout'} );
  hPanel = h.getTabHandle ( 'matpiGUIAbout' );
  h.LicenseInfo (hPanel);
  
end
