PROGRAM ArrayPlusPlus;

CONST MAX_SIZE = 10;

TYPE IntegerArray_1_10 = ARRAY [1..MAX_SIZE] OF INTEGER;
	IntegerArray_a_z = ARRAY['a'..'z'] OF INTEGER;
	DynamicIntegerArray = ARRAY [0..10] OF INTEGER;
	DynamicIntegerArrayCharIndex = ARRAY [CHAR] OF INTEGER;

PROCEDURE InitArray(VAR arrayToInitialise: ARRAY OF INTEGER; initValue: INTEGER);
	VAR i: INTEGER;
BEGIN
	FOR i := Low(arrayToInitialise) TO High(arrayToInitialise) DO BEGIN
		arrayToInitialise[i] := initValue;
	END;
END;

PROCEDURE PrintArray(VAR arrayToPrint: ARRAY OF INTEGER);
	VAR i: INTEGER;
BEGIN
	FOR i := Low(arrayToPrint) TO High(arrayToPrint) DO BEGIN
		WriteLn(i, ': ', arrayToPrint[i]);
	END;
END;

FUNCTION SumArray(VAR arrayToSum: ARRAY OF INTEGER): LONGINT;
	VAR i: WORD;
		sum: LONGINT;
BEGIN
	sum := 0;
	FOR i := Low(arrayToSum) TO High(arrayToSum) DO BEGIN
		sum := sum + arrayToSum[i];
	END;
	SumArray := sum;
END;

FUNCTION MultArray(VAR arrayToMultiply: ARRAY OF INTEGER; length: WORD): LONGINT;
	VAR i: WORD;
		product: LONGINT;
BEGIN
	IF (length - 1) <= High(arrayToMultiply) THEN BEGIN
		product := 1;
		FOR i := Low(arrayToMultiply) TO (length - 1) DO BEGIN
			product := product * arrayToMultiply[i];
		END;
		MultArray := product;
	END
	ELSE BEGIN
		MultArray := (-1);
	END;
END;

VAR arrayA: DynamicIntegerArray;
	arrayB: DynamicIntegerArrayCharIndex;

BEGIN
	InitArray(arrayA, 0);
	PrintArray(arrayA);
	InitArray(arrayA, 10);
	PrintArray(arrayA);
	InitArray(arrayB, 42);
	PrintArray(arrayB);
	
	arrayA[6] := 0;
	WriteLn(SumArray(arrayA));
	WriteLn(MultArray(arrayA, High(arrayA)));
	WriteLn(MultArray(arrayA, 6));
	WriteLn(MultArray(arrayA, 12));
END.