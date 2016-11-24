UNIT FloatingMeanLib;

INTERFACE
	FUNCTION Mean(value: SMALLINT): REAL;


IMPLEMENTATION
	VAR
		count: SMALLINT;
		sum: LONGINT;


	FUNCTION Mean(value: SMALLINT): REAL;
	BEGIN
		Inc(count);
		sum := sum + value;

		Mean := sum / count;
	END;


BEGIN
	sum := 0;
	count := 0;
END.