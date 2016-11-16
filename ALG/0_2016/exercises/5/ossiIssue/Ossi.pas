PROGRAM Ossi;

TYPE
	Person = (anton, berta, clemens, doris);
	Visitors = ARRAY[Person] OF BOOLEAN;

FUNCTION Valid(VAR v: Visitors): BOOLEAN;
	VAR ossiHappy: BOOLEAN;
		everybodyOkay: BOOLEAN;
BEGIN
	ossiHappy := FALSE;
	everybodyOkay := TRUE;

	IF v[anton] = TRUE THEN BEGIN
		everybodyOkay := (NOT v[doris]);
	END
	ELSE BEGIN
		everybodyOkay := (v[clemens] XOR v[doris]);
	END;

	IF (v[berta] = TRUE) AND (everybodyOkay = TRUE) THEN BEGIN
		everybodyOkay := v[clemens];
	END;

	IF (v[anton] = TRUE) AND (v[clemens] = TRUE) AND (everybodyOkay = TRUE) THEN BEGIN
		everybodyOkay := (NOT v[berta]);
	END;
	
	IF (v[anton] = TRUE) OR (v[berta] = TRUE) OR (v[clemens] = TRUE) OR (v[doris] = TRUE) THEN BEGIN
		ossiHappy := TRUE;
	END;

	IF (ossiHappy = TRUE) AND (everybodyOkay = TRUE) THEN BEGIN
		Valid := TRUE;
	END
	ELSE BEGIN
		Valid := FALSE;
	END;
END;

PROCEDURE PrintResults(VAR v: Visitors);
	VAR i: Person;
BEGIN
	WriteLn('---');
	FOR i := anton TO doris DO BEGIN
		Write(v[i], ' ');
	END;
END;

VAR
	v: Visitors;
	a, b, c, d: BOOLEAN;
BEGIN
	FOR a := FALSE TO TRUE DO BEGIN
		v[anton] := a;
		FOR b := FALSE TO TRUE DO BEGIN
			v[berta] := b;
			FOR c := FALSE TO TRUE DO BEGIN
				v[clemens] := c;
				FOR d := FALSE TO TRUE DO BEGIN
					v[doris] := d;
					IF Valid(v) THEN BEGIN
						PrintResults(v);
						WriteLn('');
					END;
				END;
			END;
		END;
	END;
END.