if object_id('dbo.RTestData') is null
BEGIN
CREATE TABLE dbo.RTestData ([col1] int not null) ON [PRIMARY]
INSERT INTO RTestData   VALUES (1);
INSERT INTO RTestData   VALUES (10);
INSERT INTO RTestData   VALUES (100) ;

END
GO


EXECUTE sp_execute_external_script
      @language = N'R'
    , @script = N' OutputDataSet <- InputDataSet;'
    , @input_data_1 = N' SELECT col1  FROM RTestData;'
	--,	@input_data_1_name = N'TestingData'
    WITH RESULT SETS (([NewColName] int NOT NULL));