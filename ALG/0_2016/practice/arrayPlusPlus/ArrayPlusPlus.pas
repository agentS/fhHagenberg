PROGRAM ArrayPlusPlus;

CONST MAX_SIZE = 10;

TYPE IntegerArray = ARRAY [1..MAX_SIZE] OF INTEGER;

PROCEDURE InitArray(VAR arrayToInitialise: IntegerArray; initValue: INTEGER);
	VAR i: INTEGER;
BEGIN
	FOR i := 1 TO MAX_SIZE DO BEGIN
		arrayToInitialise[i] := initValue;
	END;
END;

PROCEDURE PrintArray(VAR arrayToPrint: IntegerArray);
	VAR i: INTEGER;
BEGIN
	FOR i := 1 TO MAX_SIZE DO BEGIN
		WriteLn(i - 1, ': ', arrayToPrint[i]);
	END;
END;

VAR arrayA: IntegerArray;

BEGIN
	InitArray(arrayA, 0);
	PrintArray(arrayA);
	InitArray(arrayA, 10);
	PrintArray(arrayA);
END.