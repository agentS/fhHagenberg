(*$B+*)

PROGRAM SequentialSearch;

FUNCTION IsElement(VAR a: ARRAY OF INTEGER; x: INTEGER): BOOLEAN;
	VAR i: INTEGER;
		elementFound: BOOLEAN;
BEGIN
	i := 0;
	WHILE (i <= High(a)) AND (elementFound = FALSE) DO BEGIN
		IF a[i] = x THEN BEGIN
			elementFound := TRUE;
			i := High(a);
		END
		ELSE BEGIN
			i := i + 1;
		END;
	END;
	IsElement := elementFound;
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