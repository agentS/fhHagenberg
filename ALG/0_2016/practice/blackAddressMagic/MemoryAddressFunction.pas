PROGRAM MemoryAddressFunction;

CONST LOWER_INDEX = 1;
	UPPER_INDEX = 10;
	LOWER_1D = 1;
	UPPER_1D = 3;
	LOWER_2D = 1;
	UPPER_2D = 4;

TYPE IntegerArray = ARRAY [LOWER_INDEX..UPPER_INDEX] OF INTEGER;

FUNCTION MAF1D(startAddr: LONGINT; index, typeSize: INTEGER): LONGINT;
BEGIN
	MAF1D := startAddr + ((index - LOWER_INDEX) * typeSize);
END;

FUNCTION MAF2D(startAddr: LONGINT; i, j, typeSize: INTEGER): LONGINT;
BEGIN
	MAF2D := startAddr
		+ ((i - LOWER_1D) * (UPPER_2D - LOWER_2D + 1) * typeSize)
		+ ((j - LOWER_2D) * typeSize);
END;

VAR a: IntegerArray;
	m: ARRAY[LOWER_1D..UPPER_1D, LOWER_2D..UPPER_2D] OF INTEGER;
BEGIN
	WriteLn('@a: ', LONGINT(@a));
	WriteLn('MAF1D(a, 3): ', MAF1D(LONGINT(@a), 3, SizeOf(INTEGER)));
	WriteLn('@a[3]: ', LONGINT(@a[3]));
	WriteLn('@a[10]: ', LONGINT(@a[10]));

	WriteLn('@m: ', LONGINT(@m));
	WriteLn('@m[1, 1]: ', LONGINT(@m[LOWER_1D, LOWER_2D]));
	WriteLn('@m[3, 2]: ', LONGINT(@m[3, 2]));
	WriteLn('MAF2D(m, 3, 2): ', MAF2D(LONGINT(@m), 3, 2, SizeOf(INTEGER)));

	WriteLn('@m[1, 4]: ', LONGINT(@m[1, 4]));
	WriteLn('MAF2D(m, 1, 4): ', MAF2D(LONGINT(@m), 1, 4, SizeOf(INTEGER)));

	WriteLn('@m[2, 1]: ', LONGINT(@m[2, 1]));
	WriteLn('MAF2D(m, 2, 1): ', MAF2D(LONGINT(@m), 2, 1, SizeOf(INTEGER)));
END.