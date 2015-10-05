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
  h.selectTab ( 'About' );
  h.LicenseInfo ('About'); % this will add the license info to the about page.
  h.hFig.Name = 'About embedded into a tab';
  
  uiwait ( h.hFig );
  
  %% Option 2
  h = matpigui();
  h.addPage ( 'Tab 1' );
  h.addPage ( 'About' );
  % get a handle to a page/panel
  hPanel = h.getTabHandle ( 'About' );
  h.LicenseInfo (hPanel);
  h.toolbar('init');
  h.selectTab ( 'About' );
  h.hFig.Name = 'About embedded into a page';
  uiwait ( h.hFig );
  
  %% Option 3
  h = matpigui();
  h.addTab ( 'Tab 1' );
  h.addTab ( 'About' );
  h.split ( 'About', [2 1], {'YourAbout', 'matpiGUIAbout'} );
  h.addUIC ( 'YourAbout', 'yourCompany', 'text', 'Position', [0 0 1 0.5], 'String', 'Your App Info....', 'FontSize', 15, 'FontWeight', 'bold' );
  hPanel = h.getTabHandle ( 'matpiGUIAbout' );
  h.LicenseInfo (hPanel);
  h.selectTab ( 'About' );
  h.hFig.Name = 'About embedded into a uipanel';
  uiwait ( h.hFig );
  
end
