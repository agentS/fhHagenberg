PROGRAM DynamicArrays;

CONST MAX_SIZE = 62;
	MAX_LENGTH = 50;

TYPE
	Text = STRING[MAX_LENGTH];
	FixStringArray = ARRAY[1..MAX_SIZE] OF Text;
	FlexStringArray = ARRAY [1..1] OF Text;

VAR
	//sfix: FixStringArray;
	pfix: ^FixStringArray;
	pflex: ^FlexStringArray;
	i, count: WORD;
BEGIN
	New(pfix);

	FOR i := 1 TO MAX_SIZE DO BEGIN
		pfix^[i] := Chr(Ord('A') + i - 1);
	END;

	FOR i := 1 TO MAX_SIZE DO BEGIN
		Write(pfix^[i]);
	END;
	WriteLn('');

	Dispose(pfix);

	count := 30;
	GetMem(pflex, count * SizeOf(Text));

	(*$R-*)
	FOR i := 0 TO count - 1 DO BEGIN
		pflex^[i] := Chr(Ord('A') + i);
	END;
	FOR i := 0 TO count - 1 DO BEGIN
		Write(pflex^[i]);
	END;
	(*$R+*)

	WriteLn('');
	FreeMem(pflex, count * SizeOf(Text));
END.