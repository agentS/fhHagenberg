PROGRAM ArrayMerge;

FUNCTION Max2(valueA, valueB: INTEGER): INTEGER;
BEGIN
	IF valueA > valueB THEN BEGIN
		Max2 := valueA;
	END
	ELSE BEGIN
		Max2 := valueB;
	END;
END;

PROCEDURE AppendToArray(VAR sourceArray, destinationArray: ARRAY OF INTEGER; sourceIndex: INTEGER; VAR destinationLength: INTEGER);
	VAR i: WORD;
		sourceArrayLength: WORD;
BEGIN
	sourceArrayLength := High(sourceArray) + 1;
	i := sourceIndex;
	WHILE i < sourceArrayLength DO BEGIN
		destinationArray[destinationLength] := sourceArray[i];
		i := i + 1;
		destinationLength := destinationLength + 1;
	END;
END;

PROCEDURE Merge(a0, a1: ARRAY OF INTEGER; VAR a2: ARRAY OF INTEGER; VAR n2: INTEGER);
	VAR i, j: WORD;
		lengthA0, lengthA1: WORD;
		previousDigitA0, previousDigitA1: INTEGER;
BEGIN
	i := Low(a0);
	j := Low(a1);
	lengthA0 := High(a0) + 1;
	lengthA1 := High(a1) + 1;

	(* iterate through both fields to check their common values *)
	WHILE (i < lengthA0) AND (j < lengthA1) DO BEGIN
		IF a0[i] < a1[j] THEN BEGIN
			IF a0[i] <> previousDigitA1 THEN BEGIN
				a2[n2] := a0[i];
				n2 := n2 + 1;
			END;
			i := i + 1;
			previousDigitA0 := a0[i];
		END
		ELSE IF a0[i] > a1[j] THEN BEGIN
			IF a1[j] <> previousDigitA0 THEN BEGIN
				a2[n2] := a1[j];
				n2 := n2 + 1;
			END;
			j := j + 1;
		END
		ELSE BEGIN
			previousDigitA0 := a0[i];
			previousDigitA1 := a1[j];
			j := j + 1;
			i := i + 1;
		END;
	END;

	(* add the eventually remaining elements of array 0 *)
	AppendToArray(a0, a2, i, n2);

	(* add the eventually remaining elements of array 1 *)
	AppendToArray(a1, a2, j, n2);
END;

PROCEDURE PrintArray(VAR arrayToPrint: ARRAY OF INTEGER; arrayLength: INTEGER);
	VAR i: WORD;
BEGIN
	FOR i := Low(arrayToPrint) TO (arrayLength - 1) DO BEGIN
		Write(arrayToPrint[i], ' ');
	END;
	WriteLn('');
END;

VAR a0: ARRAY [0..5] OF INTEGER;
	a1: ARRAY [0..3] OF INTEGER;
	resultArray: ARRAY[0..4] OF INTEGER;
	resultArrayLength: INTEGER;
BEGIN
	resultArrayLength := 0;
	a0[0] := 2;
	a0[1] := 4;
	a0[2] := 4;
	a0[3] := 10;
	a0[4] := 15;
	a0[5] := 15;
	a1[0] := 3;
	a1[1] := 4;
	a1[2] := 5;
	a1[3] := 10;

	Merge(a0, a1, resultArray, resultArrayLength);
	PrintArray(resultArray, resultArrayLength);
END.