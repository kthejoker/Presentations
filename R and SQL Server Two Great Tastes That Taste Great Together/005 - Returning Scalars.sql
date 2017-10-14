if object_id('dbo.RTestData') is null
BEGIN
CREATE TABLE dbo.RTestData ([col1] int not null) ON [PRIMARY]
INSERT INTO RTestData   VALUES (1);
INSERT INTO RTestData   VALUES (10);
INSERT INTO RTestData   VALUES (100) ;

END
GO

DECLARE @minVal INT;

EXECUTE sp_execute_external_script
      @language = N'R'
	  	  , @script = N'
	  MinValue <- min(InputDataSet[,1])'
	  --, @script = N'
	  --OutputDataSet <- InputDataSet;
	  --MinValue <- min(InputDataSet[,1])'
    , @input_data_1 = N' SELECT col1  FROM RTestData'
	, @params = N'@MinValue INT OUTPUT'
	,@MinValue = @minVal OUTPUT
    --WITH RESULT SETS (([NewColName] int NOT NULL));
	WITH RESULT SETS NONE;
	SELECT @minVal as minValue;