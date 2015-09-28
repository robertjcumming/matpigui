% HTML2STR - retrieves the original string from a HTML string
%
%  string = HTML2STR ( string );
%
%   see also str2html
% 
%  Author:    Robert Cumming
%  Copyright: Matpi Ltd.
% $Id: html2str.m 215 2015-07-27 19:00:38Z Bob $
function name = html2str(name)
  name = char(name);
  if length(name)> 6 && strcmp ( name(1:6), '<HTML>' )
    indexStart = strfind(name,'>');
    indexEnd = strfind(name,'</');
    indexStart(indexStart>indexEnd(1)) = [];
    name(indexEnd(1):end) = [];
    name(1:indexStart(end)) = [];
  end
end
