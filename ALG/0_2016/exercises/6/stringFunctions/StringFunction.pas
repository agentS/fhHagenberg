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

	s[0] := Char(inputLength - deleteCount);
END;


FUNCTION BadCharacterJump(pattern: STRING; badCharacter: CHAR): WORD;
	VAR i: INTEGER;
BEGIN
	i := Length(pattern);
	WHILE (i > 0) AND (pattern[i] <> badCharacter) DO BEGIN
		i := i - 1;
	END;
	IF i > 0 THEN BEGIN
		BadCharacterJump := i;
	END
	ELSE BEGIN
		BadCharacterJump := Length(pattern);
	END;
END;


FUNCTION IndexOf(input: STRING; pattern: STRING): WORD;
	VAR patternLength, inputLength: WORD;
		jumpDistance: WORD;
		i, j, actualPositionInput: INTEGER;
BEGIN
	inputLength := Length(input);
	patternLength := Length(pattern);
	i := patternLength;
	actualPositionInput := 1;
	j := i;

	WHILE (i <= inputLength) AND (j <> actualPositionInput) DO BEGIN
		j := i;
		WHILE (j >= actualPositionInput) AND (pattern[j - actualPositionInput] = input[j]) DO BEGIN
			j := j - 1;
		END;
		IF j = actualPositionInput THEN BEGIN
			(* pattern found *)
			IndexOf := actualPositionInput + 1;
		END
		ELSE BEGIN
			jumpDistance := BadCharacterJump(pattern, input[j]);
			i := i + jumpDistance;
			actualPositionInput := actualPositionInput + jumpDistance;
		END;
	END;
END;


PROCEDURE ShiftToRightAndInsert(charactersToInsert: STRING; startIndexStringToInsert, charactersToShift, startIndexCompleteString: WORD; VAR input: STRING);
	VAR i, j: WORD;
		inputLength: WORD;
BEGIN
	inputLength := Length(input);
	IF (inputLength + charactersToShift) <= High(String) THEN BEGIN
		(* shift the characters of the old string to the right *)
		i := inputLength;
		j := inputLength + charactersToShift;
		
		WHILE i >= startIndexCompleteString DO BEGIN
			input[j] := input[i];
			i := i - 1;
			j := j - 1;
		END;

		(* insert the characters of the new string *)
		j := 1;
		WHILE j <= charactersToShift DO BEGIN
			input[i] := charactersToInsert[j];
			i := i + 1;
			j := j + 1;
		END;
	END;
END;


PROCEDURE ShiftToLeft(startIndex, charactersToRemove: WORD; VAR input: STRING);
	VAR i, j: WORD;
		inputLength: WORD;
BEGIN
	inputLength := Length(input);
	i := startIndex;
	j := startIndex + charactersToRemove;
	
	WHILE (i <= inputLength) AND (j <= inputLength) DO BEGIN
		input[i] := input[j];
		i := i + 1;
		j := j + 1;
	END;
	input[0] := Char(i - charactersToRemove);
END;


PROCEDURE ReplaceString(new: STRING; oldStringLength, startIndex: WORD; VAR input: STRING);
	VAR i, j: WORD;
		oldStringEndIndex: WORD;
		newStringEndIndex: WORD;
BEGIN
	i := startIndex;
	j := 1;
	oldStringEndIndex := oldStringLength + startIndex;
	newStringEndIndex := Length(new) + startIndex;

	WHILE (i <= oldStringEndIndex) AND (i <= newStringEndIndex) DO BEGIN
		input[i] := new[j];
		i := i + 1;
		j := j + 1;
	END;
	IF i <= newStringEndIndex THEN BEGIN
		(*
			The new word is longer than the one to replace.
			Shift the old characters to the right and insert the remaining characters of the actual word.
		*)
		ShiftToRightAndInsert(new, i - startIndex, Length(new) - (i - startIndex), i, input);
	END
	ELSE IF i <= oldStringEndIndex THEN BEGIN
		(*
			The old word is longer than the one to replace.
			Shift the old characters to the left to fill the gap.
		*)
		ShiftToLeft(i, oldStringEndIndex - newStringEndIndex - 1, input);
	END;
END;


PROCEDURE ReplaceAll(old, new: STRING; VAR s: STRING);
	VAR indexStringToReplace: WORD;
BEGIN
	indexStringToReplace := 1;
	REPEAT
		indexStringToReplace := IndexOf(s, old);
		WriteLn(indexStringToReplace);
		IF indexStringToReplace <> 0 THEN BEGIN
			ReplaceString(new, Length(old), indexStringToReplace, s);
		END
	UNTIL indexStringToReplace = 0;
END;


VAR demoString: STRING;
BEGIN
	(*
	WriteLn(Reversed('Andi'));
	WriteLn(Reversed('Lukas'));
	WriteLn(Reversed(''));
	WriteLn(Reversed('X'));
	*)

	demoString := 'Ahoi, Ahoi, Matrosen. Alles An Board! Sind Alle An Board, Geht Es In Die Kombuese!';
	(*
	StripBlanks(demoString);
	WriteLn(demoString);
	*)

	ReplaceAll('Board', 'antreten', demoString);
	WriteLn(demoString);
END.