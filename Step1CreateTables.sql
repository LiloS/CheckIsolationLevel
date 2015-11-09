GO
	IF OBJECT_ID('ToCheck') IS NOT NULL drop table ToCheck
	CREATE TABLE ToCheck
	(
		f1 int,
		f2 int
	);
	INSERT INTO ToCheck (f1,f2) VALUES (1,0);
	IF OBJECT_ID('Results') IS NOT NULL drop table Results
	CREATE TABLE Results
	(
		isolationLevel int
	);
