sp_configure

EXEC sp_configure  'external scripts enabled', 1
RECONFIGURE WITH OVERRIDE




--USE nyctaxi
--GO
--GRANT EXECUTE ANY EXTERNAL SCRIPT  TO [UserName]