% EXAMPLE_MDATATIP2 - A more detailed example of how to add unique info
%
%  No inputs or outputs
%
% Author:    Robert Cumming
% Copyright: Matpi Ltd.
% 
% %Id%
function example_mdatatip2
  % load patients data (this is from help table)
  load patients
  % make a table of data
  patients = table(LastName,Gender,Age,Height,Weight,Smoker,Systolic,Diastolic);
  % create a new figure
  figure
  % create a plot
  h = plot ( patients.Age, patients.Height, 'kx' );
  % give the plot a title
  title ( 'Patients Height v Age' )
  % create a mdatatip which will display the patient info when the user
  %   clicks on any item plot item
  mdatatip ( h, @MyDataTipFunction, patients );
end
function txt = MyDataTipFunction ( h, pointInfo, patients )
  % get the row item
  rowIndex = pointInfo.index;
  % find out how many items were selected
  nRows = length(rowIndex);
  % create a text object
  txt = '';
  % loop for the number of rows
  for ii=1:nRows
    % built the text string 
    txt = sprintf ( '%s%s (%s)\nAge: %i\nWeight: %i\nHeight: %i\nSystolic: %i\nDiastolic: %i', ...
      txt, ...
      patients.LastName{rowIndex(ii)}, ...
      patients.Gender{rowIndex(ii)}, ...
      patients.Age(rowIndex(ii)), ...
      patients.Height(rowIndex(ii)), ...
      patients.Weight(rowIndex(ii)), ...
      patients.Systolic(rowIndex(ii)), ...
      patients.Diastolic(rowIndex(ii)) ...
      );
    % add a row if they are a ssmoker
    if patients.Smoker(rowIndex(ii)) 
      txt = sprintf ( '%s\nSmoker', txt );
    end
    % if multiple patients under the selected item then add a line break between them
    if ii~=nRows
      txt = sprintf ( '%s\n\n', txt );
    end
  end
end