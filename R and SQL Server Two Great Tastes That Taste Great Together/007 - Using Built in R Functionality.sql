EXEC sp_execute_external_script
      @language = N'R'
    , @script = N'
         OutputDataSet <- as.data.frame(rnorm(100, mean = 50, sd =3));'
    , @input_data_1 = N'   ;'
      WITH RESULT SETS (([Density] float NOT NULL));


	  /*--------------------------------------------------------------*/

	  IF OBJECT_ID('dbo.CarSpeed') IS NULL
	  BEGIN
	  CREATE TABLE dbo.CarSpeed ([speed] int not null, [distance] int not null)
INSERT INTO dbo.CarSpeed
EXEC sp_execute_external_script
        @language = N'R'
        , @script = N'car_speed <- cars;'
        , @input_data_1 = N''
        , @output_data_1_name = N'car_speed'
		END


		select * from dbo.CarSpeed;

		declare @m varbinary(max);

	   EXEC sp_execute_external_script
    @language = N'R'
    , @script = N'lrmodel <- rxLinMod(formula = distance ~ speed, data = CarsData);
        model_out <- serialize(lrmodel, connection=NULL);'
    , @input_data_1 = N'SELECT [speed], [distance] FROM CarSpeed'
    , @input_data_1_name = N'CarsData'
    --, @output_data_1_name = N'trained_model',
	,@params = N'@model_out varbinary(max) OUTPUT',
	@model_out = @m OUTPUT
   -- WITH RESULT SETS ((model varbinary(max)));

   select @m;


	 IF OBJECT_ID('dbo.NewCarSpeed') IS NULL
	  BEGIN
	CREATE TABLE [dbo].[NewCarSpeed]([speed] [int] NOT NULL,
    [distance] [int]  NULL) ON [PRIMARY];
	

INSERT [dbo].[NewCarSpeed] (speed)
VALUES (40),  (50),  (60), (70), (80), (90), (100)
END


EXEC sp_execute_external_script
    @language = N'R'
    , @script = N'
            current_model <- unserialize(as.raw(speedmodel));
            new <- data.frame(NewCarData);
            predicted.distance <- rxPredict(current_model, new);
            str(predicted.distance);
            OutputDataSet <- cbind(new, ceiling(predicted.distance));
            '
    , @input_data_1 = N' SELECT speed FROM [dbo].[NewCarSpeed] '
    , @input_data_1_name = N'NewCarData'
	--, @parallel = 1
    , @params = N'@speedmodel varbinary(max)'
    , @speedmodel = @m
WITH RESULT SETS (([new_speed] INT, [predicted_distance] INT))