PROGRAM SequentialSearch;

FUNCTION IsElement(VAR a: ARRAY OF INTEGER; x: INTEGER): BOOLEAN;
	VAR i: INTEGER;
BEGIN
	i := 0;
	WHILE (i <= High(a)) AND (a[i] <> x) DO BEGIN
		i := i + 1;
	END;
	IF i <= High(a) THEN BEGIN
		IsElement := TRUE;
	END
	ELSE BEGIN
		IsElement := FALSE;
	END;
END;

VAR test: ARRAY[0..5] OF INTEGER;
BEGIN
	test[0] := 15;
	test[1] := 18;
	test[2] := 3;
	test[3] := 1180;
	test[4] := 84;
	test[5] := 2;
	WriteLn(IsElement(test, 18));
	WriteLn(IsElement(test, 17));
END.