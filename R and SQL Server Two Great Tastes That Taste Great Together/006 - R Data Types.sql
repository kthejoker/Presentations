EXECUTE sp_execute_external_script
      @language = N'R'
    , @script = N'x = 6; 
	OutputDataSet <- x;
	str(OutputDataSet)'
        WITH RESULT SETS (([NewColName] int NOT NULL));


	

	if object_id('dbo.RTestData2') is null
BEGIN
CREATE TABLE dbo.RTestData2 ([col1] int not null, createdate datetime, type nvarchar(20), amount float) ON [PRIMARY]
INSERT INTO RTestData2   VALUES (1, getdate(), 'A', 3.25);
INSERT INTO RTestData2   VALUES (10, getdate(), 'B', 7.11111);
INSERT INTO RTestData2  VALUES (100, getdate(), 'C', 1) ;

END
GO



EXECUTE sp_execute_external_script
      @language = N'R'
    , @script = N' str(InputDataSet);'
    , @input_data_1 = N' SELECT *  FROM RTestData2;'
	--,	@input_data_1_name = N'TestingData'
    --WITH RESULT SETS (([NewColName] int NOT NULL));