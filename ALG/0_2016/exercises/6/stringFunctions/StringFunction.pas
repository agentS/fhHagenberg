PROGRAM StringFunctions;

FUNCTION Ceil(a: REAL): SMALLINT;
	VAR intPart: LONGINT;
BEGIN
	intPart := Trunc(a);
	IF Frac(a) > 0 THEN BEGIN
		Ceil := intPart + 1;
	END
	ELSE BEGIN
		Ceil := intPart;
	END;
END;

FUNCTION Reversed(input: STRING): STRING;
	VAR halfLength, inputLength: WORD;
		i: WORD;
		reversedString: STRING;
BEGIN
	halfLength := Ceil(Length(input) / 2);
	inputLength := Length(input);
	FOR i := 1 TO halfLength DO BEGIN
		reversedString[inputLength - i + 1] := input[i];
		reversedString[i] := input[inputLength - i + 1];
	END;
	reversedString[0] := Char(inputLength);
	Reversed := reversedString;
END;

PROCEDURE StripBlanks(VAR s: STRING);
	VAR i, inputLength: WORD;
		deleteCount: WORD;
		j: WORD;
BEGIN
	i := 1;
	deleteCount := 0;
	inputLength := Length(s);
	WHILE i <= inputLength DO BEGIN
		IF s[i] = ' ' THEN BEGIN
			(* shift the remaining characters left *)
			j := i + 1;
			WHILE j <= inputLength DO BEGIN
				s[j - 1] := s[j];
				j := j + 1;
			END;
			deleteCount := deleteCount + 1;
		END (* IF *)
		ELSE BEGIN
			i := i + 1;
		END;
	END; (* WHILE *)
	WriteLn('i: ', i);
	WriteLn('length: ', inputLength);
	s[0] := Char(inputLength - deleteCount);
END;

VAR demoString: STRING;
BEGIN
	(*
	WriteLn(Reversed('Andi'));
	WriteLn(Reversed('Lukas'));
	WriteLn(Reversed(''));
	WriteLn(Reversed('X'));
	*)

	demoString := 'Ahoi, Ahoi, Matrosen. Alles An Board!                   Danach    In Die Kombuese!';
	StripBlanks(demoString);
	WriteLn(demoString);
END.