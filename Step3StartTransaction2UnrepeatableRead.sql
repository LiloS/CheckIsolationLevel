GO
DECLARE @Tran2 VARCHAR(20),
		@prevent int,
		@sum1 int,
		@sum2 int;
WAITFOR DELAY '00:00:02';
SELECT @Tran2 = 'T2';
BEGIN TRANSACTION @Tran2;
	SELECT @sum1=f2 FROM ToCheck where f1=1
	WAITFOR DELAY '00:00:06';
	SELECT @sum2=f2 FROM ToCheck where f1=1
COMMIT TRANSACTION @Tran2;

set @prevent = 1;
if (@sum1!=@sum2) BEGIN set @prevent = 0; END
INSERT INTO Results (isolationLevel) VALUES (@prevent);
