GO
DECLARE @Tran2 VARCHAR(20),
		@prevent int,
		@sum1 int,
		@sum2 int;
SELECT @Tran2 = 'T2';
BEGIN TRANSACTION @Tran2;
	SELECT @sum1 = sum(f2) FROM ToCheck
	WAITFOR DELAY '00:00:06';
	SELECT @sum2 = sum(f2) FROM ToCheck
COMMIT TRANSACTION @Tran2;

set @prevent = 1;
if (@sum1!=@sum2) BEGIN set @prevent = 0; END
INSERT INTO Results (isolationLevel) VALUES (@prevent);



