EXEC sp_execute_external_script
  @language =N'R',
  @script=N'OutputDataSet<-InputDataSet',
  @input_data_1 =N'SELECT ''world'' AS [hello]'
  WITH RESULT SETS (([hello] varchar(50) not null));
GO